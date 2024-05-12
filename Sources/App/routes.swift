import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("blink") { req async throws in
        try await req.view.render("blink", ["title": "Make that LED blink!"])
    }
    
    let gpioRepository: GPIORepositoryProtocol
    let sensorsRepository: SensorsRepositoryProtocol
    
    #if os(OSX)
    gpioRepository = GPIORepositoryMock()
    sensorsRepository = SensorsRepositoryMock()
    #else
    gpioRepository = GPIORepository()
    sensorsRepository = SensorsRepository()
    #endif
    
//    try app.register(collection: TodoController())
    try app.register(collection: GPIOController(gpioRepository: gpioRepository))
    try app.register(collection: SensorController(sensorsRepository: sensorsRepository))
    try app.register(collection: SensorReadingsController())
}
