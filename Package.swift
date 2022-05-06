// swift-tools-version:5.5
import PackageDescription
import class Foundation.ProcessInfo

// force building as dynamic library
let dynamicLibrary = ProcessInfo.processInfo.environment["SWIFT_BUILD_DYNAMIC_LIBRARY"] != nil
let libraryType: PackageDescription.Product.Library.LibraryType? = dynamicLibrary ? .dynamic : nil

var package = Package(
    name: "Netlink",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "Netlink",
            type: libraryType,
            targets: ["Netlink"]
        ),
        .library(
            name: "NetlinkGeneric",
            type: libraryType,
            targets: ["NetlinkGeneric"]
        ),
        .library(
            name: "Netlink80211",
            type: libraryType,
            targets: ["Netlink80211"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Socket.git",
            .branch("main")
        )
    ],
    targets: [
        .target(
            name: "Netlink",
            dependencies: [
                "CNetlink",
                "Socket"
            ]
        ),
        .target(
            name: "CNetlink"
        ),
        .target(
            name: "NetlinkGeneric",
            dependencies: [
                "Netlink"
            ]
        ),
        .target(
            name: "Netlink80211",
            dependencies: [
                "Netlink",
                "NetlinkGeneric"
            ]
        ),
        .testTarget(
            name: "NetlinkTests",
            dependencies: [
                "Netlink",
            ]
        ),
        .testTarget(
            name: "NetlinkGenericTests",
            dependencies: [
                "Netlink",
                "NetlinkGeneric",
                "Netlink80211",
            ]
        ),
        .testTarget(
            name: "Netlink80211Tests",
            dependencies: [
                "Netlink",
                "Netlink80211",
            ]
        )
    ]
)

// SwiftPM command plugins are only supported by Swift version 5.6 and later.
#if swift(>=5.6)
let buildDocs = ProcessInfo.processInfo.environment["BUILDING_FOR_DOCUMENTATION_GENERATION"] != nil
if buildDocs {
    package.dependencies += [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ]
}
#endif
