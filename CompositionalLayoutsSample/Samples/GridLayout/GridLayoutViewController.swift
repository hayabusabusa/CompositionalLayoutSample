//
//  GridLayoutViewController.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

final class GridLayoutViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var sections: [Section] = [Section]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI

extension GridLayoutViewController {
    
    func setupUI() {
        // - Navigation
        navigationItem.title = "Grid Layout"
        
        // - CollectionView Layout
        for _ in 0 ..< 10 {
            sections.append(GridLayoutSection())
        }
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self.sections[sectionIndex].layoutSection()
        }
        
        // - CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GridLayoutCell.nib, forCellWithReuseIdentifier: GridLayoutCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - CollectionView DataSource, Delegate

extension GridLayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
