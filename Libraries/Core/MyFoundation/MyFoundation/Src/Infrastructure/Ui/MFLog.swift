//
//  MFLog.swift
//  MyFoundation
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

public protocol MFLog {}

private extension MFLog {

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

public extension MFLog {

    /// This method print log with error tag.
    ///
    /// - parameters:
    ///     - file: String with name of file where log is requested
    ///     - line: Int with class line where log is requested
    ///     - message: String with message log

    func error(file: String, line: Int, message: String) {
        set(file: file, line: line, message: "ERROR: " + message)
    }

    /// This method print log with error tag.
    ///
    /// - parameters:
    ///     - classType: Type of owner class
    ///     - line: Int with class line where log is requested
    ///     - message: String with message log

    func error<Class>(classType: Class.Type, line: Int, message: String) {
        set(file: String(describing: classType), line: line, message: message)
    }

    /// This method print log with error tag.
    ///
    /// - parameters:
    ///     - file: String with name of file where log is requested
    ///     - line: Int with class line where log is requested
    ///     - data: Any with data log

    func error(file: String, line: Int, data: Any) {
        error(file: file, line: line, message: String(describing: data))
    }

    /// This method print log with error tag.
    ///
    /// - parameters:
    ///     - classType: Type of owner class
    ///     - line: Int with class line where log is requested
    ///     - data: Any with data log

    func error<Class>(classType: Class.Type, line: Int, data: Any) {
        error(classType: classType, line: line, message: String(describing: data))
    }

    /// This method print log with info tag.
    ///
    /// - parameters:
    ///     - file: String with name of file where log is requested
    ///     - line: Int with class line where log is requested
    ///     - message: String with message log

    func info(file: String, line: Int, message: String) {
        set(file: file, line: line, message: "INFO: " + message)
    }

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
    ///     - file: String with name of file where log is requested
    ///     - line: Int with class line where log is requested
    ///     - data: Any with data log

    func info(file: String, line: Int, data: Any) {
        info(file: file, line: line, message: String(describing: data))
    }

}
