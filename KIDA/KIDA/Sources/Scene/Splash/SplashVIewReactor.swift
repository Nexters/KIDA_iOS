//
//  SplashVIewReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import RxSwift

protocol SplashViewReactorDelegate: AnyObject {
    func showHome()
}

final class SplashViewReactor: Reactor {

    enum Action {
        case showHome
    }

    struct State {
    }

    // MARK: - Properties
    let initialState: State
    weak var delegate: SplashViewReactorDelegate?

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .showHome:
            return Observable<Action>.just(.showHome)
                .do(onNext: { [weak self] _ in
                    self?.delegate?.showHome()
                })
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .showHome:
            return state
        }
    }
}
