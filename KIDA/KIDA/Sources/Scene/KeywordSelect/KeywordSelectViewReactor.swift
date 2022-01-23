//
//  KeywordSelectViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

final class KeywordSelectViewReactor: Reactor {
    typealias Action = NoAction

    struct State {
    }
    
    var initialState: State

    init(){
        initialState = State()
    }
}

