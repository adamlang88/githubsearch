//
//  GitHubSearchTests.swift
//  GitHubSearchTests
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking
@testable import GitHubSearch

class SearchViewModelTests: XCTestCase {

    var model = Injector.resolve(SearchViewModel.self)
    var disposeBag = DisposeBag()

    func testSearchWithSomeSearchKeyword() throws {
        let keyword = "k"
        var resCount = -1
        model?.repositoryData
            .observe(on: MainScheduler.instance)
            .subscribe({ data in
                resCount = data.element?.count ?? 0
            }).disposed(by: disposeBag)
        model?.refreshData(searchTerm: keyword)
        sleep(2)
        XCTAssertEqual(resCount,2)
    }

    func testSearchWithEmptySearchKeyword() throws {
        let keyword = ""
        var resCount = -1
        model?.repositoryData
            .observe(on: MainScheduler.instance)
            .subscribe({ data in
                resCount = data.element?.count ?? 0
            }).disposed(by: disposeBag)
        model?.refreshData(searchTerm: keyword)
        sleep(2)
        XCTAssertEqual(resCount,0)
    }

    func testSearchApiError() throws {
        let keyword = "apierror"
        var error = false
        model?.repositoryDataError
            .observe(on: MainScheduler.instance)
            .subscribe({ data in
                error = true
            }).disposed(by: disposeBag)
        model?.refreshData(searchTerm: keyword)
        sleep(2)
        XCTAssertTrue(error)
    }

    func testGetStargazers() throws {
        XCTAssertEqual(try model?.getStarCount(url: "").toBlocking().first()?.result.count,2)
    }

}
