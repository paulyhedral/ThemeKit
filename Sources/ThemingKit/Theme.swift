//
//  Theme.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


public struct Theme {
    public let id : String
    public var name : String
    public var defaultFont : UIFont
    public var secondaryFont : UIFont
    public var mainColor : UIColor
    public var accentColor : UIColor
    public var secondAccentColor : UIColor
    public var backgroundColor : UIColor

    public init(id : String, name : String) {
        self.id = id
        self.name = name
        self.defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.secondaryFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.mainColor = .black
        self.accentColor = .white
        self.secondAccentColor = .blue
        self.backgroundColor = .orange
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
        v ^= defaultFont.hashValue
        v ^= secondaryFont.hashValue
        v ^= mainColor.hashValue
        v ^= accentColor.hashValue
        v ^= secondAccentColor.hashValue
        v ^= backgroundColor.hashValue

        return v
    }
}


extension Theme : CustomStringConvertible {

    public var description: String {
        return "Theme { id=\(id); name=\(name); defaultFont=\(defaultFont); secondaryFont=\(secondaryFont); " +
        "mainColor=\(mainColor); accentColor=\(accentColor); secondAccentColor=\(secondAccentColor); " +
        "backgroundColor=\(backgroundColor) }"
    }

}


extension Theme {

    public mutating func copy(from theme : Theme) {
        self.defaultFont = theme.defaultFont
        self.secondaryFont = theme.secondaryFont
        self.mainColor = theme.mainColor
        self.accentColor = theme.accentColor
        self.secondAccentColor = theme.secondAccentColor
        self.backgroundColor = theme.backgroundColor
    }

}
