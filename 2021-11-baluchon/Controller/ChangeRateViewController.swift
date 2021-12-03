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
        let changeRate = Double(fixer.rates["USD"] ?? 0.0)
        
        guard let amountToConvert = Double(changeRateView.amountToConvert.text ?? "") else {
            errorMessage(element: .noAmount)
            return
        }
        
        let result = NSDecimalNumber.init(string: String(amountToConvert * changeRate))

        let behaviour = NSDecimalNumberHandler(roundingMode: .bankers,
        scale: 2, raiseOnExactness: false,
        raiseOnOverflow: false, raiseOnUnderflow:
        false, raiseOnDivideByZero: false)

        let numRounded = result.rounding(accordingToBehavior: behaviour)
        
        // update label
        DispatchQueue.main.async {
            self.changeRateView.convertedAmount.text = numRounded.stringValue
        }
    }
}
