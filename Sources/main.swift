print("Welcome to SwiftTrace - The cross platform ray tracer!")


var image = Image(width: 400, height: 400)
let filePath = Process.arguments.last!

do {
    let raytracer = try Raytracer(filePath: filePath)
    raytracer.trace(image: image)
    try image.write(to: "test.ppm")
} catch JSONError.decodingError(let className, let json) {
    print("Failed initializing scene: \(className) - \(json)")
} catch FileIOError.writeError(let filePath) {
    print("File not written at path: \(filePath)")
} catch {
    print("File not found at: \(filePath)")
}
