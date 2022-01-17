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
        case didTapOptionButton
        case didTapChangeKeywordButton
        case didTapWriteButton
    }

    struct State {
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
        case .didTapOptionButton:
            return .just(.didTapOptionButton)
        case .didTapChangeKeywordButton:
            delegate?.changeKeyword()
            return .just(.didTapChangeKeywordButton)
        case .didTapWriteButton:
            delegate?.didWriteDiary()
            return .just(.didTapWriteButton)
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didTapOptionButton:
            return newState
        case .didTapChangeKeywordButton:
            return newState
        case .didTapWriteButton:
            return newState
        }
    }
}
