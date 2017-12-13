//
//  FavoritesDetailViewController.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import UIKit

class FavoritesDetailViewController: UIViewController {
    
    var favImage: SaveImage?

    @IBOutlet weak var favImagePic: UIImageView!
    @IBOutlet weak var favImageSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let favImage = favImage else { return }
        favImageSpinner.startAnimating()
        let favImageUrlStr = favImage.imageURL
        let completion: (UIImage) -> Void = { (onlineFavImage: UIImage) in
            self.favImageSpinner.stopAnimating()
            self.favImageSpinner.isHidden = true
            self.favImagePic.image = onlineFavImage
            self.favImagePic.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: favImageUrlStr, completionHandler: completion, errorHandler: { print($0) })
    }

}
