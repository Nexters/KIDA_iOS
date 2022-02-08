//
//  DiaryListCellReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//
import Foundation

final class DiaryListCellReactor: Reactor {
    typealias Action = NoAction

    struct State {
        var diary: DiaryModel
    }
    
    var initialState: State

    init(diary: DiaryModel){
        initialState = State(diary: diary)
    }
}

