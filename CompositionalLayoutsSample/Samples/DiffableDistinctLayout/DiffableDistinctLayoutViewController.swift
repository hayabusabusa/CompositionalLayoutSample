//
//  DiffableDistinctLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class DiffableDistinctLayoutViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    // rawValueを使いたいためIntを継承
    private enum DistinctSection: Int, CaseIterable {
        case list
        case grid
        // - Number of collums
        var collums: Int {
            switch self {
            case .list:
                return 1
            case .grid:
                return 3
            }
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<DistinctSection, Int>!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
    }
}

// MARK: - Configure

extension DiffableDistinctLayoutViewController {
    
    func configureNavigation() {
        navigationItem.title = "Distinct Layout"
    }
    
    func createLayout() -> UICollectionViewLayout {
        // セクションごとにLayoutを返してくれる？
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = DistinctSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .list:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94), heightDimension: .absolute(88 * 2))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered // Paging
                return section
            case .grid:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2) // Inset
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 2, bottom: 0, trailing: 2)
                return section
            }
        }
        return layout // 返しの NSCollectionLayoutSection? はOptionalなのに?
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(DiffableDistinctLayoutListCell.nib, forCellWithReuseIdentifier: DiffableDistinctLayoutListCell.reuseIdentifier)
        collectionView.register(DiffableDistinctLayoutGridCell.nib, forCellWithReuseIdentifier: DiffableDistinctLayoutGridCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DistinctSection, Int>(collectionView: collectionView) { (cv, indexPath, identifier) -> UICollectionViewCell? in
            let section = DistinctSection(rawValue: indexPath.section)!
            switch section {
            case .list:
                let cell = cv.dequeueReusableCell(withReuseIdentifier: DiffableDistinctLayoutListCell.reuseIdentifier, for: indexPath) as! DiffableDistinctLayoutListCell
                cell.configureCell(.systemGroupedBackground, title: "Identifier: \(identifier)", desc: "\(indexPath)")
                return cell
            case .grid:
                let cell = cv.dequeueReusableCell(withReuseIdentifier: DiffableDistinctLayoutGridCell.reuseIdentifier, for: indexPath) as! DiffableDistinctLayoutGridCell
                cell.configureCell(.systemGroupedBackground)
                return cell
            }
        }
        // - Initial dataSource
        // NavigationBar が LargeTitleの場合、
        // スクロールできるかどうかの間の時にスクロール領域がバグるので動的な画面は注意
        let itemsPerSection = 17 // iPhoneXS は 11 でバグ
        var snapshot = NSDiffableDataSourceSnapshot<DistinctSection, Int>()
        DistinctSection.allCases.forEach {
            print($0)
            snapshot.appendSections([$0])
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        dataSource.apply(snapshot)
    }
}

// MARK: CollectionView delegate

extension DiffableDistinctLayoutViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
