//
//  DiffableGridLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class DiffableGridLayoutViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private enum DiffableGridSection {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<DiffableGridSection, Int>!
    
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
        var randomArray: [Int] = [Int]()
        
        for _ in 0 ..< 18 {
            randomArray.append(Int.random(in: 0 ..< 100))
        }
        
        // ユニークが保証されなければならないため
        // 同じ乱数が生成されると Fatal: supplied identifiers are not unique. が発生してクラッシュする
        let orderedSet = NSOrderedSet(array: randomArray)
        guard orderedSet.count == randomArray.count else {
            print("\(randomArray) <- 重複が発生")
            return
        }
        print(randomArray)
        
        var snapshot = NSDiffableDataSourceSnapshot<DiffableGridSection, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(randomArray)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

// MARK: - Configure

extension DiffableGridLayoutViewController {
    
    func configureNavigation() {
        navigationItem.title = "Diffable Grid"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onTapBarButton(_:)))
    }
    
    func configureCollectionView() {
        // - CollectionView Layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        // - CollectionView
        collectionView.register(DiffableGridLayoutCell.nib, forCellWithReuseIdentifier: DiffableGridLayoutCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DiffableGridSection, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiffableGridLayoutCell.reuseIdentifier, for: indexPath) as! DiffableGridLayoutCell
            cell.configureCell("\(identifier)")
            return cell
        }
        
        // Initial
//        var snapshot = NSDiffableDataSourceSnapshot<DiffableGridSection, Int>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems([0])
//        dataSource.apply(snapshot)
    }
}
