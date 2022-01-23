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
    private var translateService: TranslateServiceProtocol = TranslateService(network: Network())
    
    
    
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
        
        guard let text = translateView.textToTranslate.text else {
            return errorMessage(element: .empty)
        }
        
        translateService.getData(text: text) { result in
            
            switch result {
            case .success(let response):
                self.getTranslation(response: response)
            case .failure:
                self.errorMessage(element: .network)
            }
        }
    }
    
    private func getTranslation(response: TranslateStructure) {
        
        DispatchQueue.main.async { [weak self] in
            self?.translateView.translatedText.text = response.data.translations.first?.translatedText
        }
    }
}
