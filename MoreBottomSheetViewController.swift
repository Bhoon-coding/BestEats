//
//  MoreBottomSheetViewController.swift
//  Besteats
//
//  Created by BH on 2022/01/04.
//

import UIKit

class MoreBottomSheetViewController: UIViewController {
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var bottomSheetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        bottomSheetView.layer.cornerRadius = 10
        bottomSheetView.layer.borderWidth = 1
        
        }
    
    @IBAction func tapBackground(_ sender: Any) {
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        
        dismiss(animated: false, completion: nil)
    }
}
    
    
    
