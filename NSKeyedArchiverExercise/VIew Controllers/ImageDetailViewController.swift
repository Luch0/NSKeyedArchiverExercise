//
//  ImageDetailViewController.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    var image: Image?
    
    @IBOutlet weak var onlineImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    
    @IBOutlet weak var imageSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = image else { return }
        imageSpinner.startAnimating()
        userLabel.text = "User: \(image.user)"
        viewsLabel.text = "Views: \(image.views.description)"
        favoritesLabel.text = "Favorites: \(image.favorites.description)"
        downloadsLabel.text = "Downloads: \(image.downloads.description)"
        let imageUrlStr = image.webformatURL
        let completion: (UIImage) -> Void = { (onlineImage: UIImage) in
            self.imageSpinner.stopAnimating()
            self.imageSpinner.isHidden = true
            self.onlineImage.image = onlineImage
            self.onlineImage.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: { print($0) })
    }
    
    
    @IBAction func addToFavesPressed(_ sender: UIButton) {
        guard let image = image else { return }
        let imageToSave = SaveImage(imageURL: image.webformatURL)
        DataModel.shared.addImageItemToList(imageItem: imageToSave)
    }
    

}
