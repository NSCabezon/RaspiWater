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
        debugPrint(terraces)
        
        let db = context.application.db
        
        let sensors = terraces.flatMap { $0.sensors }
        
        let date = Date()
        let sensorsDB = sensors.map { SensorReading(name: $0.name, value: $0.value, timestamp: date) }
        
        try await sensorsDB.create(on: db)
    }
}
