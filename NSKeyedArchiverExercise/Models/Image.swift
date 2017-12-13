//
//  Image.swift
//  NSKeyedArchiverExercise
//
//  Created by Luis Calle on 12/12/17.
//  Copyright © 2017 Luis Calle. All rights reserved.
//

import Foundation

struct ImagesResponse: Codable {
    let totalHits: Int
    let hits: [Image]
}

struct Image: Codable {
    let likes: Int
    let favorites: Int
    let views: Int
    let comments: Int
    let downloads: Int
    let previewURL: String
    let webformatURL: String
    let user_id: Int
    let user: String
    let type: String
    let id: Int
}
