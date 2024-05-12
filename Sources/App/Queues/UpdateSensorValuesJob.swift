import Queues
import QueuesDatabaseHooks
import Vapor

struct AsyncCleanupJob: AsyncScheduledJob {
    // Add extra services here via dependency injection, if you need them.

    func run(context: QueueContext) async throws {
        // Do some work here, perhaps queue up another job.
    }
}

struct UpdateSensorValuesJob: AsyncScheduledJob {
    // Add extra services here via dependency injection, if you need them.
    let sensorsRepository: SensorsRepositoryProtocol

    func run(context: QueueContext) async throws {
        // Do some work here, perhaps queue up another job.
        let terraces = sensorsRepository.getSensorsStatus()
        
        let db = context.application.db
        
        let sensors = terraces.flatMap { $0.sensors }
        
        let date = Date()
        for sensorToAdd in sensors {
            let sensorId = sensorToAdd.sensorId
            guard let sensor = try await Sensor.find(sensorId, on: db) else {
                debugPrint("Sensor with id: \(sensorId) not found")
                continue
            }
            let sensorReading = SensorReading(value: sensorToAdd.value, timestamp: date)
            try await sensor.$readings.create(sensorReading, on: db)
        }
    }
}
