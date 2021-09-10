//
//  AttributedStringTests.swift
//  GitHubSearchTests
//
//  Created by Lang Ádám on 2021. 09. 09..
//

import XCTest
@testable import GitHubSearch

class AttributedStringTests: XCTestCase {

    func testAttributesSettings() throws {
        let str = NSMutableAttributedString(string: "", attributes: nil)
        XCTAssertTrue(str.fontSize == 12)
        XCTAssertTrue(str.boldFont == UIFont.boldSystemFont(ofSize: 12))
        XCTAssertTrue(str.normalFont == UIFont.systemFont(ofSize: 12))
    }

    func testBold() throws {
        let str = NSMutableAttributedString(string: "", attributes: nil)
        str.bold("asd")
        XCTAssertTrue(str.length == 3)
        let attributes = str.attributes(at: 0, effectiveRange: nil)
        let font = attributes[NSAttributedString.Key.font]
        XCTAssertTrue(font as! NSObject == UIFont.boldSystemFont(ofSize: 12))
    }

    func testNormal() throws {
        let str = NSMutableAttributedString(string: "", attributes: nil)
        str.normal("ddaa")
        XCTAssertTrue(str.length == 4)
        let attributes = str.attributes(at: 0, effectiveRange: nil)
        let font = attributes[NSAttributedString.Key.font]
        XCTAssertTrue(font as! NSObject == UIFont.systemFont(ofSize: 12))
    }

}
