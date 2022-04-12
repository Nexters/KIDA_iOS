import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains Tuist App target and Tuist unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let project = Project(name: "KIDA",
                      targets: [
                        Target(
                            name: "App",
                            platform: .iOS,
                            product: .app,
                            bundleId: "com.ian.KIDA",
                            infoPlist: .file(path: "../KIDA/Info.plist"),
                            sources: ["../KIDA/**"],
                            dependencies: [
                                .package(product: "ReactorKit"),
                                .package(product: "RxDataSources"),
                                .package(product: "RxSwift"),
                                .package(product: "SnapKit"),
                                .package(product: "Then")
                            ]
                        )
                      ]
)

public extension TargetDependency {
    static func carthage(name: String) -> TargetDependency {
        .framework(path: Path("Tuist/Dependencies/Carthage/iOS/\(name).framework"))
    }
}
