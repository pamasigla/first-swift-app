//
//  Photo.swift
//  Intro to Swift
//
//  Created by Pauline Masigla on 2/27/18.
//  Copyright © 2018 Pauline Masigla. All rights reserved.
//

import Foundation

class Photo: Decodable {
    let id: String;
    let owner: String;
    let secret: String;
    let server: String;
    let farm: Int;
    let title: String;
    
    func imageUrl() -> URL? {
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg";
        return URL(string: urlString)
    }
}
