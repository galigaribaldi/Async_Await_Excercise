//
//  ViewController.swift
//  AsyncAwaitExcercise
//
//  Created by Hernán Galileo Cabrera Garibaldi on 04/10/21.
//

import UIKit


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


let apiCall = "https://www.andyibanez.com/fairesepages.github.io/tutorials/async-await/part1/"


func downloadImageAndMetadata(imageNumber: Int,
    completionHandler: @escaping (_ detailedImage: DetailedImage?, _ error: Error?) -> Void) {
    
    let imageUrl = URL(string: apiCall + "\(imageNumber).png")!
    
    DispatchQueue.global(qos: .background).async {
        let imageTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, let image = UIImage(data: data), (response as? HTTPURLResponse)?.statusCode == 200 else {
                completionHandler(nil, ImageDownloadError.badImage)
                return
            }
            let metadataUrl = URL(string: apiCall + "\(imageNumber).json")!
            let metadataTask = URLSession.shared.dataTask(with: metadataUrl) { data, response, error in
                guard let data = data, let metadata = try? JSONDecoder().decode(ImageMetadata.self, from: data),
                        (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completionHandler(nil, ImageDownloadError.invalidMetadata)
                    return
                }
                let detailedImage = DetailedImage(image: image, metadata: metadata)
                completionHandler(detailedImage, nil)
            }
            metadataTask.resume()
        }
        imageTask.resume()
    }
}

class ViewController: UIViewController {
    var imageURL = URL(string: "https://www.andyibanez.com/fairesepages.github.io/tutorials/async-await/part3/3.png")

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dataText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImageAndMetadata(imageNumber: 1) { detailedImage, error in
            if let detailedImage = detailedImage {
                DispatchQueue.main.async {
                    self.imageView.image = detailedImage.image
                    self.dataText.text = "\(detailedImage.metadata.name), \(detailedImage.metadata.firstAppearance), \(detailedImage.metadata.year)"
                }
            }
        }
    }
}
