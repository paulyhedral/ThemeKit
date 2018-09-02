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
    
    public func hexString(componentSize : Int = 2, withAlpha : Bool = true) -> String {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0

        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            switch (componentSize, withAlpha) {
            case (1, true):
                return String(format: "%1x%1x%1x%1x", Int(r * 15.0), Int(g * 15.0), Int(b * 15.0), Int(a * 15.0))

            case (2, true):
                return String(format: "%02x%02x%02x%02x", Int(r * 255.0), Int(g * 255.0), Int(b * 255.0), Int(a * 255.0))

            case (1, false):
                return String(format: "%1x%1x%1x", Int(r * 15.0), Int(g * 15.0), Int(b * 15.0))

            case (2, false):
                return String(format: "%02x%02x%02x", Int(r * 255.0), Int(g * 255.0), Int(b * 255.0))

            default: break
            }
        }

        return ""
    }
    
    public static func from(hexValue : String) throws -> UIColor {
        log.debug("\(#function): hexValue=\(hexValue)")

        var h = hexValue
        if let c = hexValue.first,
            c == Character("#") {
            log.debug("Dropping leading '#' in hex value.")
            h = String(hexValue.dropFirst())
        }
        
        var digitSize = 2
        switch h.count {
        case 3,4: // rgb(a), 1 digit
            log.debug("Using digit size of 1 because value is 3 or 4 characters in length.")
            digitSize = 1
            
        case 6,8: // rrggbb(aa), 2 digits
            log.debug("Using digit size of 2 because value is 6 or 8 characters in length.")
            digitSize = 2
            
        default:
            log.error("Value is an invalid length: \(h.count)")
            throw Errors.invalidLength(h.count, UIColor.self)
        }
        
        let r = try scanHexDigit(in: h, position: 0, size: digitSize)
        log.debug("r=\(r)")
        let g = try scanHexDigit(in: h, position: 1, size: digitSize)
        log.debug("g=\(g)")
        let b = try scanHexDigit(in: h, position: 2, size: digitSize)
        log.debug("b=\(b)")
        var a : CGFloat = 1
        if h.count == 4 || h.count == 8 {
            log.debug("Scanning for alpha value.")
            a = try scanHexDigit(in: h, position: 3, size: digitSize)
        }
        log.debug("a=\(a)")

        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
    private static func scanHexDigit(in string : String, position : Int, size : Int) throws -> CGFloat {
        log.debug("\(#function): string=\(string), position=\(position), size=\(size)")

        let start = string.index(string.startIndex, offsetBy: position * size)
        log.debug("start=\(start)")
        let end = string.index(start, offsetBy: size)
        log.debug("end=\(end)")
        let range = start..<end
        log.debug("range=\(range)")
        let substring = string.substring(with: range)
        log.debug("substring=\(substring)")
        let scanner = Scanner(string: substring)
        scanner.caseSensitive = false
        
        var v : UInt32 = 0
        if !scanner.scanHexInt32(&v) {
            log.error("Could not scan 32-bit hex value!")
            throw Errors.invalidValue(substring, UIColor.self)
        }

        log.debug("v=\(v)")
        return CGFloat(v) / 255.0
    }

    public func isDark() -> Bool {
        if let components = self.cgColor.components,
            components.count >= 3 {
            let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000

            return brightness < 0.5
        }

        return false
    }
    
}

#endif
