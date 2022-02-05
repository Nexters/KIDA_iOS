//
//  Date+.swift
//  KIDA
//
//  Created by choidam on 2022/02/05.
//

import Foundation

enum DateFormat: String {
    case format1 = "yyyy.MM.dd"
}

extension Date {
    func formatter(_ format: DateFormat) -> DateFormatter {
        return DateFormatter().then {
            $0.dateFormat = format.rawValue
        }
    }
    
    var toStringTypeOne: String {
        return formatter(.format1).string(from: self)
    }
}
