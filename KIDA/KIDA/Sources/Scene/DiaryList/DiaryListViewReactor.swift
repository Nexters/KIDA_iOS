//
//  DiaryListViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import Foundation

final class DiaryListViewReactor: Reactor {
    enum Action {
        case loadDiaryList
    }
    
    enum Mutation {
        case loadDiaryList
        
        var bindMutation: BindMutation {
            switch self {
            case .loadDiaryList: return .loadDiaryList
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case loadDiaryList
    }

    struct State {
        var state: BindMutation = .initialState
        
        var sections: [DiaryListSection] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadDiaryList:
            return .just(.loadDiaryList)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.state = mutation.bindMutation
        
        switch mutation {
        case .loadDiaryList:
            var diaryModelList: [DiaryModel] = []
            let diaryList: [Diary] = PersistentStorage.shared.getAllDiary()
            
            for diary in diaryList {
                diaryModelList.append(DiaryModel(content: diary.content ?? "", createdAt: diary.createdAt ?? Date(), keyword: diary.keyword ?? "", title: diary.title ?? ""))
            }
            
            newState.sections = sections(list: diaryModelList)
        }
        
        return newState
    }
    
    
    var initialState: State = State()

    init(){
        action.onNext(.loadDiaryList)
    }
}

extension DiaryListViewReactor {
    
    private func sections(list: [DiaryModel]?) -> [DiaryListSection] {
        guard let list = list else { return [] }
        
        let items: [DiaryListSectionItem] = list.map { diary in
            return .item(DiaryListCellReactor(diary: diary))
        }
        
        return items.count > 0 ? [.section(items)] : []
    }
    
}
