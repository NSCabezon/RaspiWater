import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // MARK: - Configure DB

    let postgresConfig = SQLPostgresConfiguration(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "raspiwater",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault))
    )
    
    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    
    // MARK: - Migrations
    
    app.migrations.add(CreateSensor(), to: .psql)
    app.migrations.add(CreateSensorReading(), to: .psql)

    app.views.use(.leaf)

#if os(OSX)
    app.http.server.configuration.hostname = "nostromo.local"
#else
    app.http.server.configuration.hostname = "raspi.local"
#endif
    
    // register queues
    try queues(app)

    // register routes
    try routes(app)
    
    try await app.autoMigrate()
}
