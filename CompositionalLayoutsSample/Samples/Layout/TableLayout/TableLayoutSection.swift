//
//  TableLayoutSection.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

struct TableLayoutSection: Section {
    // MARK: Properties
    
    let numberOfItems: Int = 1
    let title: String
    
    // MARK: Protocol
    
    func layoutSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableLayoutCell.reuseIdentifier, for: indexPath) as! TableLayoutCell
        cell.configureCell(title)
        return cell
    }
}
