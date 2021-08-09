//
//  PhotoListViewController.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit
import RxSwift

final class PhotoListViewController: UIViewController {
    
    private var photoView: PhotoListView = PhotoListView()
    
    private let viewModel: PhotoListViewModelType
    private var collectionAdapter: CollectionViewDataAdapter!
    private let disposeBag = DisposeBag()
    
    init(viewModel: PhotoListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = photoView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionAdapter = CollectionViewDataAdapter(collectionView: photoView.collectionView)
        setupBinding()
        viewModel.viewDidLoad()
    }
    
    private func setupBinding() {
        viewModel.photos
            .observe(on: MainScheduler.instance)
            .subscribe { [weak collectionAdapter] photosList in
                collectionAdapter?.setItems(photosList)
            }
            .disposed(by: disposeBag)
        
        viewModel.dataRequestState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.requestState($0) })
            .disposed(by: disposeBag)
        
        photoView.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak viewModel] in viewModel?.photoSelected(at: $0.row) })
            .disposed(by: disposeBag)
    }
    
    private func requestState(_ requestState: DataRequestState) {
        DispatchQueue.main.async {
            switch requestState {
            case .loading:
                self.collectionAdapter.loading()
            default:
                self.collectionAdapter.hideLoading()
            }
        }
    }
}

