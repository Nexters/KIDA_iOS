//
//  KeywordSelectViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

//final class KeywordSelectViewReactor: Reactor {
//    enum Action {
//        case selectKeyword
//    }
//
//    enum Mutation {
//        case selectKeyword
//
//        var bindMutation: BindMutation {
//            switch self {
//            case .selectKeyword:
//                return .selectKeyword
//            }
//        }
//    }
//
//    enum BindMutation {
//        case initialState
//        case selectKeyword
//    }
//
//    struct State {
//        var state: BindMutation = .initialState
//
//        var keyword: String = ""
//    }
//
//    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case .selectKeyword:
//            return .just(.selectKeyword)
//        }
//    }
//
//    func reduce(state: State, mutation: Mutation) -> State {
//        var newState = state
//        newState.state = mutation.bindMutation
//
//        switch mutation {
//        case .selectKeyword:
//            newState.keyword = PersistentStorage.shared.pickKeyword()
//            print("keyword: \(newState.keyword)")
//        }
//
//        return newState
//    }
//
//    var initialState: State = State()
//
//    init(){
//
//    }
//}

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

