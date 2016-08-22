# SwiftTrace

A simple cross platform raytracer written in Swift. The supported platforms are macOS, iOS, tvOS, Linux. This project is based on the raytracer I wrote in the computer graphics course 2005 in C++ at the Otto-von-Guericke University in Magdeburg. The repository is build up based on the exercises of the course. Each branch represents an exercise. The first one is `01-StarterProject` for example.

## Requirements

This project aims to be kept up to date with the latest version of Swift. Currently it is written in Swift 3 syntax.

## Building

### Xcode

Just open the project file and run the application. A sample scene is provided as input argument via the scheme. The resulting file is placed where you find the executable. In the project navigator open the `Products` group, Option-click the swifttrace executable and select show in Finder.

### Swift Package Manager (SPM)

You can build the project using the [Swift Package Manager (SPM)](https://swift.org/package-manager/) from the command line:

`swift build`

As prerequisite you'll need the newest Swift toolchain. You can find it [here](https://swift.org/download/). 

### Linux (**OPEN**)

In near future it will be possible to build the project using a makefile under Linux.
