//
//  PopupErrorReactor.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import Foundation

protocol PopupErrorReactorDelegate: AnyObject {
    func didTapClosePopupError()
}

final class PopupErrorReactor: Reactor {

    enum Action {
        case didTapClose
    }

    struct State {

    }

    let initialState: State
    weak var delegate: PopupInfoReactorDelegate?

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didTapClose:
            return .just(.didTapClose)
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .didTapClose:
            delegate?.didTapClose()
        }
        return state
    }
}
