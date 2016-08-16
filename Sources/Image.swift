//
//  Image.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public class Image {
    public var width: UInt = 0
    public var height: UInt = 0

    init(width: UInt, height: UInt) {
        self.width = width
        self.height = height
    }

    public func setColor(color: Color, x: UInt, y: UInt) {
//        print("x: \(x), y: \(y), color: \(color)")
    }
}
