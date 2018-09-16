import PackageDescription

#if os(macOS)
let nativeDependency: Target.Dependency = .Target(name: "DarwinWLAN")
#elseif os(Linux)
let nativeDependency: Target.Dependency = .Target(name: "LinuxWLAN")
#endif

let package = Package(
    name: "Netlink",
    targets: [
        Target(
            name: "Netlink",
            dependencies: [
                .Target(name: "CNetlink")
            ]
        ),
        Target(
            name: "CNetlink"
        ),
        Target(
            name: "NetlinkGeneric",
            dependencies: [
                .Target(name: "Netlink")
                ]
        ),
        Target(
            name: "Netlink80211",
            dependencies: [
                .Target(name: "Netlink"),
                .Target(name: "NetlinkGeneric")
                ]
        )
    ],
    dependencies: [
        .Package(url: "https://github.com/PureSwift/Codable.git", majorVersion: 1)
    ],
    exclude: ["Xcode", "Carthage"]
)
