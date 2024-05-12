import Queues
import QueuesDatabaseHooks
import Vapor


func queues(_ app: Application) throws {
    let debugging = false
    
    app.migrations.add(QueueDatabaseEntryMigration())
    app.queues.add(QueuesDatabaseNotificationHook.default(db: app.db))
    
    let sensorsRepository: SensorsRepositoryProtocol
    
    #if os(OSX)
    sensorsRepository = SensorsRepositoryMock()
    #else
    sensorsRepository = SensorsRepository()
    #endif
    
    let updateSensorValuesJob = UpdateSensorValuesJob(sensorsRepository: sensorsRepository)
    
    if debugging {
        app.queues.schedule(updateSensorValuesJob)
            .minutely()
            .at(.init(integerLiteral: 30))
    } else {
        app.queues.schedule(updateSensorValuesJob)
            .hourly()
            .at(.init(integerLiteral: 00))
    }
    
    try app.queues.startScheduledJobs()
}
