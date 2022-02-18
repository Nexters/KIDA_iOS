//
//  KeywordSelectViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

protocol KeywordSelectReactorDelegate: AnyObject {
    func didSelectCard(cardIndex: Int)
}

final class KeywordSelectViewReactor: Reactor {
    enum Action {
        case didSelectCard(cardIndex: Int)
    }

    struct State {

    }

    let initialState: State
    weak var delegate: KeywordSelectReactorDelegate?

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .didSelectCard(let index):
            return .just(.didSelectCard(cardIndex: index))
                .do(onNext: { _ in
                    PersistentStorage.shared.pickKeyword()
                })
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        switch mutation {
        case .didSelectCard(let index):
            delegate?.didSelectCard(cardIndex: index)
            return state
        }
    }
}

