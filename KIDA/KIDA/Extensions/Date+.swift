//
//  Date+.swift
//  KIDA
//
//  Created by choidam on 2022/02/05.
//

import Foundation

enum DateFormat: String {
    case format1 = "yyyy.MM.dd"
    case format2 = "MM.dd(EE)"
}

extension Date {
    func formatter(_ format: DateFormat) -> DateFormatter {
        return DateFormatter().then {
            $0.dateFormat = format.rawValue
            $0.locale = Locale(identifier: "ko")
        }
    }
    
    var toStringTypeOne: String {
        return formatter(.format1).string(from: self)
    }
    
    var toStringTypeTwo: String {
        return formatter(.format2).string(from: self)
    }
}
