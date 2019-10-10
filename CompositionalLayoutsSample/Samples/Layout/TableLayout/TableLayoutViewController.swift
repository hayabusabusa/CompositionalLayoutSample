//
//  TableLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class TableLayoutViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var sections: [Section] = [Section]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI

extension TableLayoutViewController {
    
    func setupUI() {
        // - Navigation
        navigationItem.title = "Table Layout"
        
        // - CollectionView Layout
        for i in 0 ..< 20 {
            sections.append(TableLayoutSection(title: "Row: \(i)"))
        }
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.sections[sectionIndex].layoutSection()
        }
        
        // - CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TableLayoutCell.nib, forCellWithReuseIdentifier: TableLayoutCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension TableLayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
}
