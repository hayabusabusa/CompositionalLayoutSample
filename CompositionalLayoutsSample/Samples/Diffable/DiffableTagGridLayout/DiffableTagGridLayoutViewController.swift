//
//  DiffableTagGridLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/11.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class DiffableTagGridLayoutViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<DiffableTagGridSection, DiffableTagGridItem>!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
    }
}

// MARK: - Configure

extension DiffableTagGridLayoutViewController {
    
    func configureNavigation() {
        navigationItem.title = "Tag + Grid"
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let section = DiffableTagGridSection(rawValue: sectionIndex) else { return nil }
            switch section {
            case .tag:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 2)
                
                return section
            case .grid:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2) // Inset
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 2, bottom: 44, trailing: 2)
                return section
            }
        }
        return layout
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(DTGTagCell.nib, forCellWithReuseIdentifier: DTGTagCell.reuseIdentifier)
        collectionView.register(DTGGridCell.nib, forCellWithReuseIdentifier: DTGGridCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.itemType {
            case .tag(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DTGTagCell.reuseIdentifier, for: indexPath) as! DTGTagCell
                cell.configureCell(model.title, color: UIColor(red: CGFloat(Double(model.color.r) / 255.0),
                                                               green: CGFloat(Double(model.color.g) / 255.0),
                                                               blue: CGFloat(Double(model.color.b) / 255.0), alpha: 1))
                return cell
            case .grid(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DTGGridCell.reuseIdentifier, for: indexPath) as! DTGGridCell
                cell.configureCell(UIColor(red: CGFloat(Double(model.color.r) / 255.0),
                                           green: CGFloat(Double(model.color.g) / 255.0),
                                           blue: CGFloat(Double(model.color.b) / 255.0), alpha: 1))
                return cell
            }
        }
        // - Initial
        var tags: [DiffableTagGridItem] = [DiffableTagGridItem]()
        var grids: [DiffableTagGridItem] = [DiffableTagGridItem]()
        for _ in 0 ..< 15 {
            let red = Int.random(in: 0 ..< 255)
            let green = Int.random(in: 0 ..< 255)
            let blue = Int.random(in: 0 ..< 255)
            
            tags.append(DiffableTagGridItem(itemType: .tag(model: DiffableTagModel(title: "RGB(\(Int(red)), \(Int(green)), \(Int(blue)))",color: Color(r: red, g: green, b: blue)))))
            grids.append(DiffableTagGridItem(itemType: .grid(model: DiffableGridModel(color: Color(r: red, g: green, b: blue)))))
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<DiffableTagGridSection, DiffableTagGridItem>()
        snapshot.appendSections([.tag])
        snapshot.appendItems(tags.shuffled(), toSection: .tag)
        snapshot.appendSections([.grid])
        snapshot.appendItems(grids.shuffled(), toSection: .grid)
        dataSource.apply(snapshot)
    }
}

// MARK: - CollectionView Delegate

extension DiffableTagGridLayoutViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
