# Async Await Excercise

This Repository is from to the third Project about IO's development Degree.

## **What is it?** 

This is a implementation about Async Await Excercise, this subject was discussed in class with professor Norberto, he left homework to do, **Do a implementation with DispatchQueue**. After time this is my implementation

**Project Screen**

![1](ASSETS/1.png)

**View Controller Code**

```swift
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


```

**Cell Phone Screen**

![2](ASSETS/2.png)

## Where is the original Code?

The original code is property to *Andy Ibañez*, you can found in this links:

- [Web Site](https://www.andyibanez.com)
- [Github](https://github.com/AndyIbanez)
- [Theme in Web Site about Async Await](https://www.andyibanez.com/posts/understanding-actors-in-the-new-concurrency-model-in-swift/)

<img src="ASSETS/3.png" alt="3" style="zoom:80%;" />

## Who I am?

My name is:  Hernán Galileo Cabrera Garibaldi, and you can find me in this Social networks:

- Email: galigaribaldi0@gmail.com
- Github: https://github.com/galigaribaldi
- Linkedin: www.linkedin.com/in/galileogaribaldi
