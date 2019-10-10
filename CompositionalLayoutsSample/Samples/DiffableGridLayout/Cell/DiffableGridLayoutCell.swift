//
//  DiffableGridLayoutCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class DiffableGridLayoutCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DiffableGridLayoutCell"
    static var nib: UINib {
        return UINib(nibName: "DiffableGridLayoutCell", bundle: nil)
    }
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
    
    // MARK: Configure Cell
    
    func configureCell(_ title: String) {
        titleLabel.text = title
    }
}
