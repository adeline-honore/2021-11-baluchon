//
//  TranslateService.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 15/01/2022.
//

import Foundation

class TranslateService: TranslateServiceProtocol {
    
    var network: NetworkProtocol = Network()
    
    func getData(text: String, completionHandler: @escaping (Result<TranslateStructure, Error>) -> ()) {
        
        network.callNetwork(router: TranslateRouter.getTranslatedText(textToSend: text)) { result in
            
            switch result {
            case .success(let data):
                let translated = self.getResponseTranslated(data: data)
                completionHandler(.success(translated))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func getResponseTranslated(data: Data) -> TranslateStructure {
        var response: TranslateStructure
        
        response = try! JSONDecoder().decode(TranslateStructure.self, from: data)
        return response
    }
}
