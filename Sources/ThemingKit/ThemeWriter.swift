//
//  ThemeWriter.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit
import Logging


fileprivate let logger = Logger(label: Constants.logPrefix+"ThemeWriter")

public class ThemeWriter {

    private let url : URL
    //    private let fileWrapper : FileWrapper

    public init(url : URL) {
        self.url = url
        //        self.fileWrapper = FileWrapper(directoryWithFileWrappers: [:])
    }

    public func write(theme : Theme) throws {
        logger.debug("\(#function): theme=\(theme)")

        let json : [String : Any] = [
            "id": theme.id,
            "name": theme.name,
            "style": "\(theme.style.rawValue)",
            "colors": [
                "main": theme.mainColor.hexString(componentSize: 2, withAlpha: true),
                "accent1": theme.accent1Color.hexString(componentSize: 2, withAlpha: true),
                "accent2": theme.accent2Color.hexString(componentSize: 2, withAlpha: true),
                "background1": theme.background1Color.hexString(componentSize: 2, withAlpha: true),
                "background2": theme.background2Color.hexString(componentSize: 2, withAlpha: true),
            ],
            "fonts": [
                "primary": theme.primaryFontName,
                "secondary": theme.secondaryFontName,
            ]
        ]
        logger.debug("json=\(json)")
        //        let meta : [String : String] = [
        //        ]
        //        self.fileWrapper.addRegularFile(withContents: try jsonToData(meta), preferredFilename: "meta.json")
        //
        //         let ui : [String : String] = [
        //         ]
        //         logger.debug("Adding ui.json file to wrapper.")
        //         self.fileWrapper.addRegularFile(withContents: try jsonToData(ui), preferredFilename: "ui.json")
        //
        //        let fonts : [String : Any] = [
        //            "defaultFont": buildFontInfo(theme.defaultFont),
        //            "defaultBoldFont": buildFontInfo(theme.defaultBoldFont),
        //            "secondaryFont": buildFontInfo(theme.secondaryFont),
        //            "secondaryBoldFont": buildFontInfo(theme.secondaryBoldFont),
        //        ]
        //        logger.debug("Adding fonts.json file to wrapper.")
        //        self.fileWrapper.addRegularFile(withContents: try jsonToData(fonts), preferredFilename: "fonts.json")
        //
        //        let colors : [String : String] = [
        //            "mainColor": theme.mainColor.hexString(),
        //            "accentColor": theme.accentColor.hexString(),
        //            "secondAccentColor": theme.secondAccentColor.hexString(),
        //            "backgroundColor": theme.backgroundColor.hexString(),
        //        ]
        //        logger.debug("Adding colors.json file to wrapper.")
        //        self.fileWrapper.addRegularFile(withContents: try jsonToData(colors), preferredFilename: "colors.json")

        let data = try jsonToData(json)
        logger.debug("data=\(data)")

        logger.info("Writing file wrapper to URL \(self.url)...")
        try data.write(to: self.url, options: [ .atomic ])
    }

    //    private func buildFontInfo(_ font : UIFont) -> [String : Any] {
    //        let fontInfo : [String : Any] = [
    //            "name": font.familyName,
    //            "size": Float(font.pointSize),
    //        ]
    //        return fontInfo
    //    }

    private func jsonToData(_ json : [String : Any]) throws -> Data {
        var options : JSONSerialization.WritingOptions = [ .prettyPrinted ]
        if #available(iOS 11.0, *) {
            options.update(with: [ .sortedKeys ])
        }
        return try JSONSerialization.data(withJSONObject: json, options: options)
    }
}
