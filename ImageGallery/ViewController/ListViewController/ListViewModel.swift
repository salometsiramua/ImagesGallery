//
//  ListViewModel.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation
import RxSwift

protocol ListViewModel {
    var imageGallery: [Int: [ImageCollectionViewCellViewModel]] { get }
    var listUpdatedListener: ListUpdatedListener? { get set }
    func fetchList()
    func suspendAllOperations()
    func resumeAllOperations()
    func images(for cells: [IndexPath]?)
    func key(for index: Int) -> Int
}

protocol ListUpdatedListener {
    func reloadCollectionView(rows: [IndexPath])
    func showAlert(with error: Error)
    func downloadDidFinish()
}

class ListViewModelService: ListViewModel {
    
    var listUpdatedListener: ListUpdatedListener?
    
    private let imagesListFetcher: ImagesListFetcher
    
    private(set) var imageGallery: [Int: [ImageCollectionViewCellViewModel]] = [:]
    
    private let pendingOperations = PendingOperations()
    
    init(imagesListFetcher: ImagesListFetcher = ImagesListFetcherService()) {
        self.imagesListFetcher = imagesListFetcher
    }
    
    func fetchList() {
        imagesListFetcher.fetch { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.map(response: response)
                self?.listUpdatedListener?.downloadDidFinish()
            case .failure(let error):
                self?.listUpdatedListener?.showAlert(with: error)
            }
        }
    }
    
    func map(response: ImageContentListResponse) {
        response.imageContentList.forEach { (imageContent) in
            let model = ImageCollectionViewCellViewModel(imageContent: imageContent)
            if imageGallery[imageContent.albumId] == nil {
                imageGallery[imageContent.albumId] = [model]
            } else {
                imageGallery[imageContent.albumId]?.append(model)
            }
        }
    }
    
    func images(for cells: [IndexPath]?) {
        
        guard let cells = cells else { return }
        
        let allPendingOperations = Set(pendingOperations.downloadsInProgress.keys)
        
        var toBeCancelled = allPendingOperations
        let visiblePaths = Set(cells)
        toBeCancelled.subtract(visiblePaths)
        
        var toBeStarted = visiblePaths
        toBeStarted.subtract(allPendingOperations)
        
        toBeCancelled.forEach { (indexPath) in
            if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
                pendingDownload.cancel()
            }
            pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
        }
        
        toBeStarted.filter {
            
            guard let values = imageGallery[key(for: $0.section)] else {
                return false
            }
            
            return values[$0.row].image.state == ImageState.new }.forEach { (indexPath) in
                
                guard let values = imageGallery[key(for: indexPath.section)] else {
                    return
                }
                
                let image = values[indexPath.row].image
                startDownload(for: image, at: indexPath)
            }
    }
    
    func suspendAllOperations() {
        pendingOperations.downloadQueue.isSuspended = true
    }
    
    func resumeAllOperations() {
        pendingOperations.downloadQueue.isSuspended = false
    }
    
    private func startDownload(for photoRecord: Image, at indexPath: IndexPath) {
        
        guard pendingOperations.downloadsInProgress[indexPath] == nil, let values = imageGallery[key(for: indexPath.section)], values[indexPath.row].image.state == ImageState.new else {
            return
        }
        
        let downloader = ImageDownloader(photoRecord, indexPath: indexPath)
        
        downloader.completionBlock = { [weak self] in
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                guard let key = self?.key(for: indexPath.section), var values = self?.imageGallery[key] else {
                    return
                }
                values[indexPath.row].image = downloader.image
                
                self?.pendingOperations.downloadsInProgress.removeValue(forKey: downloader.indexPath)
                self?.listUpdatedListener?.reloadCollectionView(rows: [downloader.indexPath])
            }
            
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    func key(for index: Int) -> Int {
        return Array(imageGallery.keys)[index]
    }
}

