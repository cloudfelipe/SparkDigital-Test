//
//  CollectionViewAdapter.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit
import SkeletonView

final class CollectionViewDataAdapter: NSObject, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
        
    private(set) var items = [PhotoListViewData]()
    
    private(set) weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }
    
    func setItems(_ items: [PhotoListViewData]) {
        self.items = items
        reload()
    }
    
    func loading() {
        DispatchQueue.main.async {
            self.collectionView?.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.collectionView?.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
    
    func reload() {
        UIView.transition(with: self.collectionView!,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.collectionView!.reloadData()
        })
    }
    
    // MARK: - SkeletonCollectionViewDataSource
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        String(describing: SkeletonCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: PhotoListCollectionCell.self, for: indexPath)
        cell.setup(with: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 20, height: collectionView.frame.height / 5 - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}
