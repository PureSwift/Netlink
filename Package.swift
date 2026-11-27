// swift-tools-version:6.4
import PackageDescription
import class Foundation.ProcessInfo

// force building as dynamic library
let dynamicLibrary = ProcessInfo.processInfo.environment["SWIFT_BUILD_DYNAMIC_LIBRARY"] != nil
let libraryType: PackageDescription.Product.Library.LibraryType? = dynamicLibrary ? .dynamic : nil

var package = Package(
    name: "Netlink",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16),
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
            from: "0.7.0"
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

// Documentation generation
let buildDocs = ProcessInfo.processInfo.environment["BUILDING_FOR_DOCUMENTATION_GENERATION"] != nil
if buildDocs {
    package.dependencies += [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ]
}
