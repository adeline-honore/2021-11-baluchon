//
//  CustomWeatherView.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 08/12/2021.
//

import UIKit

class CustomWeatherView: UIView {
   
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var image: UIImageView!
    
 
    func configure(value1: String, value2: String, value3: String, value4: String) {
        label1.text = value1
        label2.text = value2
        label3.text = value3
        image.image = UIImage(named: value4)
        
    }
}
