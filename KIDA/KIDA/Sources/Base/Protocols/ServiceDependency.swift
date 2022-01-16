//
//  ServiceDependency.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

import UIKit

protocol ServiceDependency: StoryboardView {
    init(reactor: Reactor?)

    func bindReactor(reactor: Reactor?)
}

extension ServiceDependency where Self: UIViewController {

    func bindReactor(reactor: Reactor? = nil){
        self.reactor = reactor
    }

    init(reactor: Reactor? = nil) {
        self.init()
        self.bindReactor(reactor: reactor)
    }
}
