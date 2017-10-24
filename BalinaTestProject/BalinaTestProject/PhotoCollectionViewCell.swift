//
//  PhotoCollectionViewCell.swift
//  BalinaTestProject
//
//  Created by Daniel Nesterenko on 05.10.17.
//  Copyright © 2017 DevAndCraft. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var photoDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
