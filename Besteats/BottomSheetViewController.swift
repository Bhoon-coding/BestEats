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
    
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let bottomSheetTableView: UITableView = {
        let tableView = UITableView()
        let items: [String] = ["수정", "삭제"]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BottomSheetTableViewCell")
        return tableView
    }()
    
//    private let bottomSheetStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//
//        return stackView
//    }()
//
//        private let modifyView: UIView = {
//            let view = UIView()
//            return view
//        }()
//
//        private let deleteView: UIView = {
//            let view = UIView()
//            return view
//
//        }()
//
//    private let modifyButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("수정", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//
//        return button
//    }()
//
//    private let deleteButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("삭제", for: .normal)
//        button.setTitleColor(.red, for: .normal)
//        return button
//    }()
    
    
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    // bottomSheet 기본 높이
    //    var defaultHeight: CGFloat = 250
    var defaultHeight = UIScreen.main.bounds.size.height / 4
    //    var bottomSheetPanMinTopConstant: CGFloat = 550
    var bottomSheetPanMinTopConstant = UIScreen.main.bounds.size.height * 0.7
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bottomSheetTableView.dataSource = self
//        bottomSheetTableView.delegate = self
        
        configureUI()
        
        let bottomSheetViewSnapPan = UIPanGestureRecognizer(target: self, action: #selector(bottomSheetViewSnapPanned(_:)))
        
        // iOS 터치할때 딜레이를 없애기 위함 (기본적으로 딜레이가 발생함)
        bottomSheetViewSnapPan.delaysTouchesBegan = false
        bottomSheetViewSnapPan.delaysTouchesEnded = false
        bottomSheetView.addGestureRecognizer(bottomSheetViewSnapPan)
//        bottomSheetStackView.addGestureRecognizer(bottomSheetViewSnapPan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }
    
    // tableViewCell 추가 참고 (https://shark-sea.kr/entry/iOS-TableView-Code%EB%A1%9C-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)
    
    private func configureUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        view.addSubview(dragIndicatorView)
        view.addSubview(bottomSheetTableView)
//        view.addSubview(bottomSheetStackView)
        
        
        dimmedView.alpha = 0.0
        configureLayout()
//        setStackView()
    }
    
//    private func setStackView() {
//        bottomSheetStackView.addArrangedSubview(modifyView)
//        bottomSheetStackView.addArrangedSubview(deleteView)
//        modifyView.addSubview(modifyButton)
//        deleteView.addSubview(deleteButton)
//
//    }
    
    private func configureLayout() {
        
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 35),
            bottomSheetViewTopConstraint
        ])
        
        dragIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 8),
            dragIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dragIndicatorView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 20)
        ])
        
//        bottomSheetStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            bottomSheetStackView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 30),
//            bottomSheetStackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
//            bottomSheetStackView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor),
//            bottomSheetStackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor)
//        ])
        
//        modifyButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            modifyButton.centerXAnchor.constraint(equalTo: modifyView.centerXAnchor),
//            modifyButton.centerYAnchor.constraint(equalTo: modifyView.centerYAnchor)
//        ])
//
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            deleteButton.centerXAnchor.constraint(equalTo: deleteView.centerXAnchor),
//            deleteButton.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor)
//        ])
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
    
    @objc private func bottomSheetViewSnapPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.bottomSheetView)
        
        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
        case .ended:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                hideBottomSheetAndGoBack()
            }
        default:
            break
        }
        
    }
}

extension BottomSheetViewController: UITableViewDelegate {
    
}

//extension BottomSheetViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell
//    }
//
//
//}

