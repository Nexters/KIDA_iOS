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
        case setTitle(String)
        case setContent(String)
        case didTapWriteButton(_ diary: DiaryModel, didSuccess: Bool)
        case setEditDiary(DiaryModel)
    }
    
    enum Mutation {
        case setTitle(String)
        case setContent(String)
        case didTapWriteButton(_ diary: DiaryModel, didSuccess: Bool)
        case setEditDiary(DiaryModel)
        
        var bindMutation: BindMutation {
            switch self {
            case .setTitle:
                return .setTitle
            case .setContent:
                return .setContent
            case .didTapWriteButton:
                return .didTapWriteButton
            case .setEditDiary:
                return .setEditDiary
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case setTitle
        case setContent
        case didTapWriteButton
        case setEditDiary
    }

    struct State {
        var state: BindMutation = .initialState
        
        var didSuccessCreateDiary: Bool = false
        var isEditing: Bool = false
        
        var diary: DiaryModel?
        var keyword: String?
        var title: String?
        var content: String?
        var createdAt: Date?
    }

    // MARK: - Properties
    var initialState: State
    weak var delegate: WriteDiaryReactorDelegate?

    // MARK: - Initializer
    init(isEditing: Bool? = false, diary: DiaryModel? = nil) {
        self.initialState = State()
        
        guard let isEditing = isEditing else { return }
        guard let diary = diary else { return }

        initialState.isEditing = isEditing
        
        if isEditing == true {
            action.onNext(.setEditDiary(diary))
        }
    }

    // MARK: - Methods
    
    func mutate(action: Action) -> Observable<Mutation> {
        var didSuccessCreate: Bool = false
        
        switch action {
        case .setTitle(let title):
            return .just(.setTitle(title))
        case .setContent(let content):
            return .just(.setContent(content))
        case .didTapWriteButton(let diary, _):
            PersistentStorage.shared.createDiary(diary, onSuccess: { success in
                didSuccessCreate = success
            })
            return .just(.didTapWriteButton(diary, didSuccess: didSuccessCreate))
        case .setEditDiary(let diary):
            return .just(.setEditDiary(diary))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.state = mutation.bindMutation
        
        switch mutation {
        case .setTitle(let title):
            newState.title = title
        case .setContent(let content):
            newState.content = content
            print("@@@@@@@ newstate content: \(newState.content)")
            
        case .didTapWriteButton(_, let didSuccess):
            newState.didSuccessCreateDiary = didSuccess
            if didSuccess {
                // 리스트뷰로 화면 전환 예정
                self.delegate?.didWriteDiary()
            }
        case .setEditDiary(let diary):
            newState.keyword = diary.keyword
            newState.title = diary.title
            newState.content = diary.content
            newState.createdAt = diary.createdAt
        }
        
        return newState
    }
}
