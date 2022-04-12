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

// Creates our project using a helper function defined in ProjectDescriptionHelpers

//let carthageDependencies: [CarthageDependencies.Dependency] = [
//    .github(path: "https://github.com/ReactorKit/ReactorKit", requirement: .exact("2.1.1")),
//    .github(path: "https://github.com/RxSwiftCommunity/RxDataSources", requirement: .exact("4.0.1")),
//    .github(path: "https://github.com/ReactiveX/RxSwift", requirement: .exact("5.1.3")),
//    .github(path: "https://github.com/SnapKit", requirement: .exact("5.0.1")),
//    .github(path: "https://github.com/devxoul/Then", requirement: .exact("2.7.0"))
//]
//
//let dependencies = Dependencies(carthage: .init(carthageDependencies), platforms: [.iOS])


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
