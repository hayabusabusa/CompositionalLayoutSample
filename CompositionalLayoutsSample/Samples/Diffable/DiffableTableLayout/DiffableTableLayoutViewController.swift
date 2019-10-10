//
//  DiffableTableLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class DiffableTableLayoutViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private enum DiffableTableLayoutSection {
        case table
    }
    private var dataSource: UICollectionViewDiffableDataSource<DiffableTableLayoutSection, DiffableTableLayoutModel>!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureDataSource()
    }
    
    // MARK: Tap Event
    
    @objc
    func onTapBarButton(_ sender: UIBarButtonItem) {
        // - Current snapshot
        var updateModels = dataSource.snapshot().itemIdentifiers
        // - Append
        let red = Double.random(in: 0 ..< 255.0)
        let green = Double.random(in: 0 ..< 255.0)
        let blue = Double.random(in: 0 ..< 255.0)
        updateModels.append(DiffableTableLayoutModel(title: "RGB(\(Int(red)), \(Int(green)), \(Int(blue)))", red: red, green: green, blue: blue))
        // - Reload
        var snapshot = NSDiffableDataSourceSnapshot<DiffableTableLayoutSection, DiffableTableLayoutModel>()
        snapshot.appendSections([.table])
        snapshot.appendItems(updateModels)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    @objc
    func onRefresh(_ sender: UIRefreshControl) {
        // - Current snapshot
        let currentSnapshot = dataSource.snapshot()
        // - Sort
        let sorted = currentSnapshot.itemIdentifiers.sorted(by: { $1.sum < $0.sum })
        // - Reload
        var snapshot = NSDiffableDataSourceSnapshot<DiffableTableLayoutSection, DiffableTableLayoutModel>()
        snapshot.appendSections([.table])
        snapshot.appendItems(sorted)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        // - End Refresh
        collectionView.refreshControl?.endRefreshing()
    }
}

// MARK: - Configure

extension DiffableTableLayoutViewController {
    
    func configureNavigation() {
        navigationItem.title = "Diffable Table"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapBarButton(_:)))
    }
    
    func configureCollectionView() {
        // - CollectionView Layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        // - CollectionView
        let refreshControl = UIRefreshControl() // Large titleの場合はSafeareではなくsuperViewとのスペースを0にする
        refreshControl.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.delegate = self
        collectionView.register(DiffableTableLayoutCell.nib, forCellWithReuseIdentifier: DiffableTableLayoutCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DiffableTableLayoutSection, DiffableTableLayoutModel>(collectionView: collectionView) { (cv, indexPath, model) -> UICollectionViewCell? in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: DiffableTableLayoutCell.reuseIdentifier, for: indexPath) as! DiffableTableLayoutCell
            cell.configureCell(UIColor(red: CGFloat(model.red / 255.0), green: CGFloat(model.green / 255.0), blue: CGFloat(model.blue / 255.0), alpha: 1), title: model.title)
            return cell
        }
    }
}

// MARK: - CollectionView delegate

extension DiffableTableLayoutViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
