//
//  SelectedKeywordReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/15.
//

protocol SelectedKeywordReactorDelegate: AnyObject {
    func didTapGotoWrite()
    func didTapRePick()
}

final class SelectedKeywordReactor: Reactor {

    enum Action {
        case didTapGotoWriteButton
        case didTapRePickButton
    }

    struct State {
    }

    var initialState: State
    weak var delegate: SelectedKeywordReactorDelegate?

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didTapGotoWriteButton:
            return .just(.didTapGotoWriteButton)
        case .didTapRePickButton:
            // keywordSelect로 이동
            return .just(.didTapRePickButton)
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .didTapGotoWriteButton:
            delegate?.didTapGotoWrite()
            return state
        case .didTapRePickButton:
            delegate?.didTapRePick()
            return state
        }
    }
}
