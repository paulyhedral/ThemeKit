//
//  ThemeReader.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import Foundation


open class ThemeReader {

    var baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    open func load(url : URL) throws -> Theme {
        let fw = try FileWrapper(url: url, options: [ .immediate, .withoutMapping ])

        guard let meta = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "meta"), options: []) as? [String : String] else {
            throw ThemeReaderError.invalidContents("meta")
        }
        let identifier = try get("id", from: meta)
        let name = try get("name", from: meta)

        #if os(iOS)
        let barStyle : UIBarStyle
        guard let ui = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "ui"), options: []) as? [String : Any] else {
            throw ThemeReaderError.invalidContents("ui")
        }
        if let s = ui["barStyle"] as? String,
            let i = Int(s),
            let b = UIBarStyle(rawValue: i) {
            barStyle = b
        }
        else {
            barStyle = .black
        }
        #endif

        //        let iconImage : Image? = nil // TODO: icon image
        //        let backgroundImage : Image? = nil // TODO: background image

        guard let fonts = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "fonts"), options: []) as? [String : Any] else {
            throw ThemeReaderError.invalidContents("fonts")
        }
        let defaultFont = try processFont(fonts, named: "defaultFont")
        let labelFont = try processFont(fonts, named: "labelFont")
        let titleBarFont = try processFont(fonts, named: "titleBarFont")
        let buttonFont = try processFont(fonts, named: "buttonFont")
        let titleFont = try processFont(fonts, named: "titleFont")

        guard let colors = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "colors"), options: []) as? [String : String] else {
            throw ThemeReaderError.invalidContents("colors")
        }
        let tintColor = try Color.from(hexValue: try get("tintColor", from: colors))
        let alternateTintColor = try Color.from(hexValue: try get("alternateTintColor", from: colors))
        let titleBarBackgroundColor = try Color.from(hexValue: try get("titleBarBackgroundColor", from: colors))
        let titleBarColor = try Color.from(hexValue: try get("titleBarColor", from: colors))
        let titleBarButtonColor = try Color.from(hexValue: try get("titleBarButtonColor", from: colors))

        var theme = Theme(id: identifier, name: name)
        theme.defaultFont = defaultFont
        theme.labelFont = labelFont
        theme.titleBarFont = titleBarFont
        theme.buttonFont = buttonFont
        theme.titleFont = titleFont
        theme.tintColor = tintColor
        theme.alternateTintColor = alternateTintColor
        theme.titleBarColor = titleBarColor
        theme.titleBarButtonColor = titleBarButtonColor
        theme.titleBarBackgroundColor = titleBarBackgroundColor
        #if os(iOS)
        theme.barStyle = barStyle
        #endif

        return theme
    }

    open func load(id : String) throws -> Theme {
        let url = baseURL.appendingPathComponent("\(id).theme")
        return try self.load(url: url)
    }

    private func loadWrapperContents(_ wrapper : FileWrapper, named name : String) throws -> Data {
        if let wrappers = wrapper.fileWrappers,
            let w = wrappers["\(name).json"],
            let d = w.regularFileContents /*,
         let s = String(data: d, encoding: .utf8) */ {
            return d
        }

        throw ThemeReaderError.missingContents(name)
    }

    private func processFont(_ json : [String : Any], named name : String) throws -> Font {
        if let fontInfo = json[name] as? [String : Any],
            let fontName = fontInfo["name"] as? String,
            let fontSize = fontInfo["size"] as? Float,
            let font = Font(name: fontName, size: CGFloat(fontSize)) {
            return font
        }

        throw ThemeReaderError.missingContents(name)
    }

    private func get(_ key : String, from dict : [String : Any]) throws -> String {
        if let value = dict[key] as? String {
            return value
        }

        throw ThemeReaderError.missingContents(key)
    }

}

public enum ThemeReaderError : Error {
    case missingContents(String)
    case invalidContents(String)
}
