//
//  KeywordSelectViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/23.
//

final class KeywordSelectViewReactor: Reactor {
    typealias Action = NoAction

    struct State {
        var sections: [KeywordSelectSection] = []
    }
    
    var initialState: State = State()

    init(){
        initialState.sections = [.section([.item(KeywordSelectCellReactor()), .item(KeywordSelectCellReactor()), .item(KeywordSelectCellReactor()), .item(KeywordSelectCellReactor())])]
    }
}

