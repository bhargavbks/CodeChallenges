import Foundation

extension Double {
    
    func formatToTemperature(with unit: UnitTemperature = .celsius) -> String {
        let measurement = Measurement(value: self, unit: unit)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        return measurementFormatter.string(from: measurement)
    }
}
