import Foundation
import SwiftyGPIO

struct SensorsRepository: SensorsRepositoryProtocol {
    func getSensor(sensorIndex: Int) -> Float {
        // Set the file path
        let path = "/sys/bus/iio/devices/iio:device0/in_voltage\(sensorIndex)-voltage1_raw"

        do {
            let contents = try String(contentsOfFile: path, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
            return Float(contents) ?? -1
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        return -1
    }
    
    func getSensorsStatus() -> [Terrace] {
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi4)
        
        let valueToReturn = gpios.compactMap { (key: GPIOName, value: GPIO) -> PinValue? in
            guard let gpioValue = GPIOValue(rawValue: value.value),
                  let pin = Pin(rawValue: key.rawValue) else { return nil }
            return PinValue(pin: pin, value: gpioValue)
        }
        let sensorsSorted = valueToReturn.sorted { left, right in
            left.pin.rawValue > right.pin.rawValue
        }
        
//        let first = Array(sensorsSorted.dropFirst(8))
//        let firstTerrace = Terrace(name: "Terrace 1", sensors: first.map { SensorDTO(sensor: $0.pin.rawValue, value: Float($0.value.rawValue)) })
//        let second = Array(sensorsSorted.dropFirst(8))
//        let secondTerrace = Terrace(name: "Terrace 1", sensors: second.map { SensorDTO(name: $0.pin.rawValue, value: Float($0.value.rawValue)) })
//        let third = Array(sensorsSorted.dropFirst(8))
//        let thirdTerrace = Terrace(name: "Terrace 1", sensors: third.map { SensorDTO(name: $0.pin.rawValue, value: Float($0.value.rawValue)) })
//        return [firstTerrace, secondTerrace, thirdTerrace]
        return []
    }
}
