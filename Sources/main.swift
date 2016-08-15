print("Welcome to SwiftTrace - The cross platform ray tracer!")

let json:[String: Any] = ["x":0.0, "y":0.0, "z":0]
do {
    try _ = Point3(json: json)
} catch JSONError.decodingError(let className, let json) {
    print("Failed initializing scene: \(className) - \(json)")
}
