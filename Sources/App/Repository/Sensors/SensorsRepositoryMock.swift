import Foundation

struct SensorsRepositoryMock: SensorsRepositoryProtocol {
    func getSensorsStatus() -> [Terrace] {
        [
            .init(
                name: "bancal 1",
                sensors: [
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c462")!, value: 200),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c463")!, value: 210),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c464")!, value: 100),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c465")!, value: 600),
                ]
            ),
            .init(
                name: "bancal 2",
                sensors: [
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c466")!, value: 100),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c467")!, value: 420),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c468")!, value: 400),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c469")!, value: 600),
                ]
            ),
            .init(
                name: "bancal 3",
                sensors: [
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c470")!, value: 100),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c471")!, value: 110),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c472")!, value: 200),
                    .init(sensorId: UUID(uuidString: "4820ab97-964e-418b-b768-89ce1d62c473")!, value: 100),
                ]
            ),
        ]
    }
}
