//
//  DiffableTableGridLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class DiffableTableGridLayoutViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private enum Section: Int, CaseIterable {
        case list
        case grid
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, DiffableTableGridLayoutModel>!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
    }
    
    // MARK: Tap event
    
    @objc
    func onTapBarButton(_ sender: UIBarButtonItem) {
        // TODO: 一部のみ更新したい場合は？
        // - Current
        var currentModels = dataSource.snapshot().itemIdentifiers(inSection: .list)
        // - Append
        let red = Double.random(in: 0 ..< 255.0)
        let green = Double.random(in: 0 ..< 255.0)
        let blue = Double.random(in: 0 ..< 255.0)
        currentModels.append(DiffableTableGridLayoutModel(TableModel(title: "RGB(\(Int(red)), \(Int(green)), \(Int(blue)))", red: red, green: green, blue: blue)))
        // - Snapshot
        var updatedSnapshot = NSDiffableDataSourceSnapshot<Section, DiffableTableGridLayoutModel>()
        updatedSnapshot.appendSections([.list])
        updatedSnapshot.appendItems(currentModels, toSection: .list)
        dataSource.apply(updatedSnapshot, animatingDifferences: true, completion: nil)
    }
}

// MARK: Configure

extension DiffableTableGridLayoutViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .list:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .grid:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        return layout
    }
    
    func configureNavigation() {
        navigationItem.title = "Table + Grid"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapBarButton(_:)))
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(DiffableTableLayoutCell.nib, forCellWithReuseIdentifier: DiffableTableLayoutCell.reuseIdentifier)
        collectionView.register(DiffableGridLayoutCell.nib, forCellWithReuseIdentifier: DiffableGridLayoutCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            // 思った以上に IndexPath に頼ってしまっているので
            // 新しいAPIの設計に沿った実装ができていない気がする。
            let section = Section(rawValue: indexPath.section)!
            
            switch section {
            case .list:
                // 改善したい
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiffableTableLayoutCell.reuseIdentifier, for: indexPath) as? DiffableTableLayoutCell,
                    let table = model.table else {
                        return nil
                }
                cell.configureCell(UIColor(red: CGFloat(table.red / 255), green: CGFloat(table.green / 255), blue: CGFloat(table.blue / 255), alpha: 1), title: table.title)
                return cell
            case .grid:
                // 改善したい
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiffableGridLayoutCell.reuseIdentifier, for: indexPath) as? DiffableGridLayoutCell,
                    let grid = model.grid else {
                        return nil
                }
                cell.configureCell(grid.title)
                return cell
            }
        }
        // - Initial dataSource
        var tables: [DiffableTableGridLayoutModel] = [DiffableTableGridLayoutModel]()
        for _ in 0 ..< 5 {
            let red = Double.random(in: 0 ..< 255.0)
            let green = Double.random(in: 0 ..< 255.0)
            let blue = Double.random(in: 0 ..< 255.0)
            tables.append(DiffableTableGridLayoutModel(TableModel(title: "RGB(\(Int(red)), \(Int(green)), \(Int(blue)))", red: red, green: green, blue: blue)))
        }
        
        var grids: [DiffableTableGridLayoutModel] = [DiffableTableGridLayoutModel]()
        for i in 0 ..< 20 {
            grids.append(DiffableTableGridLayoutModel(GridModel(title: "\(i)")))
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DiffableTableGridLayoutModel>()
        // - list
        snapshot.appendSections([.list])
        snapshot.appendItems(tables, toSection: .list)
        // - grid
        snapshot.appendSections([.grid])
        snapshot.appendItems(grids, toSection: .grid)
        dataSource.apply(snapshot)
    }
}

// MARK: - CollectionView delegate

extension DiffableTableGridLayoutViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
