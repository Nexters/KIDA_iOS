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

let project = Project(name: "KIDA",
                      targets: [
                        Target(
                            name: "App",
                            platform: .iOS,
                            product: .app,
                            bundleId: "com.ian.KIDA",
                            infoPlist: .file(path: "../KIDA/Info.plist"),
                            sources: ["../KIDA/**"]
                        )
                      ]
)
