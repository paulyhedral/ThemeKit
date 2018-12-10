//
//  ThemeWriter.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


public class ThemeWriter {

    private let url : URL
    private let fileWrapper : FileWrapper

    public init(url : URL) {
        self.url = url
        self.fileWrapper = FileWrapper(directoryWithFileWrappers: [:])
    }

    public func write(theme : Theme) throws {
        log.debug("\(#function): theme=\(theme)")

        let meta : [String : String] = [
            "id": theme.id,
            "name": theme.name,
        ]
        self.fileWrapper.addRegularFile(withContents: try jsonToData(meta), preferredFilename: "meta.json")

        // let ui : [String : String] = [
        //     "barStyle": "\(theme.barStyle.rawValue)",
        // ]
        // log.debug("Adding ui.json file to wrapper.")
        // self.fileWrapper.addRegularFile(withContents: try jsonToData(ui), preferredFilename: "ui.json")

        let fonts : [String : Any] = [
            "defaultFont": buildFontInfo(theme.defaultFont),
            "secondaryFont": buildFontInfo(theme.secondaryFont),
        ]
        log.debug("Adding fonts.json file to wrapper.")
        self.fileWrapper.addRegularFile(withContents: try jsonToData(fonts), preferredFilename: "fonts.json")

        let colors : [String : String] = [
            "mainColor": theme.mainColor.hexString(),
            "accentColor": theme.accentColor.hexString(),
            "secondAccentColor": theme.secondAccentColor.hexString(),
            "backgroundColor": theme.backgroundColor.hexString(),
        ]
        log.debug("Adding colors.json file to wrapper.")
        self.fileWrapper.addRegularFile(withContents: try jsonToData(colors), preferredFilename: "colors.json")

        log.info("Writing file wrapper to URL \(self.url)...")
        try self.fileWrapper.write(to: self.url, options: [ .atomic ], originalContentsURL: nil)
    }

    private func buildFontInfo(_ font : UIFont) -> [String : Any] {
        let fontInfo : [String : Any] = [
            "name": font.fontName,
            "size": Float(font.pointSize),
        ]
        return fontInfo
    }

    private func jsonToData(_ json : [String : Any]) throws -> Data {
        var options : JSONSerialization.WritingOptions = [ .prettyPrinted ]
        if #available(iOS 11.0, *) {
            options.update(with: [ .sortedKeys ])
        }
        return try JSONSerialization.data(withJSONObject: json, options: options)
    }
}
