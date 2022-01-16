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
    func start()
}
