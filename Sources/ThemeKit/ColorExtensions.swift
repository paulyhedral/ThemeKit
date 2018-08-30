//
//  ColorExtensions.swift
//  CharacterManager
//
//  Created by Paul Schifferer on 12/23/15.
//  Copyright © 2015 Pilgrimage Software. All rights reserved.
//

#if os(iOS)

import UIKit


extension UIColor {
    
    public var hexString : String {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return String(format: "%02x%02x%02x%02x", Int(r * 255.0), Int(g * 255.0), Int(b * 255.0), Int(a * 255.0))
        }
        return ""
    }
    
    public static func from(hexValue : String) throws -> UIColor {
        var h = hexValue
        if let c = hexValue.first,
            c == Character("#") {
            h = String(hexValue.dropFirst())
        }
        
        var digitSize = 2
        switch h.count {
        case 3,4: // rgb(a), 1 digit
            digitSize = 1
            
        case 6,8:
            digitSize = 2
            
        default:
            throw Errors.invalidValue(h, UIColor.self)
        }
        
        let r = try scanHexDigit(in: h, position: 0, size: digitSize)
        let g = try scanHexDigit(in: h, position: 1, size: digitSize)
        let b = try scanHexDigit(in: h, position: 2, size: digitSize)
        var a : CGFloat = 1
        if h.count == 4 || h.count == 8 {
            a = try scanHexDigit(in: h, position: 3, size: digitSize)
        }
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
    private static func scanHexDigit(in string : String, position : Int, size : Int) throws -> CGFloat {
        let start = string.index(string.startIndex, offsetBy: position * size)
        let end = string.index(start, offsetBy: size)
        let range = start..<end
        let substring = string.substring(with: range)
        let scanner = Scanner(string: substring)
        scanner.caseSensitive = false
        
        var v : UInt32 = 0
        if !scanner.scanHexInt32(&v) {
            throw Errors.invalidValue(substring, UIColor.self)
        }
        
        return CGFloat(v)
    }
    
}

#endif
