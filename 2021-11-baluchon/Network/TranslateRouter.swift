//
//  TranslateRouter.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 15/01/2022.
//

import Foundation

enum TranslateRouter: RouterProtocol {
    
    var baseURL: String {
        "https://translation.googleapis.com/language/translate/v2?"
    }
    
case getTranslatedText(textToSend: String)
    
    func buildParams() -> URL? {
        switch self {
        case .getTranslatedText(let textToSend):
            print("ok")
            var translateComponents = URLComponents(string: baseURL)
            
            translateComponents?.queryItems = [
                URLQueryItem(name: "source", value: "en"),
                URLQueryItem(name: "target", value: "fr"),
                URLQueryItem(name: "format", value: "text"),
                URLQueryItem(name: "q", value: textToSend),
                URLQueryItem(name: "key", value: "AIzaSyCK3a8vm3Zu2fBDBJX_rHhpzpXwR9Vr-dw")
            ]
            return URL(string: translateComponents?.string ?? "")
        }
    }
    
    func asUrlRequest() -> URLRequest? {
        guard let url = buildParams() else {
            return nil
        }
        return URLRequest(url: url)
    }
}
