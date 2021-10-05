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
        DownloadImageMetadata(imageNumber: 1) { detailedImage, error in
            if let detailedImage = detailedImage {
                DispatchQueue.main.async {
                    self.imageView.image = detailedImage.image
                    self.dataText.text = "\(detailedImage.metadata.name), \(detailedImage.metadata.firstAppearance), \(detailedImage.metadata.year)"
                }
            }
        }
    }
}
