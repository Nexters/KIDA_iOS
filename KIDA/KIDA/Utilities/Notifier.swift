//
//  Notifier.swift
//  KIDA
//
//  Created by Ian on 2022/02/13.
//

import Foundation
import UIKit

/// Alert을 띄우기 위한 유틸리티
enum Notifier {
    typealias Action = () -> Void
    typealias AlertButtonAction = (title: String, action: Action?, style: UIAlertAction.Style)


    /// Alert을 띄웁니다.
    ///
    /// Example
    ///
    /// let okButtonAction: Notifier.AlertButtonAction = ("OK", action: { do AnyThing }, style: .default
    ///
    /// Notifier.alert(on: self, title: "타이틀", message: "메세지", buttons: [okButtonAction])
    /// - Parameters:
    ///   - viewController: 띄우고자 하는 ViewController
    ///   - title: 제목
    ///   - message: 메세지
    ///   - buttons: typealias (title: String, action: Action?, style: UIAlertAction.Style
    ///   - Action: () -> Void
    static func alert(on viewController: UIViewController,
                      title: String,
                      message: String,
                      buttons: [AlertButtonAction]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        buttons.forEach { (title, action, style) in
            alertController.addAction(UIAlertAction(title: title,
                                                    style: style,
                                                    handler: { _ in
                action?()
            }))
        }

        DispatchQueue.main.async { [weak viewController] in
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

