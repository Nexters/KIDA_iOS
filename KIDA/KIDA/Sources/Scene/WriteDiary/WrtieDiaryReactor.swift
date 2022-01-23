//
//  WrtieDiaryReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import Foundation

protocol WriteDiaryReactorDelegate: AnyObject {
    func changeKeyword()
    func didWriteDiary()
}

final class WriteDiaryReactor: Reactor {

    enum Action {
        case didTapWriteButton
    }

    struct State {
        var didTapWriteButton: Bool = false
    }

    // MARK: - Properties
    var initialState: State
    weak var delegate: WriteDiaryReactorDelegate?

    // MARK: - Initializer
    init() {
        self.initialState = State()
    }

    // MARK: - Methods

    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didTapWriteButton:
            return .just(.didTapWriteButton)
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didTapWriteButton:
            newState.didTapWriteButton = true
        }

        return newState
    }
}
