//
//  ListViewController.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit
class ListViewController: UIViewController {
    
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    lazy var viewModel: ListViewModel = ListViewModelService(listUpdatedListener: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startIndicatingActivity()
        setupCollectionView()
        viewModel.fetchList()
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    private func setupCollectionView() {
        
        collectionView.register(UINib(nibName: ImageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: Constants.Spacing.margin.value, left: Constants.Spacing.margin.value, bottom: Constants.Spacing.margin.value, right: Constants.Spacing.margin.value)
        
        collectionView.addSubview(refreshControl)
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.pin(to: view, directions: [.centerX])
    }
}

//MARK: - Refresh control
extension ListViewController {
    @objc private func refreshData(_ sender: Any) {
        viewModel.resetAll()
        viewModel.fetchList()
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate { }

//MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.imageGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let key = viewModel.key(for: section) else {
            return 0
        }
        return viewModel.imageGallery[key]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let key = viewModel.key(for: indexPath.section), let values = viewModel.imageGallery[key] else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: values[indexPath.row])
        viewModel.images(for: collectionView.indexPathsForVisibleItems)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.suspendAllOperations()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            viewModel.images(for: collectionView.indexPathsForVisibleItems)
            viewModel.resumeAllOperations()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.images(for: collectionView.indexPathsForVisibleItems)
        viewModel.resumeAllOperations()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: Constants.Size.sectionHeader.value, left: 0, bottom: 0, right: 0)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.Size.cell.value, height: Constants.Size.cell.value)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.Spacing.padding.value
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.Spacing.padding.value
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let key = viewModel.key(for: indexPath.section), let values = viewModel.imageGallery[key] else {
            return
        }
        
        let model = values[indexPath.row]
       
        guard let viewController = makeDetailsViewController(from: model) else {
            return
        }
        
        present(viewController, animated: true, completion: nil)
    }
    
    func makeDetailsViewController(from model: ImageCollectionViewCellViewModel) -> DetailsViewController? {
        guard let viewController = Storyboard.details.value.instantiateInitialViewController() as? DetailsViewController else {
            return nil
        }
        
        viewController.viewModel = DetailsViewModelService(from: model)
        
        return viewController
    }
}

extension ListViewController: ListUpdatedListener {
    
    func reloadCollectionView(rows: [IndexPath]) {
        DispatchQueue.main.async {
            guard !rows.isEmpty else {
                self.collectionView.reloadData()
                return
            }
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: rows)
            guard !indexPathsToReload.isEmpty else {
                self.collectionView.reloadData()
                return
            }
            self.collectionView.reloadItems(at: indexPathsToReload)
        }
    }
    
    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    func downloadDidFinish() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.stopIndicatingActivity()
            self.collectionView.reloadData()
            self.viewModel.images(for: self.collectionView.indexPathsForVisibleItems)
        }
    }
}
