//
//  DataModel.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import Foundation

class DataModel {
    
    static let kPathName = "imagesListKeyedArchiver.plist"
    
    private init() { }
    static let shared = DataModel()
    
    private var imagesList = [SaveImage]() {
        didSet {
            saveImageList()
        }
    }
    
    // returns documents directory path for the app
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // returns supplied path name in documents directory
    func dataFilePath(pathName: String) -> URL {
        return DataModel.shared.documentsDirectory().appendingPathComponent(pathName)
    }
    
    // save
    func saveImageList() {
        let path = DataModel.shared.dataFilePath(pathName: DataModel.kPathName).path
        NSKeyedArchiver.archiveRootObject(imagesList, toFile: path)
    }
    
    // load
    func load () {
        let path = DataModel.shared.dataFilePath(pathName: DataModel.kPathName).path
        if let results = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [SaveImage] {
            imagesList = results
        }
    }
    
    // create
    func addImageItemToList(imageItem item: SaveImage) {
        imagesList.append(item)
    }
    
    // read
    func getLists() -> [SaveImage] {
        return imagesList
    }
    
    // delete
    func removeImageItem(fromIndex index: Int) {
        imagesList.remove(at: index)
    }
    
    // update
    
}
