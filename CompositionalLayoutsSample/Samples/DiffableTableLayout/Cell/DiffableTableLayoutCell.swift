//
//  DiffableTableLayoutCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class DiffableTableLayoutCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DiffableTableLayoutCell"
    static var nib: UINib {
        return UINib(nibName: "DiffableTableLayoutCell", bundle: nil)
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
    
    // MARK: Configure
    
    func configureCell(_ color: UIColor?, title: String) {
        colorView.backgroundColor = color
        titleLabel.text = title
    }
}
