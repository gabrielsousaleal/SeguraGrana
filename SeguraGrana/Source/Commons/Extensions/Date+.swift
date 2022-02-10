//
//  Date+.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 06/02/22.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "% dd @ MMMM"
        let rawString = dateFormatter.string(from: self)
        let string = rawString.replacingOccurrences(
            of: "%",
            with: "dia"
        ).replacingOccurrences(of: "@", with: "de"
        )

        return string
    }
}
