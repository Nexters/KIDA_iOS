//
//  BaseViewController.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayoutConstraints()
    }

    /// UI를 정의합니다.
    func setupViews() {
        // Override Layout.
    }

    /// UI 제약사항을 정의합니다.
    func setupLayoutConstraints() {
        // Override Constraints.
    }
}
