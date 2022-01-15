//
//  Coordinatable.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import Foundation
import UIKit

protocol Coordinatable: AnyObject {

    // MARK: - Properties
    var childCoordinators: [Coordinatable] { get set }
    var parentCoordinator: Coordinatable? { get set }
    var navigationController: UINavigationController { get set }

    // MARK: - Methods
    /// push, modal 띄우는 동작 수행 메소드
    func start()
}
