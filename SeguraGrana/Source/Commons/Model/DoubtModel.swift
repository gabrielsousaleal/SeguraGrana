//
//  DoubtModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation

struct DoubtModel: Codable {
    var value: Double
    var name: String
    var category: DoubtCategoryModel
    var isReccurent: Bool
    var deadline: Int
    var date: Date? = nil
}
