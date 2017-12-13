//
//  ImagesSearchViewController.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import UIKit

class ImagesSearchViewController: UIViewController {

    @IBOutlet weak var imagesTableView: UITableView!
    @IBOutlet weak var imageSearchBar: UISearchBar!
    
    var images = [Image]() {
        didSet {
            self.imagesTableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadImagesIntoTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagesTableView.delegate = self
        self.imagesTableView.dataSource = self
        self.imageSearchBar.delegate = self
        loadImagesIntoTableView()
    }
    
    func loadImagesIntoTableView() {
        if searchTerm == "" {
            images = []
            return
        }
        let urlStr = "https://pixabay.com/api/?key=7290172-07f01a2f73666a4c5696bb2f4&q=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))"
        let completion = {(onlineImages: [Image]) in
            self.images = onlineImages
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        OnlineImagesAPIClient.manager.getImages(from: urlStr, completionHandler: completion, errorHandler: printErrors)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageDetailViewController {
            destination.image = images[(imagesTableView.indexPathForSelectedRow?.row)!]
        }
    }

}

extension ImagesSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "Image Cell", for: indexPath)
        let selectedImage = images[indexPath.row]
        if let imageCell = imageCell as? CustomImageTableViewCell {
            imageCell.imageSpinner.startAnimating()
            imageCell.imageSpinner.isHidden = false
            imageCell.onlineImage.image = nil
            let imageUrlStr = selectedImage.webformatURL
            let completion: (UIImage) -> Void = { (onlineImage: UIImage) in
                imageCell.imageSpinner.stopAnimating()
                imageCell.imageSpinner.isHidden = true
                imageCell.onlineImage.image = onlineImage
                imageCell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: { print($0) })
        }
        return imageCell
    }
    
}

extension ImagesSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchBar.text!
    }
}

