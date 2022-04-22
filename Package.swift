// swift-tools-version:5.5
import PackageDescription

let libraryType: PackageDescription.Product.Library.LibraryType = .static

let package = Package(
    name: "Netlink",
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
            url: "https://github.com/PureSwift/swift-system.git",
            .branch("master")
        )
    ],
    targets: [
        .target(
            name: "Netlink",
            dependencies: [
                "CNetlink",
                .product(
                    name: "SystemPackage", 
                    package: "swift-system"
                )
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
