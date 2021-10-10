// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Netlink",
    products: [
        .library(
            name: "Netlink",
            type: .dynamic,
            targets: ["Netlink"]
        ),
        .library(
            name: "NetlinkGeneric",
            type: .dynamic,
            targets: ["NetlinkGeneric"]
        ),
        .library(
            name: "Netlink80211",
            type: .dynamic,
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
                "SystemPackage"
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
        )
    ]
)
