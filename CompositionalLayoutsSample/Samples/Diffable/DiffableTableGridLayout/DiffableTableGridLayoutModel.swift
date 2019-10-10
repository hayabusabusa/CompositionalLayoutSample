//
//  DiffableTableGridLayoutModel.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct DiffableTableGridLayoutModel: Hashable {
    let id: UUID = UUID()
    let table: TableModel? // 改善したい
    let grid: GridModel? // 改善したい
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    init(_ table: TableModel) {
        self.table = table
        self.grid = nil
    }
    
    init(_ grid: GridModel) {
        self.table = nil
        self.grid = grid
    }
}

struct TableModel: Hashable {
    let id: UUID = UUID()
    let title: String
    let red: Double
    let green: Double
    let blue: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

struct GridModel: Hashable {
    let id: UUID = UUID()
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
