//
//  JSONSerializable.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

enum JSONError: Error {
    case decodingError(Any, [String: Any])
}

public protocol JSONSerializable {
    init(json: [String: Any]) throws
}
