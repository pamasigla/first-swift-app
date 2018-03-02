//
//  PhotoPage.swift
//  Intro to Swift
//
//  Created by Pauline Masigla on 2/27/18.
//  Copyright © 2018 Pauline Masigla. All rights reserved.
//

import Foundation

class PhotoPage: Decodable {
    let page: Int;
    let pages: Int;
    let perpage: Int;
    let total: String;
    let photo: [Photo];
}
