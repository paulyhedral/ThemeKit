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

        let d = try Data(contentsOf: url, options: [ .uncached ])

        guard let j = try JSONSerialization.jsonObject(with: d, options: []) as? [String : Any] else {
            throw ThemeLoaderError.invalidContents(url.absoluteString)
        }

        let identifier = try get("id", from: j)
        let name = try get("name", from: j)

        let style : ThemeStyle
        let s = try get("style", from: j)
        if let ts = ThemeStyle(rawValue: s) {
            log.debug("ts=\(ts)")
            style = ts
        }
        else {
            log.debug("Setting style to .dark")
            style = .dark
        }

        guard let f = j["fonts"] as? [String : String] else {
            throw ThemeLoaderError.invalidContents("fonts")
        }
        let primaryFontName = try processFont(f, named: "primary")
        let secondaryFontName = try processFont(f, named: "secondary")

        //        guard let colors = try JSONSerialization.jsonObject(with: try loadWrapperContents(fw, named: "colors"), options: []) as? [String : String] else {
        //            throw ThemeLoaderError.invalidContents("colors")
        //        }
        guard let c = j["colors"] as? [String : String] else {
            throw ThemeLoaderError.invalidContents("colors")
        }
        let mainColor = try UIColor.from(hexValue: try get("main", from: c))
        let accent1Color = try UIColor.from(hexValue: try get("accent1", from: c))
        let accent2Color = try UIColor.from(hexValue: try get("accent2", from: c))
        let background1Color = try UIColor.from(hexValue: try get("background1", from: c))
        let background2Color = try UIColor.from(hexValue: try get("background2", from: c))

        log.debug("Creating theme object.")
        var theme = Theme(id: identifier, name: name, style: style)
        theme.primaryFontName = primaryFontName
        theme.secondaryFontName = secondaryFontName
        theme.mainColor = mainColor
        theme.accent1Color = accent1Color
        theme.accent2Color = accent2Color
        theme.background1Color = background1Color
        theme.background2Color = background2Color

        return theme
    }

    open func load(id : String) throws -> Theme {
        log.info("Loading theme using identifier '\(id)'.")
        let url = baseURL.appendingPathComponent("\(id).theme")
        return try self.load(url: url)
    }

    //    private func loadWrapperContents(_ wrapper : FileWrapper, named name : String) throws -> Data {
    //        log.debug("\(#function): wrapper=\(wrapper), name=\(name)")
    //        guard let wrappers = wrapper.fileWrappers else {
    //            throw ThemeLoaderError.missingContents("file-wrapper")
    //        }
    //        let filename = "\(name).json"
    //        guard let w = wrappers[filename] else {
    //            throw ThemeLoaderError.missingContents(filename)
    //        }
    //        guard let d = w.regularFileContents else {
    //            throw ThemeLoaderError.invalidContents(filename)
    //        }
    //
    //        return d
    //    }
    
    private func processFont(_ json : [String : Any], named name : String) throws -> String {
        log.debug("\(#function): json=\(json), name=\(name)")
        //        guard let fontInfo = json[name] as? [String : Any] else {
        //            throw ThemeLoaderError.missingContents(name)
        //        }
        guard let fontName = json[name] as? String else {
            throw ThemeLoaderError.invalidContents(name)
        }
        //        guard let fontSize = fontInfo["size"] as? Float else {
        //            throw ThemeLoaderError.invalidContents("size")
        //        }
        let fontSize : CGFloat = 17
        guard let font = UIFont(name: fontName, size: fontSize) else {
            throw ThemeLoaderError.invalidContents("\(fontName)/\(fontSize)")
        }

        return font.familyName
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
