//
//  DTGGridCell.swift
//  CompositionalLayoutsSample
//
//  Created by Yamada Shunya on 2019/10/11.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class DTGGridCell: UICollectionViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var colorView: UIView!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DTGGridCell"
    static var nib: UINib {
        return UINib(nibName: "DTGGridCell", bundle: nil)
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
