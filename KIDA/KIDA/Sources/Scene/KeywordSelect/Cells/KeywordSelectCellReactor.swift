//
//  KeywordSelectCellReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/24.
//

final class KeywordSelectCellReactor: Reactor {
    typealias Action = NoAction

    struct State {
    }
    
    var initialState: State

    init(){
        initialState = State()
    }
}
