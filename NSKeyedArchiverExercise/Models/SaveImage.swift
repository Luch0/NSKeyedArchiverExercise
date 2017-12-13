//
//  SaveImage.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import Foundation

enum ImagePropertyKeys: String {
    case imageurl
}

class SaveImage: NSObject, NSCoding {
    
    var imageURL: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageURL, forKey: ImagePropertyKeys.imageurl.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let url = aDecoder.decodeObject(forKey: ImagePropertyKeys.imageurl.rawValue) as? String else  { return nil }
        self.init(imageURL: url)
    }
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
}
