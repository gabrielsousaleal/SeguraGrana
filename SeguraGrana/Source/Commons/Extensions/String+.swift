//
//  String+.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation

extension String {
    static var empty = String()

    func isBackSpace() -> Bool {
        if let char = cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        return false
    }

    func getDateMonthAndDay() -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "pt_br")
        dateFormatterPrint.dateFormat = "MMM dd"

        return dateFormatterGet.date(from: self)
    }

    func isValidDayOfMounth() -> Bool {
        let double = Double(self) ?? 0
        return double <= 31 && double > 0
    }
}
