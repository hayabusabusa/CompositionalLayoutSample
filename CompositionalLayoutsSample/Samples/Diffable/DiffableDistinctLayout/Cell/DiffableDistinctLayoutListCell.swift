//
//  DiffableDistinctLayoutListCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/10.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class DiffableDistinctLayoutListCell: UICollectionViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DiffableDistinctLayoutListCell"
    static var nib: UINib {
        return UINib(nibName: "DiffableDistinctLayoutListCell", bundle: nil)
    }

    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }

    // MARK: Configure
    
    func configureCell(_ color: UIColor?, title: String, desc: String) {
        colorView.backgroundColor = color
        titleLabel.text = title
        descLabel.text = desc
    }
}
