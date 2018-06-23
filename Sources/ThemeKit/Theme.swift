//
//  Theme.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Theme {
    public let id : String
    public let name : String
//    public var iconImage : Image?
//    public var backgroundImage : Image?
    public var defaultFont : Font
    public var labelFont : Font
    public var titleBarFont : Font
    public var buttonFont : Font
    public var titleFont : Font
    public var tintColor : UIColor
    public var alternateTintColor : UIColor
    public var titleBarColor : UIColor
    public var titleBarButtonColor : UIColor
    public var titleBarBackgroundColor : UIColor
    #if os(iOS)
    public var barStyle : UIBarStyle = .black
    #endif

    public init(id : String, name : String) {
        self.id = id
        self.name = name
        self.defaultFont = Font.systemFont(ofSize: Font.systemFontSize)
        self.labelFont = Font.systemFont(ofSize: Font.systemFontSize)
        self.titleFont = Font.systemFont(ofSize: Font.systemFontSize)
        self.titleBarFont = Font.systemFont(ofSize: Font.systemFontSize)
        self.buttonFont = Font.systemFont(ofSize: Font.systemFontSize)
        self.tintColor = .black
        self.alternateTintColor = .white
        self.titleBarColor = .blue
        self.titleBarButtonColor = .orange
        self.titleBarBackgroundColor = .green
    }
}


extension Theme : Equatable, Hashable {
    public static func ==(lhs : Theme, rhs : Theme) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    public var hashValue: Int {
        var v : Int = 0

        v ^= id.hashValue
        v ^= name.hashValue
//        v ^= iconImage?.hashValue ?? 0
//        v ^= backgroundImage?.hashValue ?? 0
        v ^= defaultFont.hashValue
        v ^= labelFont.hashValue
        v ^= titleBarFont.hashValue
        v ^= buttonFont.hashValue
        v ^= titleFont.hashValue
        v ^= tintColor.hashValue
        v ^= alternateTintColor.hashValue
        v ^= titleBarColor.hashValue
        v ^= titleBarButtonColor.hashValue
        v ^= titleBarBackgroundColor.hashValue

        return v
    }
}
