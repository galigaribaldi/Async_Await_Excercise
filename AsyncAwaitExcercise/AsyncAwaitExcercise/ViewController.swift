//
//  ViewController.swift
//  AsyncAwaitExcercise
//
//  Created by Hernán Galileo Cabrera Garibaldi on 04/10/21.
//

import UIKit

class ViewController: UIViewController {
//  MARK: Outlets to StoryBoard
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//   MARK: Opcion 1 With DataTask
/*
        DownloadImageMetadata(imageNumber: 1) { detailedImage, error in
            if let detailedImage = detailedImage {
                DispatchQueue.main.async {
                    self.imageView.image = detailedImage.image
                    self.dataText.text = "\(detailedImage.metadata.name), \(detailedImage.metadata.firstAppearance), \(detailedImage.metadata.year)"
                }
            }
        }
 */
//     MARK: Opcion 2
    let imageUrl = URL(string: apiBase + "\(1).png")!
    let DataURL = URL(string: apiBase + "\(1).json")!
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: imageUrl)
            guard let image = UIImage(data: data!) else {
                print("Error!")
                return
            }
            let dataInfo = try? Data(contentsOf:  DataURL)
            let metadata = try? JSONDecoder().decode(ImageMetadata.self, from: dataInfo!)
            DispatchQueue.main.async {
                self.imageView.image = image
                self.dataText.text = metadata?.name
                print("El nombre es: \(metadata!.name), el año es: \(metadata!.year)")
            }
        }
    }
}

