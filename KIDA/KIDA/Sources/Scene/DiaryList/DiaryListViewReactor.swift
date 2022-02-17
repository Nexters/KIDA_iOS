//
//  DiaryListViewReactor.swift
//  KIDA
//
//  Created by choidam on 2022/01/17.
//

import Foundation

protocol DiaryListReactorDelegate: AnyObject {
    func didTapGoToUpdate(diary: Diary)
}

final class DiaryListViewReactor: Reactor {
    enum Action {
        case loadDiaryList
        case deleteDiary(Diary)
        case reloadDiaryList
        case didTapGoToUpdate(Diary)
    }
    
    enum Mutation {
        case loadDiaryList
        case deleteDiary(Diary)
        case didTapGoToUpdate(Diary)
        case errorMsg(String)
        
        var bindMutation: BindMutation {
            switch self {
            case .loadDiaryList:
                return .loadDiaryList
            case .deleteDiary:
                return .deleteDiary
            case .didTapGoToUpdate:
                return .didTapGoToUpdate
            case .errorMsg:
                return .errorMsg
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case loadDiaryList
        case deleteDiary
        case didTapGoToUpdate
        case errorMsg
    }

    struct State {
        var state: BindMutation = .initialState
        
        var sections: [DiaryListSection] = []
        
        var errorMsg: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadDiaryList:
            return .just(.loadDiaryList)
        case .deleteDiary(let diary):
            return .just(.deleteDiary(diary))
        case .reloadDiaryList:
            return .just(.loadDiaryList)
        case .didTapGoToUpdate(let diary):
            return .just(.didTapGoToUpdate(diary))
        
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.state = mutation.bindMutation
        
        switch mutation {
        case .loadDiaryList:
            var diaryModelList: [DiaryModel] = []
            let diaryList: [Diary] = PersistentStorage.shared.getAllDiary()
            
            print("@@@ diaryList: \(diaryList)")
            
            for diary in diaryList {
                diaryModelList.append(DiaryModel(content: diary.content ?? "", createdAt: diary.createdAt ?? Date(), keyword: diary.keyword ?? "", title: diary.title ?? ""))
            }
            
            newState.sections = sections(list: diaryModelList)
            
        case .deleteDiary(let diary):
            PersistentStorage.shared.deleteDiary(diary, onSuccess: { success in
                if success {
                    
                } else {
                    let msg = "다이어리를 삭제하는데 에러가 발생했습니다."
                    
                    newState.errorMsg = msg
                    newState.state = .errorMsg
                }
            })
            
        case .didTapGoToUpdate(let diary):
            delegate?.didTapGoToUpdate(diary: diary)
            
        
        case .errorMsg(let msg):
            newState.errorMsg = msg
        }
        
        return newState
    }
    
    
    var initialState: State = State()
    weak var delegate: DiaryListReactorDelegate?

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
