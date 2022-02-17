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
        case setEditDiary(DiaryModel)
    }
    
    enum Mutation {
        case didTapWriteButton(_ diary: DiaryModel, didSuccess: Bool)
        case setEditDiary(DiaryModel)
        
        var bindMutation: BindMutation {
            switch self {
            case .didTapWriteButton:
                return .didTapWriteButton
            case .setEditDiary:
                return .setEditDiary
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case didTapWriteButton
        case setEditDiary
    }

    struct State {
        var state: BindMutation = .initialState
        
        var didSuccessCreateDiary: Bool = false
        
        var diary: DiaryModel?
        var keyword: String?
        var title: String?
        var content: String?
    }

    // MARK: - Properties
    var initialState: State
    weak var delegate: WriteDiaryReactorDelegate?

    // MARK: - Initializer
    init(isEditing: Bool? = false, diary: DiaryModel? = nil) {
        self.initialState = State()
        
        if isEditing == true {
            guard let diary = diary else { return }
            action.onNext(.setEditDiary(diary))
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
        case .setEditDiary(let diary):
            return .just(.setEditDiary(diary))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        newState.state = mutation.bindMutation
        
        switch mutation {
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
        }
        
        return newState
    }
    

//    func mutate(action: Action) -> Observable<Action> {
//        var didSuccessCreate: Bool = false
//
//        switch action {
//        case .didTapWriteButton(let diary, _):
//            PersistentStorage.shared.createDiary(diary, onSuccess: { success in
//                didSuccessCreate = success
//            })
//            return Observable.just(.didTapWriteButton(diary, didSuccess: didSuccessCreate))
//        }
//    }
//
//    func reduce(state: State, mutation: Action) -> State {
//        var newState = state
//        switch mutation {
//        case .didTapWriteButton(_, let didSuccess):
//            newState.didSuccessCreateDiary = didSuccess
//            if didSuccess {
//                // 리스트뷰로 화면 전환 예정
//                self.delegate?.didWriteDiary()
//            }
//        }
//
//        return newState
//    }
}
