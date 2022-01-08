//
//  BottomSheetViewController.swift
//  Besteats
//
//  Created by BH on 2022/01/08.
//

import UIKit

class BottomSheetViewController: UIViewController {

    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    var defaultHeight: CGFloat = 250
    var bottomSheetPanMinTopConstant: CGFloat = 30
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
                dimmedView.addGestureRecognizer(dimmedTap)
                dimmedView.isUserInteractionEnabled = true
        
        let bottomSheetViewPan = UIPanGestureRecognizer(target: self, action: #selector(bottomSheetViewPanned(_:)))
        
        // iOS 터치할때 딜레이를 없애기 위함 (기본적으로 딜레이가 발생함)
//        bottomSheetViewPan.delaysTouchesBegan = false
//        bottomSheetViewPan.delaysTouchesEnded = false
        bottomSheetView.addGestureRecognizer(bottomSheetViewPan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            showBottomSheet()
        }
    
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        
        dimmedView.alpha = 0.0
        
        setupLayout()
    }
    
    private func setupLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
                let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
                bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
                NSLayoutConstraint.activate([
                    bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    bottomSheetViewTopConstraint
                ])
    }
    
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                    
            self.dimmedView.alpha = 0.7
                    
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideBottomSheetAndGoBack() {
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                self.dimmedView.alpha = 0.0
                self.view.layoutIfNeeded()
            } completion: { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: false, completion: nil)
                }
            }
            
        }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    @objc private func bottomSheetViewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.bottomSheetView)
        
        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
        case .ended:
            print("드래그가 끝남")
        default:
            break
        }
        
        print("유저가 위아래로 \(translation.y)만큼 드래그했습니다.")
    }
}
