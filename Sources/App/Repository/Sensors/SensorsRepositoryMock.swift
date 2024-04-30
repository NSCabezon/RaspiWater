import Foundation

struct SensorsRepositoryMock: SensorsRepositoryProtocol {
    func getSensorsStatus() -> [Terrace] {
        [
            .init(
                name: "bancal 1",
                sensors: [
                    .init(name: "Tomate 1", value: 200),
                    .init(name: "Tomate 2", value: 210),
                    .init(name: "Tomate 3", value: 100),
                    .init(name: "Cherry 1", value: 600),
                ]
            ),
            .init(
                name: "bancal 2",
                sensors: [
                    .init(name: "Pimientos verdes", value: 100),
                    .init(name: "Pimientos rojos", value: 420),
                    .init(name: "Berenjena 1", value: 400),
                    .init(name: "Berenjena 2", value: 600),
                ]
            ),
            .init(
                name: "bancal 3",
                sensors: [
                    .init(name: "Sandia", value: 100),
                    .init(name: "Fresón 1", value: 110),
                    .init(name: "Fresón 2", value: 200),
                    .init(name: "Lechuga", value: 100),
                ]
            ),
        ]
    }
}
