//
//  HomeViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/15.
//

final class HomeViewReactor: Reactor {
    typealias Action = NoAction

    struct State {
    }
    
    let initialState: State

    init(){
        initialState = State()
    }
}
