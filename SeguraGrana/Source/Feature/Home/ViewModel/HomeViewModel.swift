//
//  HomeViewModel.swift
//  SeguraGrana
//
//  Created by Gabriel Sousa Leal on 05/02/22.
//

import Foundation

class HomeViewModel {

    // MARK: - Private Properties

    private var defaultDoubtCategories: [DoubtCategoryModel] {
        [
            DoubtCategoryModel(name: "Saúde",
                               icon: "health"),
            DoubtCategoryModel(name: "Lazer",
                               icon: "play"),
            DoubtCategoryModel(name: "Mercado",
                               icon: "market"),
            DoubtCategoryModel(name: "Uber",
                               icon: "uber"),
            DoubtCategoryModel(name: "Carro",
                               icon: "car"),
            DoubtCategoryModel(name: "Casa",
                               icon: "house")
        ]
    }
}
