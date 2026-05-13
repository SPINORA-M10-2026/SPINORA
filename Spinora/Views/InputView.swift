//
//  InputView.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import Foundation
import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let tappedNodes = nodes(at: location)
        for node in tappedNodes {
            guard let name = node.name else { continue }
            
            let pressAction = SKAction.sequence([SKAction.scale(to: 0.9, duration: 0.1), SKAction.scale(to: 1.0, duration: 0.1)])
            
            if name == "reward_atk" {
                node.run(pressAction)
                viewModel.intentSelectReward(increaseATK: true)
                return
            } else if name == "reward_hp" {
                node.run(pressAction)
                viewModel.intentSelectReward(increaseATK: false)
                return
            } else if name == "spin" {
                node.run(pressAction)
                viewModel.intentSpinAll()
            } else if name == "attack" {
                node.run(pressAction)
                viewModel.intentAttack()
            } else if name.hasPrefix("reroll_") {
                node.run(pressAction)
                let indexStr = name.replacingOccurrences(of: "reroll_", with: "")
                if let index = Int(indexStr) {
                    viewModel.intentRerollSlot(at: index)
                }
            }
        }
    }
}
