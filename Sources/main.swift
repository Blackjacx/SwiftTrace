import Foundation

print("Welcome to SwiftTrace - The cross platform ray tracer!")

func usage() {
    print("Usage: swifttrace <filename.json>")
}

if CommandLine.argc != 2 {
    print("No file path provided!")
    usage()
    exit(0)
}

let filePath = CommandLine.arguments[1]

do {
    let destinationName = filePath.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? "test"
    let raytracer = try Raytracer(filePath: filePath)
    let image = raytracer.trace()
    try image.write(to: destinationName + ".ppm")
} catch JSONError.decodingError(let className, let json) {
    print("Failed initializing scene: \(className) - \(json)")
} catch FileIOError.writeError(let filePath) {
    print("File not written at path: \(filePath)")
} catch {
    print("File not found at: \(filePath)")
}
