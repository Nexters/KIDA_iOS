//
//  ObservableConvertibleType+.swift
//  KIDA
//
//  Created by Ian on 2022/01/17.
//

import RxCocoa

extension ObservableConvertibleType {
    func asDriverSkipError() -> Driver<Element> {
        return asDriver(onErrorDriveWith: .empty())
    }
}
