import Foundation

public struct ForeCast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForeCastData]
    let city: City
}

struct ForeCastData: Codable {
    let dt: Int
    let temperature: Temperature
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let rain: Rain?
    let sys: Sys
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case dt
        case temperature = "main"
        case weather, clouds, wind, rain, sys
        case date = "dt_txt"
    }
}

struct Temperature: Codable {
    let temp, feelsLike, min, max: Double
    let pressure, seaLevel, groundLevel, humidity: Int
    let tempKf: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case min = "temp_min"
        case max = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Rain: Codable {
    let rain: Double?
    
    private enum CodingKeys: String, CodingKey {
        case rain = "3h"
    }
}

struct Sys: Codable {
    let pod: String
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}
