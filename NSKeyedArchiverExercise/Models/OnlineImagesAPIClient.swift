//
//  OnlineImagesAPIClient.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import Foundation

struct OnlineImagesAPIClient {
    private init() {}
    static let manager = OnlineImagesAPIClient()
    func getImages(from urlStr: String, completionHandler: @escaping ([Image]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let imagesResponse = try JSONDecoder().decode(ImagesResponse.self, from: data)
                completionHandler(imagesResponse.hits)
            }
            catch let error {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
