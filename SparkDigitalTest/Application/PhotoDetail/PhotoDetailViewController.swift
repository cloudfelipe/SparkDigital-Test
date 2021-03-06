//
//  PhotoDetailViewController.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 9/08/21.
//

import UIKit
import RxSwift

final class PhotoDetailViewController: UIViewController {
    
    private var photoView = PhotoDetailView()
    private let viewModel: PhotoDetailViewModelType
    
    init(viewModel: PhotoDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = photoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Detail"
        viewModel.viewDidLoad()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.photoImagePath
            .map { UIImage(contentsOfFile: $0) }
            .observe(on: MainScheduler.instance)
            .bind(to: photoView.imageView.rx.image)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.dataRequestState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.requestState($0) })
            .disposed(by: viewModel.disposeBag)
    }
    
    private func requestState(_ requestState: DataRequestState) {
        DispatchQueue.main.async {
            switch requestState {
            case .downloading:
                self.photoView.loading()
            default:
                self.photoView.stopLoading()
            }
        }
    }
}
