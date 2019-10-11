//
//  DiffableTagGridModel.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/11.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

// MARK: - Item

struct DiffableTagGridItem: Hashable {
    let identifier: UUID = UUID()
    
    enum ItemType {
        case tag(model: DiffableTagModel)
        case grid(model: DiffableGridModel)
    }
    let itemType: ItemType
    
    static func == (lhs: DiffableTagGridItem, rhs: DiffableTagGridItem) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

// MARK: - Section

enum DiffableTagGridSection: Int, CaseIterable {
    case tag
    case grid
}

// MARK: - Model

struct DiffableTagModel {
    let title: String
    let color: Color
}

struct DiffableGridModel {
    let color: Color
}

struct Color {
    let r: Int
    let g: Int
    let b: Int
    var rgbCode: String {
        return "\(r)_\(g)_\(b)"
    }
}
