//
//  DetailsViewController.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var detailedImageView: UIImageView!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startIndicatingActivity()
        viewModel?.fetchDetails(completion: { [weak self] (result) in
            self?.stopIndicatingActivity()
            switch result {
            case .success(let image):
                self?.detailedImageView.image = image
            case .failure(let error):
                self?.showAlert(with: error)
            }
        })
    }
}

