//
//  NormalGridModel.swift
//  CompositionalLayoutsSample
//
//  Created by 山田隼也 on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

struct GridSection: Section {
    let models: [NormalGridModel]
    var numberOfItems: Int {
        return models.count
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiffableGridLayoutCell.reuseIdentifier, for: indexPath) as! DiffableGridLayoutCell
        let model = models[indexPath.row]
        cell.configureCell(model.title)
        return cell
    }
}

struct NormalGridModel {
    let title: String
}
