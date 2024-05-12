import Queues
import QueuesDatabaseHooks
import Vapor

func queues(_ app: Application) throws {
    app.migrations.add(QueueDatabaseEntryMigration())
    app.queues.add(QueuesDatabaseNotificationHook.default(db: app.db))
    
    let sensorsRepository: SensorsRepositoryProtocol
    
    #if os(OSX)
    sensorsRepository = SensorsRepositoryMock()
    #else
    sensorsRepository = SensorsRepository()
    #endif
    
    let updateSensorValuesJob = UpdateSensorValuesJob(sensorsRepository: sensorsRepository)
    
    app.queues.schedule(updateSensorValuesJob)
        .hourly()
        .at(.init(integerLiteral: 00))
    
    try app.queues.startScheduledJobs()
}
