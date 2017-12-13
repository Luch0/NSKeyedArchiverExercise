//
//  NetworkHelper.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() { }
    static let manager = NetworkHelper()
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
}
