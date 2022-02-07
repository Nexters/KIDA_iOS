//
//  KIDA_String.swift
//  KIDA
//
//  Created by Ian on 2022/02/01.
//

import Foundation

/// 프로젝트 내에 사용되는 모든 하드코드 문자열을 관리하는 열거형입니다.
/// 열거형 내부에서 Scene에 따라 별개의 enum으로 분리하여 관리합니다.
enum KIDA_String {

    /// PersistentStorage 에서 사용하는 문자열을 관리합니다.
    enum PersistentStorage {
        static let entityName = "Diary"
    }

    /// SplashViewController 에서 사용하는 문자열을 관리합니다.
    enum Splash {
        static let splashImage = "splash"
    }

    /// KeywordSelectViewController 에서 사용하는 문자열을 관리합니다.
    enum KeywordSelect {
        static let titleOne = "오늘의 키워드를"
        static let titleTwo = "선택해봐!"
        static let confirmButtonTitle = "뽑아볼까?"
    }

    /// WriteDiaryViewController 에서 사용하는 문자열을 관리합니다.
    enum WriteDiary {
        static let pickedKeyword = "뽑은 키워드"
        static let titleLabel = "제목"
        static let titlePlaceholder = "공백 포함 20자"
        static let contentLabel = "내용"
        static let contentTextViewPlaceholder = "공백 포함 150자"
        static let writeButtonTitle = "작성 완료"
    }

    /// DiaryListViewController 에서 사용하는 문자열을 관리합니다.
    enum DiaryList {
        static let navigationTitle = "내 일기"
        static let headerTitle = "내가 쓴 일기"
    }

    /// SelectedKeywordViewController 에서 사용하는 문자열을 관리합니다.
    enum SelectedKeyword {
        static let todayKeyword = "오늘의 키워드"
        static let confirmButtonTitle = "글쓰러 가자"
        static let cancelButtonTitle = "다시 뽑을래"
    }
}
