//
//  PhotoListViewController.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit

final class PhotoListViewController: UIViewController {
    
    private let viewModel: PhotoListViewModelType
    
    init(viewModel: PhotoListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.viewDidLoad()
    }
}

