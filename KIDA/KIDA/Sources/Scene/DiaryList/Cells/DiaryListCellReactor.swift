//
//  DiaryListCellReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

final class DiaryListCellReactor: Reactor {
    typealias Action = NoAction

    struct State {
        var title: String
    }
    
    var initialState: State

    init(title: String){
        initialState = State(title: title)
    }
}

