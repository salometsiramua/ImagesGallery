//
//  ImageDownloader.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 30
        return queue
    }()
}

enum ImageState {
    case new
    case downloaded
    case failed
}

class Image {
    let url: String?
    var state = ImageState.new
    var image: UIImage?
    
    init(url: String?, image: UIImage? = nil) {
        self.url = url
        self.image = image
    }
}

class ImageDownloader: Operation {
    
    let image: Image
    let indexPath: IndexPath
    
    init(_ image: Image, indexPath: IndexPath) {
        self.image = image
        self.indexPath = indexPath
    }
    
    override func main() {
        guard !isCancelled else {
            return
        }
        
        guard let url = image.url, let imageUrl = URL(string: url), let imageData = try? Data(contentsOf: imageUrl) else {
            image.state = .failed
            return
        }
        
        image.image = imageData.isEmpty ? nil : UIImage(data: imageData)
        image.state = image.image == nil ? .failed : .downloaded
    }
}
