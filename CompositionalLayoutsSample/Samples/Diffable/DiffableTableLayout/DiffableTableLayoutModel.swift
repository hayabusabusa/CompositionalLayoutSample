//
//  DiffableTableLayoutModel.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct DiffableTableLayoutModel: Hashable {
    let id: UUID = UUID()
    let title: String
    // - Color
    let red: Double
    let green: Double
    let blue: Double
    
    var sum: Double {
        return red + green + blue
    }
    
    // - Required
    static func == (lhs: DiffableTableLayoutModel, rhs: DiffableTableLayoutModel) -> Bool {
        return lhs.id == rhs.id
    }
}
