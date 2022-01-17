//
//  UIViewController+Rx.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import UIKit
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewDidLoad))
            .map { _ in }

        return ControlEvent(events: event)
    }

    var viewWillAppear: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ in }

        return ControlEvent(events: event)
    }

    var viewDidAppear: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewDidAppear(_:)))
            .map { _ in }

        return ControlEvent(events: event)
    }

    var viewWillDisappear: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewWillDisappear(_:)))
            .map { _ in }

        return ControlEvent(events: event)
    }

    var viewDidDisappear: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewDidDisappear(_:)))
            .map { _ in }

        return ControlEvent(events: event)
    }
}
