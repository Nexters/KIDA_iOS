//
//  KeywordSelectViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

final class KeywordSelectViewReactor: Reactor {
    enum Action {
        case selectKeyword
    }
    
    enum Mutation {
        case selectKeyword
        
        var bindMutation: BindMutation {
            switch self {
            case .selectKeyword:
                return .selectKeyword
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case selectKeyword
    }

    struct State {
        var state: BindMutation = .initialState
        
        var keyword: String = ""
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectKeyword:
            return .just(.selectKeyword)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.state = mutation.bindMutation
        
        switch mutation {
        case .selectKeyword:
            newState.keyword = PersistentStorage.shared.pickKeyword()
            print("keyword: \(newState.keyword)")
        }
        
        return newState
    }
    
    var initialState: State = State()

    init(){
        
    }
}

