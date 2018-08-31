import XCTest

@testable import ThemeKit

class ColorExtensionTests : XCTestCase {

    func testHexString() {
        let color = UIColor.white
        let s = color.hexString
        XCTAssertTrue(s == "ffffffff", "Expected 'ffffffff', got '\(s)'")
    }

    func testFromHashedHexValueWithoutAlpha() throws {

        let hexValue = "#c00bed"

        let color = try UIColor.from(hexValue: hexValue)

        try checkColorValue(color, red: "0.75", green: "0.04", blue: "0.93", alpha: "1")
    }

    func testFromHashedHexValueWithAlpha() throws {

        let hexValue = "#c00bed10"

        let color = try UIColor.from(hexValue: hexValue)

        try checkColorValue(color, red: "0.75", green: "0.04", blue: "0.93", alpha: "0.06")
    }

    func testFromHexValueWithoutAlpha() throws {

        let hexValue = "c00bed"

        let color = try UIColor.from(hexValue: hexValue)

        try checkColorValue(color, red: "0.75", green: "0.04", blue: "0.93", alpha: "1")
    }

    func testFromHexValueWithAlpha() throws {

        let hexValue = "c00bed10"

        let color = try UIColor.from(hexValue: hexValue)

        try checkColorValue(color, red: "0.75", green: "0.04", blue: "0.93", alpha: "0.06")
    }

    func testBadHexValue() throws {

        let hexValue = "wtfwtf"

        do {
            let _ = try UIColor.from(hexValue: hexValue)

            XCTFail("Should have thrown an error.")
        }
        catch Errors.invalidValue(let s, let t) {
            XCTAssertTrue(s == "wt", "Expected invalid value 'wt' message, got '\(s)'.")
            XCTAssertTrue(t is UIColor.Type, "Expected type in error to be a UIColor, was actually \(t).")
        }
        catch {
            XCTFail("Test throw an unexpected error: \(error)")
        }
    }

    func testInvalidLengthWithHash() throws {

        let hexValue = "#0a1b2c3"

        do {
            let _ = try UIColor.from(hexValue: hexValue)

            XCTFail("Should have thrown an error.")
        }
        catch Errors.invalidLength(let s, let t) {
            XCTAssertTrue(s == 7, "Expected 'invalid length' message, got '\(s)'.")
            XCTAssertTrue(t is UIColor.Type, "Expected type in error to be a UIColor, was actually \(t).")
        }
        catch {
            XCTFail("Test throw an unexpected error: \(error)")
        }
    }

    func testInvalidLengthWithoutHash() throws {

        let hexValue = "0a1b2c3"

        do {
            let _ = try UIColor.from(hexValue: hexValue)

            XCTFail("Should have thrown an error.")
        }
        catch Errors.invalidLength(let s, let t) {
            XCTAssertTrue(s == 7, "Expected 'invalid length' message, got '\(s)'.")
            XCTAssertTrue(t is UIColor.Type, "Expected type in error to be a UIColor, was actually \(t).")
        }
        catch {
            XCTFail("Test throw an unexpected error: \(error)")
        }
    }

    private func checkColorValue(_ color : UIColor, red : String, green : String, blue : String, alpha : String) throws {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = 2

        let formattedRed = formatter.string(from: NSNumber(value: Float(r)))
        XCTAssertNotNil(formattedRed)
        let formattedGreen = formatter.string(from: NSNumber(value: Float(g)))
        XCTAssertNotNil(formattedGreen)
        let formattedBlue = formatter.string(from: NSNumber(value: Float(b)))
        XCTAssertNotNil(formattedBlue)
        let formattedAlpha = formatter.string(from: NSNumber(value: Float(a)))
        XCTAssertNotNil(formattedAlpha)

        XCTAssertTrue(formattedRed == red, "Expected '\(red)', got '\(String(describing: formattedRed))'")
        XCTAssertTrue(formattedGreen == green, "Expected '\(green)', got '\(String(describing: formattedGreen))'")
        XCTAssertTrue(formattedBlue == blue, "Expected '\(blue)', got '\(String(describing: formattedBlue))'")
        XCTAssertTrue(formattedAlpha == alpha, "Expected '\(alpha)', got '\(String(describing: formattedAlpha))'")
    }
}
