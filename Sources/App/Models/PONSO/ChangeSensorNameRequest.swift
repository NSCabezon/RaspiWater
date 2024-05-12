import Vapor

struct ChangeSensorNameRequest: Content {
    let newName: String
}
