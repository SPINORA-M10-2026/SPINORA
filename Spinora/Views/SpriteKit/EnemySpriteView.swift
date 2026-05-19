//
//  EnemySpriteView.swift
//  Spinora
//

import SwiftUI

// MARK: - MonsterType

enum MonsterType: String, CaseIterable {
    case eyes  = "eyes"
    case skull = "skull"
    case slime = "slime"

    var skinCount: Int {
        switch self {
        case .eyes:  return 8
        case .skull: return 7
        case .slime: return 4
        }
    }
}

// MARK: - EnemyAppearance

struct EnemyAppearance: Equatable {
    let type: MonsterType
    let bodyElement: Element
    let skinIndex: Int  // 1-based

    var bodyAssetName: String {
        "monster_\(type.rawValue)_body_\(bodyElement.name.lowercased())"
    }

    var skinAssetName: String {
        "monster_\(type.rawValue)_skin_\(String(format: "%02d", skinIndex))"
    }

    // type dan skinIndex dipilih independen menggunakan GameplayKit via RandomManager
    static func random(using random: RandomManager = RandomManager()) -> EnemyAppearance {
        let allTypes    = MonsterType.allCases
        let allElements = Element.allCases

        let pickedType    = allTypes[random.randomInt(upperBound: allTypes.count)]
        let pickedElement = allElements[random.randomInt(upperBound: allElements.count)]
        let pickedSkin    = random.randomInt(upperBound: pickedType.skinCount) + 1

        return EnemyAppearance(type: pickedType, bodyElement: pickedElement, skinIndex: pickedSkin)
    }
}

// MARK: - EnemySpriteView

struct EnemySpriteView: View {
    let appearance: EnemyAppearance
    var cornerRadius: CGFloat = 16

    var body: some View {
        ZStack {
            // Skin layer — warna/pola dasar monster (bawah)
            Image(appearance.skinAssetName)
                .resizable()
                .scaledToFit()

            // Body layer — outline/siluet di atas skin
            Image(appearance.bodyAssetName)
                .resizable()
                .scaledToFit()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: 16) {
        EnemySpriteView(appearance: EnemyAppearance(type: .eyes,  bodyElement: .fire,  skinIndex: 1))
            .frame(width: 175, height: 175)
        EnemySpriteView(appearance: EnemyAppearance(type: .skull, bodyElement: .water, skinIndex: 1))
            .frame(width: 175, height: 175)
        EnemySpriteView(appearance: EnemyAppearance(type: .slime, bodyElement: .earth, skinIndex: 1))
            .frame(width: 175, height: 175)
    }
    .padding()
    .background(Color(red: 0.86, green: 0.75, blue: 0.48))
}
