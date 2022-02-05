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
    }

    struct State {
        var didSuccessCreateDiary: Bool = false
    }

    // MARK: - Properties
    var initialState: State
    weak var delegate: WriteDiaryReactorDelegate?

    // MARK: - Initializer
    init() {
        self.initialState = State()
    }

    // MARK: - Methods

    func mutate(action: Action) -> Observable<Action> {
        var didSuccessCreate: Bool = false

        switch action {
        case .didTapWriteButton(let diary, _):
            PersistentStorage.shared.createDiary(diary, onSuccess: { success in
                didSuccessCreate = success
            })
            return Observable.just(.didTapWriteButton(diary, didSuccess: didSuccessCreate))
        }
    }

    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didTapWriteButton(_, let didSuccess):
            newState.didSuccessCreateDiary = didSuccess
            if didSuccess {
                // 리스트뷰로 화면 전환 예정
                self.delegate?.didWriteDiary()
            }
        }

        return newState
    }
}
