//
//  DiffableDistinctLayoutGridCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class DiffableDistinctLayoutGridCell: UICollectionViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var colorView: UIView!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DiffableDistinctLayoutGridCell"
    static var nib: UINib {
        return UINib(nibName: "DiffableDistinctLayoutGridCell", bundle: nil)
    }

    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Configure
    
    func configureCell(_ color: UIColor?) {
        colorView.backgroundColor = color
    }
}
