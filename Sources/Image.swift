//
//  Image.swift
//  SwiftTrace
//
//  Created by Stefan Herold on 13/08/16.
//
//

public class Image {
    private(set)var pixel: [Color] = []
    private(set) var width: UInt
    private(set) var height: UInt
    var size: UInt { return width * height }

    init(width: UInt, height: UInt) {
        self.width = width
        self.height = height
    }

    /// Normalized accessors for bumpmapping. Uses green component. Returns dx and dy.
    func derivativeAt(x: Double, y: Double) -> (Double, Double) {
        let ix = UInt(x * Double(width-1))
        let iy = UInt(y * Double(height-1))
        let dx = pixel[Int(windex(x: ix, y: iy+1))].green - pixel[Int(index(x: ix, y: iy))].green
        let dy = pixel[Int(windex(x: ix+1, y: iy))].green - pixel[Int(index(x: ix, y: iy))].green
        return (dx, dy)
    }

    /// Handy accessors: color = img[x, y]; img[x, y] = color
    subscript(x: UInt, y: UInt) -> Color {
        get {
            assert(indexIsValidFor(x: x, y: y), "Index out of range")
            return pixel[Int(index(x: x, y: y))]
        }
        set(newValue) {
            assert(indexIsValidFor(x: x, y: y), "Index out of range")
            pixel[Int(index(x: x, y: y))] = newValue
        }
    }

    /// Handy accessors: color = img[x, y]; img[x, y] = color
    subscript(x: Double, y: Double) -> Color {
        get {
            assert(indexIsValidFor(x: x, y: y), "Index out of range")
            return pixel[Int(findex(x: x, y: y))]
        }
        set(newValue) {
            assert(indexIsValidFor(x: x, y: y), "Index out of range")
            pixel[Int(findex(x: x, y: y))] = newValue
        }
    }


    // MARK: - Index

    /// Integer index
    private func index(x: UInt, y: UInt) -> UInt {
        return y * width + x
    }

    /// Wrapped index
    private func windex(x: UInt, y: UInt) -> UInt {
        return index(x: x % width, y: y % height)
    }

    /// Double index: x(0...1), y(0...1)
    private func findex(x: Double, y: Double) -> UInt {
        return index(x: UInt(x * Double(width-1)), y: UInt(y * Double(height-1)))
    }

    private func indexIsValidFor(x: UInt, y: UInt) -> Bool {
        return x < width && y < height && x <= UInt(Int.max) && y <= UInt(Int.max)
    }

    private func indexIsValidFor(x: Double, y: Double) -> Bool {
        return x >= 0 && x <= 1 && y >= 0 && y <= 1
    }


    // MARK: - I/O

    func write() {

    }
}
