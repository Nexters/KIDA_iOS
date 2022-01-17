//
//  DiaryListViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

final class DiaryListViewReactor: Reactor {
    typealias Action = NoAction

    struct State {
        var sections: [DiaryListSection] = []
    }
    
    var initialState: State = State()

    init(){
        
        // test
        initialState.sections = [.section([.item(DiaryListCellReactor(title: "sample1")), .item(DiaryListCellReactor(title: "sample2")), .item(DiaryListCellReactor(title: "sample3"))])]
        
    }
}

