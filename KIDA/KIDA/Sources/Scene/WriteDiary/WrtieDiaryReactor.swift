//
//  WrtieDiaryReactor.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import Foundation

protocol WriteDiaryReactorDelegate: AnyObject {
    func didWriteDiary()
}

final class WriteDiaryReactor: Reactor {

    enum Action {
        case didTapWriteButton(_ diary: DiaryModel, didSuccess: Bool)
        case setEditDiaryData(Diary)
        case updateDiary(title: String, content: String)
    }
    
    enum Mutation {
        case didTapWriteButton(_ diary: DiaryModel, didSuccess: Bool)
        case setEditDiaryData(Diary)
        case updateDiary(title: String, content: String)
        
        var bindMutation: BindMutation {
            switch self {
            case .didTapWriteButton:
                return .didTapWriteButton
            case .setEditDiaryData:
                return .setEditDiaryData
            case .updateDiary:
                return .updateDiary
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case didTapWriteButton
        case setEditDiaryData
        case updateDiary
    }

    struct State {
        var state: BindMutation = .initialState
        
        var didSuccessCreateDiary: Bool = false
        var isEditing: Bool = false
        
        var diary: Diary?
        var keyword: String?
        var title: String?
        var content: String?
        var createdAt: Date?
    }

    // MARK: - Properties
    var initialState: State
    weak var delegate: WriteDiaryReactorDelegate?

    // MARK: - Initializer
    init(isEditing: Bool? = false, diary: Diary? = nil) {
        self.initialState = State()
        
        guard let isEditing = isEditing else { return }
        guard let diary = diary else { return }

        initialState.isEditing = isEditing
        initialState.diary = diary
        
        if isEditing == true {
            action.onNext(.setEditDiaryData(diary))
        }
    }

    // MARK: - Methods
    
    func mutate(action: Action) -> Observable<Mutation> {
        var didSuccessCreate: Bool = false
        
        switch action {
        case .didTapWriteButton(let diary, _):
            PersistentStorage.shared.createDiary(diary, onSuccess: { success in
                didSuccessCreate = success
            })
            return .just(.didTapWriteButton(diary, didSuccess: didSuccessCreate))
        case .setEditDiaryData(let diary):
            return .just(.setEditDiaryData(diary))
        case .updateDiary(let title, let content):
            return .just(.updateDiary(title: title, content: content))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.state = mutation.bindMutation
        
        switch mutation {
        case .didTapWriteButton(_, let didSuccess):
            newState.didSuccessCreateDiary = didSuccess
            if didSuccess {
                self.delegate?.didWriteDiary()
            }
        case .setEditDiaryData(let diary):
            newState.keyword = diary.keyword
            newState.title = diary.title
            newState.content = diary.content
            newState.createdAt = diary.createdAt
        case .updateDiary(let title, let content):
            newState.title = title
            newState.content = content
            
            var beforeDiary: Diary = newState.diary ?? Diary()

            PersistentStorage.shared.updateDiary(before: &beforeDiary, title: title, content: content, onSuccess: { onSuccess in
                print("onSuccess: \(onSuccess)")
            })
            
            delegate?.didWriteDiary()
        }
        
        return newState
    }
}
