import Fluent
import Vapor

final class SensorReading: Model, Content, Sendable {
    static let schema = "sensor_reading"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "sensor_id")
    var sensor: Sensor
    
    @Field(key: "value")
    var value: Float
    
    @Field(key: "timestamp")
    var timestamp: Date

    init() { }

    init(
        id: UUID? = nil,
        value: Float,
        timestamp: Date
    ) {
        self.id = id
        self.value = value
        self.timestamp = timestamp
    }
}
