//
//  FavoritesViewController.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var faveImagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.faveImagesTableView.delegate = self
        self.faveImagesTableView.dataSource = self
        DataModel.shared.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.faveImagesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FavoritesDetailViewController {
            destination.favImage = DataModel.shared.getLists()[(faveImagesTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.getLists().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favImageCell = tableView.dequeueReusableCell(withIdentifier: "Fav Image Cell", for: indexPath)
        let selectedFavImage = DataModel.shared.getLists()[indexPath.row]
        if let favImageCell = favImageCell as? CustomFavImageTableViewCell {
            favImageCell.favImageSpinner.startAnimating()
            favImageCell.favImageSpinner.isHidden = false
            favImageCell.favImage.image = nil
            let imageUrlStr = selectedFavImage.imageURL
            let completion: (UIImage) -> Void = { (onlineImage: UIImage) in
                favImageCell.favImageSpinner.stopAnimating()
                favImageCell.favImageSpinner.isHidden = true
                favImageCell.favImage.image = onlineImage
                favImageCell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: { print($0) })
        }
        return favImageCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DataModel.shared.removeImageItem(fromIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
    
}
