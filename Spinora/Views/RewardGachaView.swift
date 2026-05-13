//
//  RewardGachaView.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import Foundation
import SpriteKit

extension GameScene {
    func rewardGachaView() {
        rewardAtkBtn = createButton(text: "+? ATK", color: SKColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), pos: CGPoint(x: frame.midX - 110, y: frame.midY), name: "reward_atk")
        rewardAtkBtn.alpha = 0.0
        
        rewardHpBtn = createButton(text: "+? HP", color: SKColor(red: 0.2, green: 0.8, blue: 0.5, alpha: 1.0), pos: CGPoint(x: frame.midX + 110, y: frame.midY), name: "reward_hp")
        rewardHpBtn.alpha = 0.0
    }
}
