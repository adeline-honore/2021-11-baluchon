//
//  ReferenceButton.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/01/2022.
//

import UIKit

class ReferenceButton: UIButton {
    
    let specialUIColor = UIColor(red: 197.0/255.0, green: 67.0/255.0, blue: 11.0/255.0, alpha: 1)
    let specialUCGColor = CGColor(red: 197.0/255.0, green: 67.0/255.0, blue: 11.0/255.0, alpha: 1)
   
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = specialUCGColor
        layer.cornerRadius = frame.height / 2
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        titleLabel?.textColor = specialUIColor
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
