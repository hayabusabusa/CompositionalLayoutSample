//
//  NormalTableModel.swift
//  CompositionalLayoutsSample
//
//  Created by 山田隼也 on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

struct TableSection: Section {
    let models: [NormalTableModel]
    var numberOfItems: Int {
        return models.count
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiffableTableLayoutCell.reuseIdentifier, for: indexPath) as! DiffableTableLayoutCell
        let model = models[indexPath.row]
        cell.configureCell(UIColor(red: CGFloat(model.red / 255), green: CGFloat(model.green / 255), blue: CGFloat(model.blue / 255), alpha: 1), title: model.title)
        return cell
    }
}

struct NormalTableModel {
    let title: String
    let red: Double
    let green: Double
    let blue: Double
}
