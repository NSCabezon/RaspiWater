import Fluent

struct CreateSensorValue: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(SensorReading.schema)
            .id()
            .field("name", .string, .required)
            .field("value", .float, .required)
            .field("timestamp", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(SensorReading.schema).delete()
    }
}
