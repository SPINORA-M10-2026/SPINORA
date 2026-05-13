import GameplayKit

final class RandomManager {
    static let shared = RandomManager()

    private let source: GKRandomSource

    init(seed: UInt64? = nil) {
        if let seed {
            self.source = GKMersenneTwisterRandomSource(seed: seed)
        } else {
            self.source = GKRandomSource.sharedRandom()
        }
    }

    func randomElement() -> Element {
        let elements = Element.allCases
        let index = source.nextInt(upperBound: elements.count)
        return elements[index]
    }
}
