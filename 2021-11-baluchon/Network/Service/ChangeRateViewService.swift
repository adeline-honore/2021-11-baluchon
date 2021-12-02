//
//  ChangeRateViewService.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

class ChangeRateViewService {
    
    var network: NetworkProtocol = Network()
    
    func getData(completionHandler: @escaping (Result<Fixer, Error>) -> ()) {
        
        return network.callNetwork(router: ChangeRateRouter(), completionHandler: { result in
            DispatchQueue.main.async {
            switch result {
            case .success(let data):
                let fixer = self.transformToFixer(data: data)
                completionHandler(.success(fixer))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            }
        })
    }
    
    private func transformToFixer(data: Data) -> Fixer {
        var responseFixer: Fixer
        let data = data
        responseFixer = try! JSONDecoder().decode(Fixer.self, from: data)
        return responseFixer
    }
}
