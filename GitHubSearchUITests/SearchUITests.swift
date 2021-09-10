//
//  GitHubSearchUITests.swift
//  GitHubSearchUITests
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import XCTest

class SearchUITests: XCTestCase {
    let app = XCUIApplication()

    func testSearchCheckElements() throws {
        app.launchArguments = ["TEST"]
        // When I launch the app
        app.launch()
        // Then search UI should show
        // - a textfield
        // - a no results
        // - a suggestion text
        XCTAssertEqual(app.searchFields.count, 1)
        XCTAssertEqual(app.collectionViews.firstMatch.cells.count, 0)
        let text = "Use search bar to search repos"
        XCTAssertEqual(app.staticTexts[text].exists, true)
    }

    func testSearchResultUsingSearchBar() throws {
        app.launchArguments = ["TEST"]
        // When I launch the app
        app.launch()
        // Then I click on text search field
        app.searchFields.firstMatch.tap()
        // And I type some text
        app.typeText("s")
        // Then I wait for results
        sleep(5)
        // Then 2 result should pop up from the mock
        XCTAssertTrue(app.collectionViews.firstMatch.cells.count > 1)
    }

    func testSearchToDetailsNavigation() throws {
        app.launchArguments = ["TEST"]
        // When I launch the app
        app.launch()
        // Then I click on text search field
        app.searchFields.firstMatch.tap()
        // And I type some text
        app.typeText("s")
        // Then I wait for results
        sleep(5)
        // And I click on the first
        app.cells.firstMatch.tap()
        // Then it should navigate to details with webview
        XCTAssertEqual(app.webViews.firstMatch.exists, true)
    }

    func testPagingAppear() throws {
        app.launchArguments = ["TEST"]
        // When I launch the app
        app.launch()
        // Then I click on text search field
        app.searchFields.firstMatch.tap()
        // And I type some text
        app.typeText("s")
        // Then I wait for results
        sleep(5)
        // And I can see 34 result pages
        XCTAssertTrue(app.staticTexts["(1/34)"].exists)
        // And I can see the previous and next buttons are visible
        XCTAssertTrue(app.staticTexts["Next"].exists)
        XCTAssertTrue(app.staticTexts["Previous"].exists)

    }

    func testPagingFilter() throws {
        app.launchArguments = ["TEST"]
        // When I launch the app
        app.launch()
        // Then I click on text search field
        app.searchFields.firstMatch.tap()
        // And I type some text
        app.typeText("asdv")
        // Then I wait for results
        sleep(5)
        // And I can see 2 result pages
        XCTAssertTrue(app.staticTexts["(1/2)"].exists)
        // And I can see the previous and next buttons are visible
        XCTAssertTrue(app.staticTexts["Next"].exists)
        XCTAssertTrue(app.staticTexts["Previous"].exists)
    }

    func testPagingSwitchPage() throws {
        app.launchArguments = ["TEST"]
        // When I launch the app
        app.launch()
        // Then I click on text search field
        app.searchFields.firstMatch.tap()
        // And I type some text
        app.typeText("asdv")
        // Then I wait for results
        sleep(5)
        // And I can see 2 result pages
        XCTAssertTrue(app.staticTexts["(1/2)"].exists)
        // And I click on next
        app.staticTexts["Next"].tap()
        sleep(5)
        // Then it should show (2/2) next page
        XCTAssertTrue(app.staticTexts["(2/2)"].exists)
        // And I click on previous
        app.staticTexts["Previous"].tap()
        sleep(5)
        // Then it should show (1/2) next page
        XCTAssertTrue(app.staticTexts["(1/2)"].exists)
    }

}
