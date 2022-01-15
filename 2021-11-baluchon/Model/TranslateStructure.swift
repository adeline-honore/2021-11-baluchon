//
//  TranslateStructure.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 15/01/2022.
//

import Foundation

struct TranslateStructure: Codable {
    
    struct DataStructure: Codable {
        struct Translations: Codable {
            let translatedText: String
        }
        let translations: [Translations]
    }
    let data : DataStructure
}
