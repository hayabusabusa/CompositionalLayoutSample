//
//  DTGTagCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/11.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class DTGTagCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DTGTagCell"
    static var nib: UINib {
        return UINib(nibName: "DTGTagCell", bundle: nil)
    }
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Configure
    
    func configureCell(_ title: String, color: UIColor?) {
        colorView.backgroundColor = color
        titleLabel.text = title
    }
}
