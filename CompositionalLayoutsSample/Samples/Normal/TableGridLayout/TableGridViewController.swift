//
//  TableGridViewController.swift
//  CompositionalLayoutsSample
//
//  Created by 山田隼也 on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class TableGridViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var sections: [Section] = [
        TableSection(models: [NormalTableModel(title: "Title", red: 222, green: 222, blue: 222)]),
        GridSection(models: [])
    ]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
    }
    
    // MARK: IBAction
    
    @objc
    func onTapBarButton(_ sender: UIBarButtonItem) {
        // - Remove
        sections.removeAll()
        // - Append
        let itemsPerSeciotn = Int.random(in: 15 ..< 30)
        var tableModels = [NormalTableModel]()
        var gridModels = [NormalGridModel]()
        for i in 0 ..< itemsPerSeciotn {
            let red = Double.random(in: 0 ..< 255.0)
            let green = Double.random(in: 0 ..< 255.0)
            let blue = Double.random(in: 0 ..< 255.0)
            
            tableModels.append(NormalTableModel(title: "RGB(\(Int(red)), \(Int(green)), \(Int(blue)))", red: red, green: green, blue: blue))
            gridModels.append(NormalGridModel(title: "\(i)"))
        }
        sections.append(TableSection(models: tableModels))
        sections.append(GridSection(models: gridModels))
        // - Reload
        collectionView.reloadData()
    }
}

// MARK: - Configure

extension TableGridViewController {
    
    func configureNavigation() {
        navigationItem.title = "Table + Grid"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onTapBarButton(_:)))
    }
    
    func configureCollectionView() {
        // - Layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.sections[sectionIndex].layoutSection()
        }
        // - CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DiffableTableLayoutCell.nib, forCellWithReuseIdentifier: DiffableTableLayoutCell.reuseIdentifier)
        collectionView.register(DiffableGridLayoutCell.nib, forCellWithReuseIdentifier: DiffableGridLayoutCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: - CollectionView dataSource, delegate

extension TableGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
