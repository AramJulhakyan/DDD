//
//  SKLog.swift
//  System
//
//  Created by Toni Vecina on 21/06/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKLog {}

private extension SKLog {

    private var separator: String { return "\n-----------------------\n" }

    func set(file: String, line: Int, message: String) {
        #if DEBUG
        var prefix = ""
        if !file.isEmpty { prefix += file }
        if line > 0 { prefix += " in " + String(line) + " -> " }
        debugPrint("\(prefix) \(message)", separator: separator, terminator: separator)
        #endif
    }
}

extension SKLog {

    /// This method print log with info tag.
    ///
    /// - parameters:
    ///     - classType: Type of owner class
    ///     - line: Int with class line where log is requested
    ///     - message: String with message log

    func info<Class>(classType: Class.Type, line: Int, message: String) {
        set(file: String(describing: classType), line: line, message: message)
    }

    /// This method print log with info tag.
    ///
    /// - parameters:
    ///     - classType: Type of owner class
    ///     - line: Int with class line where log is requested
    ///     - message: String with message log

    func info<Class>(classType: Class.Type, line: Int, data: Any) {
        set(file: String(describing: classType), line: line, message: String(describing: data))
    }

}
