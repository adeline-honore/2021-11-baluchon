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
        
        UserDefaults.standard.value(forKey: "timestampData")
        UserDefaults.standard.value(forKey: "rateData")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapChangeCurrencyButton() {
        convertAmount()
    }
    
    // MARK: - Methods
    private func convertAmount() {
       
        let timestampNow = Int(Date().timeIntervalSince1970)
        
        guard let amountToConvert = Double(changeRateView.amountToConvert.text ?? "") else {
            errorMessage(element: .noAmount)
            return
        }
        
        if timestampNow == UserDefaults.standard.value(forKey: "timestampData") as! Int {
            changeRateView.convertedAmount.text = String(format:"%.2f", (amountToConvert * (UserDefaults.standard.value(forKey: "rateData") as! Double))) + " $"
        } else {
            changeRateService.getData { result in
                
                switch result {
                case .success(let fixer):
                    self.update(fixer: fixer)
                case .failure:
                    self.errorMessage(element: .network)
                }
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
            self?.changeRateView.convertedAmount.text = String(format:"%.2f", (amountToConvert * changeRate)) + " $"
        }
        
        setUserDefaults(timestampData: fixer.timestamp, rateData: changeRate)
    }
    
    private func setUserDefaults(timestampData: Int, rateData: Double) {
        UserDefaults.standard.set(timestampData, forKey: "timestampData")
        UserDefaults.standard.set(rateData, forKey: "rateData")
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
