import Vapor

struct GPIOBlinkRequest: Content  {
    let timesToBlink: Int
    let ledName: Pin
}
