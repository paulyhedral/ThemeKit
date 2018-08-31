//
//  ThemeTests.swift
//  SwiftyBeaver
//
//  Created by Paul Schifferer on 8/31/18.
//

import XCTest

@testable import ThemeKit


class ThemeTests : XCTestCase {

    func testCopy() {

        var theme1 = Theme(id: "t1", name: "Theme 1")
        theme1.alternateTintColor = UIColor.orange
        theme1.barStyle = .blackOpaque
        theme1.buttonFont = UIFont.systemFont(ofSize: 48)
        theme1.defaultFont = UIFont.systemFont(ofSize: 148)
        theme1.labelFont = UIFont.systemFont(ofSize: 84)
        theme1.tintColor = UIColor.purple
        theme1.titleBarBackgroundColor = UIColor.green
        theme1.titleBarButtonColor = UIColor.blue
        theme1.titleBarColor = UIColor.lightGray
        theme1.titleBarFont = UIFont.systemFont(ofSize: 123)
        theme1.titleFont = UIFont.systemFont(ofSize: 32)

        var copiedTheme = Theme(id: "t2", name: "Copied Theme")
        copiedTheme.copy(from: theme1)

        XCTAssertTrue(copiedTheme.id == "t2", "Expected identifier to be 't2', got '\(copiedTheme.id).")
        XCTAssertTrue(copiedTheme.name == "Copied Theme", "Expected name to be 'Copied Theme', got '\(copiedTheme.name)'.")
        XCTAssertTrue(copiedTheme.barStyle == .blackOpaque, "Expected bar style to be 'blackOpaque', got '\(copiedTheme.barStyle)'.")
        XCTAssertTrue(copiedTheme.buttonFont.pointSize == 48, "Expected button font size to be '48', got '\(copiedTheme.buttonFont.pointSize)'.")
        XCTAssertTrue(copiedTheme.defaultFont.pointSize == 148, "Expected button font size to be '148', got '\(copiedTheme.defaultFont.pointSize)'.")
        XCTAssertTrue(copiedTheme.labelFont.pointSize == 84, "Expected button font size to be '84', got '\(copiedTheme.labelFont.pointSize)'.")
        XCTAssertTrue(copiedTheme.titleBarFont.pointSize == 123, "Expected button font size to be '123', got '\(copiedTheme.titleBarFont.pointSize)'.")
        XCTAssertTrue(copiedTheme.titleFont.pointSize == 32, "Expected button font size to be '32', got '\(copiedTheme.titleFont.pointSize)'.")
        XCTAssertEqual(copiedTheme.alternateTintColor, UIColor.orange)
        XCTAssertEqual(copiedTheme.tintColor, UIColor.purple)
        XCTAssertEqual(copiedTheme.titleBarBackgroundColor, UIColor.green)
        XCTAssertEqual(copiedTheme.titleBarButtonColor, UIColor.blue)
        XCTAssertEqual(copiedTheme.titleBarColor, UIColor.lightGray)
    }
    
}
