//
//  RandomManager.swift
//  Spinora
//
//  Created by Stanley Young on 13/05/26.
//

import Foundation
import GameplayKit

final class RandomManager {
    private let source: GKRandomSource

    init(seed: UInt64? = nil) {
        if let seed {
            self.source = GKMersenneTwisterRandomSource(seed: seed)
        } else {
            self.source = GKMersenneTwisterRandomSource()
        }
    }

    func randomInt(upperBound: Int) -> Int {
        guard upperBound > 0 else {
            return 0
        }

        return source.nextInt(upperBound: upperBound)
    }

    func randomElement() -> Element {
        let allElements = Element.allCases
        let index = randomInt(upperBound: allElements.count)

        return allElements[index]
    }

    func randomElements(count: Int) -> [Element] {
        guard count > 0 else {
            return []
        }

        return (0..<count).map { _ in
            randomElement()
        }
    }

    func chance(_ probability: Double) -> Bool {
        let clampedProbability = max(0.0, min(1.0, probability))
        let randomValue = Double(source.nextUniform())

        return randomValue < clampedProbability
    }
}
