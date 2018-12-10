//
//  ThemeLoader.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


open class ThemeLoader {

    var baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    open func load(url : URL) throws -> Theme {
        log.info("Loading theme from URL: \(url.absoluteString).")

        let fw = try FileWrapper(url: url, options: [ .immediate, .withoutMapping ])

        guard let meta = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "meta"), options: []) as? [String : String] else {
            throw ThemeLoaderError.invalidContents("meta")
        }
        let identifier = try get("id", from: meta)
        let name = try get("name", from: meta)

        // let barStyle : UIBarStyle
        // guard let ui = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "ui"), options: []) as? [String : Any] else {
        //     throw ThemeLoaderError.invalidContents("ui")
        // }
        // if let s = ui["barStyle"] as? String,
        //     let i = Int(s),
        //     let b = UIBarStyle(rawValue: i) {
        //     log.debug("b=\(b)")
        //     barStyle = b
        // }
        // else {
        //     log.debug("Setting bar style to .black")
        //     barStyle = .black
        // }

        guard let fonts = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "fonts"), options: []) as? [String : Any] else {
            throw ThemeLoaderError.invalidContents("fonts")
        }
        let defaultFont = try processFont(fonts, named: "defaultFont")
        let secondaryFont = try processFont(fonts, named: "secondaryFont")

        guard let colors = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "colors"), options: []) as? [String : String] else {
            throw ThemeLoaderError.invalidContents("colors")
        }
        let mainColor = try UIColor.from(hexValue: try get("mainColor", from: colors))
        let accentColor = try UIColor.from(hexValue: try get("accentColor", from: colors))
        let backgroundColor = try UIColor.from(hexValue: try get("backgroundColor", from: colors))
        let secondAccentColor = try UIColor.from(hexValue: try get("secondAccentColor", from: colors))

        log.debug("Creating theme object.")
        var theme = Theme(id: identifier, name: name)
        theme.defaultFont = defaultFont
        theme.secondaryFont = secondaryFont
        theme.mainColor = mainColor
        theme.accentColor = accentColor
        theme.secondAccentColor = secondAccentColor
        theme.backgroundColor = backgroundColor

        return theme
    }

    open func load(id : String) throws -> Theme {
        log.info("Loading theme using identifier '\(id)'.")
        let url = baseURL.appendingPathComponent("\(id).theme")
        return try self.load(url: url)
    }

    private func loadWrapperContents(_ wrapper : FileWrapper, named name : String) throws -> Data {
        log.debug("\(#function): wrapper=\(wrapper), name=\(name)")
        if let wrappers = wrapper.fileWrappers,
            let w = wrappers["\(name).json"],
            let d = w.regularFileContents {
            return d
        }

        throw ThemeLoaderError.missingContents(name)
    }

    private func processFont(_ json : [String : Any], named name : String) throws -> UIFont {
        log.debug("\(#function): json=\(json), name=\(name)")
        if let fontInfo = json[name] as? [String : Any],
            let fontName = fontInfo["name"] as? String,
            let fontSize = fontInfo["size"] as? Float,
            let font = UIFont(name: fontName, size: CGFloat(fontSize)) {
            return font
        }

        throw ThemeLoaderError.missingContents(name)
    }

    private func get(_ key : String, from dict : [String : Any]) throws -> String {
        log.debug("\(#function): key=\(key), dict=\(dict)")
        if let value = dict[key] as? String {
            return value
        }

        throw ThemeLoaderError.missingContents(key)
    }

}

public enum ThemeLoaderError : Error {
    case missingContents(String)
    case invalidContents(String)
}
