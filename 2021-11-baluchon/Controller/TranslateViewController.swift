//
//  TranslateViewController.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 15/01/2022.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // MARK: - Properties
    private var translateView: TranslateView!
    
    
    
    // MARK: - Override
    override func loadView() {
        super.loadView()
        translateView = view as? TranslateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBAction
    
    @IBAction func didTapTranslateButton() {
        translateText()
    }
    
    
    
    
    // MARK: - Methods

    private func translateText() {
        
    }
    

}
