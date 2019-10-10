//
//  Section.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
