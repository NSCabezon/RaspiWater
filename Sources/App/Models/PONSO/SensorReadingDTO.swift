import Vapor

struct SensorReadingDTO: Content {
    let sensorId: UUID?
    let value: Float
    let timestamp: Date
    
    init(sensorId: UUID? = nil, value: Float, timestamp: Date) {
        self.sensorId = sensorId
        self.value = value
        self.timestamp = timestamp
    }
}

extension SensorReading {
    func toReadingDTO(withSensorId: Bool = false) -> SensorReadingDTO {
        .init(
            sensorId: withSensorId ? sensor.id : nil,
            value: value,
            timestamp: timestamp
        )
    }
}
