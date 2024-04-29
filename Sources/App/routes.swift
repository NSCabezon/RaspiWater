import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }
    
    app.get("blink") { req async throws in
        try await req.view.render("blink", ["title": "Make that LED blink!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    let repository: GPIORepositoryProtocol
    
    #if os(OSX)
    repository = GPIORepositoryMock()
    #else
    repository = GPIORepository()
    #endif
    
//    try app.register(collection: TodoController())
    try app.register(collection: GPIOController(gpioRepository: repository))
}
