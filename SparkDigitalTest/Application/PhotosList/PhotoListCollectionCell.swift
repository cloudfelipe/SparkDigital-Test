//
//  PhotoListCollectionCell.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 8/08/21.
//

import UIKit
import SkeletonView
import RxSwift

final class PhotoListCollectionCell: UICollectionViewCell {
    lazy var containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 3.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var fileTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.setContentHuggingPriority(.required, for: .vertical)
        title.setContentCompressionResistancePriority(.required, for: .vertical)
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var fileIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = .scaleAspectFill
        imageView.isOpaque = false
        imageView.image = #imageLiteral(resourceName: "template")
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let iconContainer = UIView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        
        fileIconImageView.addToParent(iconContainer)
        activityIndicator.addToParent(iconContainer)
        containerStackView.addArrangedSubview(iconContainer)
        containerStackView.addArrangedSubview(fileTitleLabel)
        containerStackView.addToParent(contentView)
    
        self.isSkeletonable = true
    }
    
    private var disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fileTitleLabel.text = nil
        fileIconImageView.image = #imageLiteral(resourceName: "template")
        disposeBag = DisposeBag()
    }
    
    func setup(with data: PhotoListViewData) {
        self.fileTitleLabel.text = data.name
        
        activityIndicator.startAnimating()
        data.thumbnail
            .map { UIImage(contentsOfFile: $0) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] image in
                self?.fileIconImageView.image = image
                self?.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}

final class SkeletonCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    public func addToParent(_ parent: UIView) {
        parent.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }
}
