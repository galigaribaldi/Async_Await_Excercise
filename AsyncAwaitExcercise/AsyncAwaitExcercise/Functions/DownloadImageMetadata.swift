//
//  DownloadImageMetadata.swift
//  AsyncAwaitExcercise
//
//  Created by Hernán Galileo Cabrera Garibaldi on 05/10/21.
//

import Foundation
import UIKit

//  MARK: Function Download
func DownloadImageMetadata(imageNumber: Int,
    completionHandler: @escaping (_ detailedImage: DetailedImage?, _ error: Error?) -> Void) {
    
    let imageUrl = URL(string: apiBase + "\(imageNumber).png")!
    
    DispatchQueue.global(qos: .background).async {
        let imageTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, let image = UIImage(data: data), (response as? HTTPURLResponse)?.statusCode == 200 else {
                completionHandler(nil, ImageDownloadError.badImage)
                return
            }
            let metadataUrl = URL(string: apiBase + "\(imageNumber).json")!
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
