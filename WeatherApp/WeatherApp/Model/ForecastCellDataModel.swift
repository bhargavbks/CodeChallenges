import Foundation

struct ForecastCellDataModel {
    let date: String
    let currentTemp: String
    let maxTemp: String
    let minTemp: String
    let weatherIcon: String
    let feelsLike: String
    let humidity: String
    
    init(with data: ForeCastData) {
        date = data.date
        currentTemp = data.temperature.temp.formatToTemperature()
        maxTemp = data.temperature.max.formatToTemperature()
        minTemp = data.temperature.min.formatToTemperature()
        feelsLike = data.temperature.feelsLike.formatToTemperature()
        humidity = "\(String(data.temperature.humidity))%"
        weatherIcon = data.weather[0].icon
    }
}
