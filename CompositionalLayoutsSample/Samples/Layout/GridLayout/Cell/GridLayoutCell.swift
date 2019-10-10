//
//  GridLayoutCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class GridLayoutCell: UICollectionViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "GridLayoutCell"
    static var nib: UINib {
        return UINib(nibName: "GridLayoutCell", bundle: nil)
    }

    // MARK: Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: Configure
    
    func configureCell(_ title: String) {
        titleLabel.text = title
    }
}
