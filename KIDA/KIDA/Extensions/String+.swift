//
//  String+.swift
//  KIDA
//
//  Created by Ian on 2022/02/01.
//

import Foundation

extension String {
    static let navBarDateTitle: String = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "MM.dd(E)"
        return formatter.string(from: Date())
    }()
}
