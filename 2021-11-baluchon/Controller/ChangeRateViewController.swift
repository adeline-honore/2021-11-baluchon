//
//  ChangeRateViewController.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import UIKit

class ChangeRateViewController: UIViewController {
    
    // MARK: - Properties
    private var changeRateView: ChangeRateView!
    private var changeRateService = ChangeRateViewService()
    
    // MARK: - Override
    override func loadView() {
        super.loadView()
        changeRateView = view as? ChangeRateView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapChangeCurrencyButton() {
        convertAmount()
    }
    
    // MARK: - Methods
    private func convertAmount() {
        
        changeRateService.getData { result in
            
            switch result { 
            case .success(let fixer):
                self.update(fixer: fixer)
            case .failure:
                self.errorMessage(element: .network)
            }
        }
    }
    
    private func update(fixer: Fixer) {
        let changeRate = fixer.rates["USD"] ?? 0.0
        
        guard let amountToConvert = Double(changeRateView.amountToConvert.text ?? "") else {
            errorMessage(element: .noAmount)
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.changeRateView.convertedAmount.text = String(format:"%.2f", (amountToConvert * changeRate))
        }
    }
}
