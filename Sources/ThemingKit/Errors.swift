//
//  Errors.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 29/5/18.
//

import Foundation


public enum Errors : Error {
    case invalidValue(String, Any.Type)
    case invalidLength(Int, Any.Type)
    case unknownFont(String)
}
