//
//  CustomImageTableViewCell.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import UIKit

class CustomImageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var onlineImage: UIImageView!
    @IBOutlet weak var imageSpinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
