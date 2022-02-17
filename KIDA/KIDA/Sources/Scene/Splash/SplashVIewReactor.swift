//
//  SplashVIewReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import RxSwift

protocol SplashViewReactorDelegate: AnyObject {
    func showNextScene()
}

final class SplashViewReactor: Reactor {

    enum Action {
        case showKeywordSelect
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
        case .showKeywordSelect:
            return Observable<Action>.just(.showKeywordSelect)
                .do(onNext: { [weak self] _ in
                    self?.delegate?.showNextScene()
                })
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .showKeywordSelect:
            return state
        }
    }
}
