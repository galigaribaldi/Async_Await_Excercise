//
//  Structures.swift
//  AsyncAwaitExcercise
//
//  Created by Hernán Galileo Cabrera Garibaldi on 05/10/21.
//

import Foundation
import UIKit
//  MARK: Constants and Structures of this Scope
struct ImageMetadata: Codable {
    let name: String
    let firstAppearance: String
    let year: Int
}

struct DetailedImage {
    let image: UIImage
    let metadata: ImageMetadata
}

enum ImageDownloadError: Error {
    case badImage
    case invalidMetadata
}


let apiBase = "https://www.andyibanez.com/fairesepages.github.io/tutorials/async-await/part1/"

