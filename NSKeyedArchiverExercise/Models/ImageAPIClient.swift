//
//  ImageAPIClient.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = { (data: Data) in
            guard let onlineImage = UIImage(data: data) else { return }
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
