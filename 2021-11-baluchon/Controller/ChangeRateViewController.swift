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
    private var changeRateService = ChangeRateService(network: Network())
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    // MARK: - Override
    override func loadView() {
        super.loadView()
        changeRateView = view as? ChangeRateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.value(forKey: "timestampData")
        UserDefaults.standard.value(forKey: "rateData")
        
        // keyboard height layout constraint
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        // display and dismiss keyboard
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
            errorMessage(element: .empty)
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
        let currencyIndex = changeRateView.currencySegmentedControl.selectedSegmentIndex
        let initialCurrency: FixerCurrency = (currencyIndex == 0) ? .euro : .usd
        
        guard let amountToConvert = Double(changeRateView.amountToConvert.text ?? "") else {
            errorMessage(element: .empty)
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.changeRateView.convertedAmount.text = self?.calculateConvertAmount(amountToConvert: amountToConvert, changeRate: changeRate, initialCurrency: initialCurrency)
        }
        
        setUserDefaults(timestampData: fixer.timestamp, rateData: changeRate)
    }
    
    private func calculateConvertAmount(amountToConvert: Double, changeRate: Double, initialCurrency: FixerCurrency) -> String{
        if initialCurrency == .usd {
            return String(format:"%.2f", (amountToConvert / changeRate)) + " €"
        } else {
            return String(format:"%.2f", (amountToConvert * changeRate)) + " $"
        }
    }
    
    private func setUserDefaults(timestampData: Int, rateData: Double) {
        UserDefaults.standard.set(timestampData, forKey: "timestampData")
        UserDefaults.standard.set(rateData, forKey: "rateData")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.keyboardHeightLayoutConstraint?.constant = 16.0
        } else {
            self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 16.0
        }
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
