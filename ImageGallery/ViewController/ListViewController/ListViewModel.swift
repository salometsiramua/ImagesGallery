//
//  ListViewModel.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import Foundation

protocol ListViewModel {
    var imageGallery: [Int: [ImageCollectionViewCellViewModel]] { get }
    func fetchList()
    func suspendAllOperations()
    func resumeAllOperations()
    func loadImages(for cells: [IndexPath]?)
    func key(for index: Int) -> Int?
    func resetAll()
}

protocol ListUpdatedListener: class {
    func reloadCollectionView(rows: [IndexPath])
    func showAlert(with error: Error)
    func downloadDidFinish()
}

class ListViewModelService: ListViewModel {
    
    private weak var listUpdatedListener: ListUpdatedListener?
    
    private let imagesListFetcher: ImagesListFetcher
    
    private(set) var imageGallery: [Int: [ImageCollectionViewCellViewModel]] = [:]
    
    private let pendingOperations = PendingOperations()
    
    init(imagesListFetcher: ImagesListFetcher = ImagesListFetcherService(), listUpdatedListener: ListUpdatedListener) {
        self.imagesListFetcher = imagesListFetcher
        self.listUpdatedListener = listUpdatedListener
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
    
    func resetAll() {
        suspendAllOperations()
        pendingOperations.downloadsInProgress.forEach { (_, operation) in
            operation.cancel()
        }
        pendingOperations.downloadsInProgress.removeAll()
        imageGallery.removeAll()
    }
    
    private func map(response: ImageContentListResponse) {
        response.imageContentList.forEach { (imageContent) in
            let model = ImageCollectionViewCellViewModel(imageContent: imageContent)
            if imageGallery[imageContent.albumId] == nil {
                imageGallery[imageContent.albumId] = [model]
            } else {
                imageGallery[imageContent.albumId]?.append(model)
            }
        }
    }
    
    func loadImages(for cells: [IndexPath]?) {
        
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
            
            guard let key = key(for: $0.section), let values = imageGallery[key] else {
                return false
            }
            
            return values[$0.row].image.state == ImageState.new }.forEach { (indexPath) in
                
                guard let key = key(for: indexPath.section), let values = imageGallery[key] else {
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
        
        guard pendingOperations.downloadsInProgress[indexPath] == nil, let key = key(for: indexPath.section), let values = imageGallery[key], values[indexPath.row].image.state == ImageState.new else {
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
                
                guard let indexPath = downloader.indexPath else {
                    return
                }
                self?.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self?.listUpdatedListener?.reloadCollectionView(rows: [indexPath])
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    func key(for index: Int) -> Int? {
        guard imageGallery.keys.count > index else {
            return nil
        }
        return Array(imageGallery.keys)[index]
    }
}


