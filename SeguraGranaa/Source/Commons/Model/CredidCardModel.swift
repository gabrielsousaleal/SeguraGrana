//
//  CredidCardModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 02/02/22.
//

import Foundation

struct CreditCardModel: Codable {
    var name: String
    var deadline: Date
    var totalDoubts: Double = 0
    var doubts: [DoubtModel] = []
}
