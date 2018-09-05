//
//  ThemeManagerTests.swift
//  ThemeKitTests
//
//  Created by Paul Schifferer on 8/31/18.
//

import XCTest

@testable import ThemeKit


class ThemeManagerTests : XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialTheme() {
        let thm = ThemeManager()

        let theme = thm.currentTheme

        XCTAssertTrue(theme.id == ThemeIdentifier.default.rawValue, "Expected \(ThemeIdentifier.default.rawValue) for current theme; got \(theme.id).")
    }

    // func testAddTheme() throws {
    //     let thm = ThemeManager()

    //     let theme = Theme(id: "test1", name: "Test 1")
    //     try thm.save(theme: theme)

    //     let t = thm.theme(id: "test1")
    //     XCTAssertNotNil(t)
    //     XCTAssertTrue(t?.id == "test1", "Expected theme 'test1', got \(String(describing: t?.id)).")

    //     let themes = thm.allThemes()
    //     XCTAssertTrue(themes.count == 1, "Expected 1 theme, got \(themes.count).")
    // }

    func testCurrentTheme() {
        let thm = ThemeManager()

        let t1 = thm.currentTheme
        XCTAssertTrue(t1.id == ThemeIdentifier.default.rawValue, "Expected theme '\(ThemeIdentifier.default.rawValue)', got '\(t1.id)'.")

        let theme = Theme(id: "test1", name: "Test 1")
        thm.currentTheme = theme

        let t2 = thm.currentTheme
        XCTAssertTrue(t2.id == "test1", "Expected theme 'test1', got '\(t2.id)'.")
    }

}
