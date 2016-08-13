//
//  JSONSerializable.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public protocol JSONSerializable {
    init(json: [String:AnyObject])
}
