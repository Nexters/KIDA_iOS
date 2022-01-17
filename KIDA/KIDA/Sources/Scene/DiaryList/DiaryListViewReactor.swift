//
//  DiaryListViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

final class DiaryListViewReactor: Reactor {
    typealias Action = NoAction

    struct State {
    }
    
    let initialState: State

    init(){
        initialState = State()
    }
}

