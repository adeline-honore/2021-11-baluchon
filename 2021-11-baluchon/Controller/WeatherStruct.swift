//
//  Weather.swift
//  2021-11-baluchon
//
//  Created by HONORE Adeline on 23/11/2021.
//

import Foundation

struct WeatherStruct: Codable {
    openweathermap
    
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    
    let coord: Coord
    
    // How to make it Codable?
    //let weather: [Any]
    //let weather: [Key: Value]
    
    /*
    struct Weather: Codable {
        [String: Int, String: String, String: String, String: String]
    }*/
    
    struct WeatherArray: Codable {
            let id: Int
        let main: String
        let description: String
        let icon: String
        }
    
    let weatherArray: [WeatherArray]
     
    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }
    
    let main: Main
    
    struct Wind: Codable {
        let speed: Double
    }
    
    let wind: Wind
    
    struct Clouds: Codable {
        let all: Double
    }
    
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
}
