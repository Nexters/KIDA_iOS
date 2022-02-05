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
        static let title = "오늘의 짝꿍을 느낌충만하게 뽑아봐!"
        static let confirmButtonTitle = "이 친구로 뽑을래?"
    }

    /// WriteDiaryViewController 에서 사용하는 문자열을 관리합니다.
    enum WriteDiary {
        static let textViewPlaceholder = "공백 포함 150자 이내로 써주세요."
        static let todayKeyword = "오늘의 키워드"
        static let titleTextFieldPlaceholder = "제목"
        static let writeButtonTitle = "작성하기"
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
