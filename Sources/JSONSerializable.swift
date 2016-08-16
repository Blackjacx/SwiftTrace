//
//  JSONSerializable.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

enum JSONError: Error {
    case decodingError(Any, [String: AnyObject])
}

enum FileError: Error {
    case fileNotFound(String)
}

public protocol JSONSerializable {
    init(json: [String: AnyObject]) throws
}
