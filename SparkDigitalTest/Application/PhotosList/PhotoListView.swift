//
//  PhotoListView.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit
import SwifterSwift

final class PhotoListView: UIView {
    
    let refreshControl = UIRefreshControl()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellWithClass: PhotoListCollectionCell.self)
        collectionView.register(cellWithClass: SkeletonCell.self)
        collectionView.backgroundColor = .white
        collectionView.isSkeletonable = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
