//
//  PopupInfoReactor.swift
//  KIDA
//
//  Created by Ian on 2022/02/09.
//

import Foundation

protocol PopupInfoReactorDelegate: AnyObject {
    func didTapClose()
    func didTapGotoSelect()
}

final class PopupInfoReactor: Reactor {

    enum Action {
        case didTapClose
        case didTapGotoSelect
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
        case .didTapGotoSelect:
            return .just(.didTapGotoSelect)
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .didTapClose:
            delegate?.didTapClose()
        case .didTapGotoSelect:
            delegate?.didTapGotoSelect()
        }

        return state
    }
}
