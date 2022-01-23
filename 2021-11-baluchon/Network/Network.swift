//
//  Network.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation


class Network: NetworkProtocol {
    func callNetwork(router: RouterProtocol, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        guard let urlRequest = router.asUrlRequest() else {
            completionHandler(.failure(ErrorType.network))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            completionHandler(.success(data))
        }.resume()
    }
}
