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
    let host = Environment.get("DATABASE_HOST") ?? "localhost"
    let port = Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber
    let username = Environment.get("DATABASE_USERNAME") ?? "raspiwater"
    let password = Environment.get("DATABASE_PASSWORD") ?? "vapor_password"
    let database = Environment.get("DATABASE_NAME") ?? "vapor_database"
    debugPrint(host)
    debugPrint(port)
    debugPrint(username)
    debugPrint(password)
    debugPrint(database)
    
    let postgresConfig = SQLPostgresConfiguration(
        hostname: host,
        port: port,
        username: username,
        password: password,
        database: database,
        tls: .disable//.prefer(try .init(configuration: .clientDefault))
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
