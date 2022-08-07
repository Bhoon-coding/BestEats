//
//  FoodTypeCollectionViewCell.swift
//  Besteats
//
//  Created by BH on 2022/06/22.
//

import UIKit

protocol CellActionDelegate: AnyObject {
    
    func starButtonTapped(cell: RecommendCollectionViewCell)
    
}

class RecommendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Type Properties
    
    static let identifier: String = "RecommendCollectionViewCell"
    
    // MARK: - Properties
    
    weak var cellDelegate: CellActionDelegate?
    
    // MARK: - UIProperties
    
    lazy var unsplashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Style.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.alpha = Style.alpha
        view.backgroundColor = .black
        view.layer.cornerRadius = Style.cornerRadius
        return view
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(Style.starImage, for: .normal)
        button.setImage(Style.selectedStarImage, for: .selected)
        button.tintColor = .yellow
        return button
    }()
    
    private lazy var memoLabel: UILabel = {
        let label = UILabel()
        label.text = "0번째 사진"
        label.textColor = .white
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
        self.starButton.addTarget(
            self,
            action: #selector(starTapped),
            for: .touchUpInside
        )
    }
    
    @available(*, unavailable, message: "This initializer is not available.")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
        
    }
    
    @objc func starTapped() {
        cellDelegate?.starButtonTapped(cell: self)
    }
    
}

// MARK: - Layout extension

extension RecommendCollectionViewCell {
    
    func setupImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.unsplashImageView.image = image
        }
    }
    
    func setupCell() {
        memoLabel.text = "테스트"
        unsplashImageView.image = UIImage(systemName: "car.fill")
    }
    
    private func setupView() {
        [unsplashImageView,
         topView,
         starButton,
         memoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        setupConstraintsOfUnsplashImageView()
        setupConstraintsOfTopView()
        setupConstraintsOfStarButton()
        setupConstraintsOfMemoLabel()
    }
    
    private func setupConstraintsOfUnsplashImageView() {
        NSLayoutConstraint.activate([
            unsplashImageView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor
            ),
            unsplashImageView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor
            ),
            unsplashImageView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor
            ),
            unsplashImageView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
    private func setupConstraintsOfTopView() {
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(
                equalTo: unsplashImageView.safeAreaLayoutGuide.leadingAnchor
            ),
            topView.topAnchor.constraint(
                equalTo: unsplashImageView.safeAreaLayoutGuide.topAnchor
            ),
            topView.trailingAnchor.constraint(
                equalTo: unsplashImageView.safeAreaLayoutGuide.trailingAnchor
            ),
            topView.heightAnchor.constraint(equalToConstant: Style.alphaViewHeight)
        ])
    }
    
    private func setupConstraintsOfStarButton() {
        NSLayoutConstraint.activate([
            starButton.centerYAnchor.constraint(
                equalTo: topView.centerYAnchor
            ),
            starButton.leadingAnchor.constraint(
                equalTo: topView.leadingAnchor,
                constant: Style.leadingPadding
            )
        ])
    }
    
    private func setupConstraintsOfMemoLabel() {
        NSLayoutConstraint.activate([
            memoLabel.centerYAnchor.constraint(
                equalTo: topView.centerYAnchor
            ),
            memoLabel.trailingAnchor.constraint(
                equalTo: topView.trailingAnchor,
                constant: Style.trailingPadding
            )
        ])
    }
    
}

// MARK: - NameSpaces

extension RecommendCollectionViewCell {
    
    private enum Style {
        static let padding: CGFloat = 16
        static let leadingPadding: CGFloat = 8
        static let trailingPadding: CGFloat = -8
        static let cornerRadius: CGFloat = 10
        static let alpha: CGFloat = 0.7
        static let alphaViewHeight: CGFloat = 40
        
        static let starImage = UIImage(systemName: "star")
        static let selectedStarImage = UIImage(systemName: "star.fill")
    }
    
    private enum Text {
        static let numberOfImage: String = "번째 사진"
    }
    
}
