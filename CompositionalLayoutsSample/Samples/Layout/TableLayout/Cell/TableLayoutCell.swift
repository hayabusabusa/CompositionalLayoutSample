//
//  TableLayoutCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/09.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class TableLayoutCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "TableLayoutCell"
    static var nib: UINib {
        return UINib(nibName: "TableLayoutCell", bundle: nil)
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
