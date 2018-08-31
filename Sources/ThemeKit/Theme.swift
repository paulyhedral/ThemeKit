//
//  Theme.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


public struct Theme {
    public let id : String 
    public let name : String
//    public var iconImage : Image?
//    public var backgroundImage : Image?
    public var defaultFont : UIFont
    public var labelFont : UIFont
    public var titleBarFont : UIFont
    public var buttonFont : UIFont
    public var titleFont : UIFont
    public var tintColor : UIColor
    public var alternateTintColor : UIColor
    public var titleBarColor : UIColor
    public var titleBarButtonColor : UIColor
    public var titleBarBackgroundColor : UIColor
    public var barStyle : UIBarStyle = .black

    public init(id : String, name : String) {
        self.id = id
        self.name = name
        self.defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.labelFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.titleFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.titleBarFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.buttonFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
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


extension Theme {

    public mutating func copy(from theme : Theme) {
        self.alternateTintColor = theme.alternateTintColor
        self.barStyle = theme.barStyle
        self.buttonFont = theme.buttonFont
        self.defaultFont = theme.defaultFont
        self.labelFont = theme.labelFont
        self.tintColor = theme.tintColor
        self.titleBarBackgroundColor = theme.titleBarBackgroundColor
        self.titleBarButtonColor = theme.titleBarButtonColor
        self.titleBarColor = theme.titleBarColor
        self.titleBarFont = theme.titleBarFont
        self.titleFont = theme.titleFont
    }

}
