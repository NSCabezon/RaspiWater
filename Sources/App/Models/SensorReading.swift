import Fluent
import Vapor

final class SensorReading: Model, Content, Sendable {
    static let schema = "sensor_reading"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "value")
    var value: Float
    
    @Field(key: "timestamp")
    var timestamp: Date

    init() { }

    init(
        id: UUID? = nil,
        name: String,
        value: Float,
        timestamp: Date
    ) {
        self.id = id
        self.name = name
        self.value = value
        self.timestamp = timestamp
    }
}
