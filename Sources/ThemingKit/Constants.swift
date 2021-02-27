//
//  ThemeConstants.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import Foundation

public let logPrefix = "com.pilgrimagesoftware.theme"

public enum ThemeIdentifier : String {
    case dark = "dark"
    case light = "light"
    case custom = "custom"
    case `default` = "default"
}

public enum ThemeColorType : String {
    case main
    case accent1
    case accent2
    case background1
    case background2
}

public enum ThemeFontType : String {
    case `default`
    case secondary
}

public enum ThemeStyle : String {
    case dark
    case light
}

#if swift(>=4.2)

extension ThemeStyle : CaseIterable {

}

#endif
