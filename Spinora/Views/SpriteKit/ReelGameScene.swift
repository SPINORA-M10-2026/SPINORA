//
//  ReelGameScene.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SpriteKit

final class ReelGameScene: SKScene {

    private var reelColumns: [[String]] = [
        ["💧", "🔥", "🔥"],
        ["🔥", "💧", "🪨"],
        ["🪨", "🪨", "💧"]
    ]

    private var reelRolledThisTurn: [Bool] = [false, false, false]

    var onReelTap: ((Int) -> Void)?

    private var panelNode = SKShapeNode()

    private var reelNodes: [SKShapeNode] = []
    private var topLabels: [SKLabelNode] = []
    private var centerLabels: [SKLabelNode] = []
    private var bottomLabels: [SKLabelNode] = []

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        anchorPoint = .zero
        scaleMode = .resizeFill

        buildScene()

        updateScene(
            reelColumns: reelColumns,
            reelRolledThisTurn: reelRolledThisTurn,
            animatedChangedIndex: nil
        )
    }

    override func didChangeSize(_ oldSize: CGSize) {
        guard size.width > 0, size.height > 0 else {
            return
        }

        buildScene()

        updateScene(
            reelColumns: reelColumns,
            reelRolledThisTurn: reelRolledThisTurn,
            animatedChangedIndex: nil
        )
    }

    func updateScene(
        reelColumns: [[String]],
        reelRolledThisTurn: [Bool],
        animatedChangedIndex: Int?
    ) {
        self.reelColumns = reelColumns
        self.reelRolledThisTurn = reelRolledThisTurn

        guard topLabels.count == 3,
              centerLabels.count == 3,
              bottomLabels.count == 3,
              reelNodes.count == 3 else {
            return
        }

        for index in 0..<3 {
            guard index < reelColumns.count,
                  reelColumns[index].count >= 3 else {
                continue
            }

            let symbols = reelColumns[index]
            let isUsed = isReelUsed(index)

            if animatedChangedIndex == index {
                animateReelStop(
                    index: index,
                    finalTop: symbols[0],
                    finalCenter: symbols[1],
                    finalBottom: symbols[2]
                )
            } else {
                topLabels[index].text = symbols[0]
                centerLabels[index].text = symbols[1]
                bottomLabels[index].text = symbols[2]
            }

            let alpha: CGFloat = isUsed ? 0.45 : 1.0

            reelNodes[index].alpha = alpha
            topLabels[index].alpha = alpha
            centerLabels[index].alpha = alpha
            bottomLabels[index].alpha = alpha

            reelNodes[index].strokeColor = isUsed
                ? UIColor.gray
                : UIColor(red: 0.18, green: 0.09, blue: 0.05, alpha: 1.0)
        }
    }

    private func buildScene() {
        removeAllChildren()

        reelNodes.removeAll()
        topLabels.removeAll()
        centerLabels.removeAll()
        bottomLabels.removeAll()

        let panelWidth: CGFloat = 670
        let panelHeight: CGFloat = 390

        let centerX = size.width / 2
        let centerY = size.height / 2

        panelNode = SKShapeNode(
            rectOf: CGSize(width: panelWidth, height: panelHeight),
            cornerRadius: 28
        )
        panelNode.fillColor = UIColor(red: 0.48, green: 0.25, blue: 0.14, alpha: 1.0)
        panelNode.strokeColor = .clear
        panelNode.position = CGPoint(x: centerX, y: centerY)
        panelNode.zPosition = 1
        addChild(panelNode)

        let reelWidth: CGFloat = 190
        let reelHeight: CGFloat = 315

        let reelXPositions: [CGFloat] = [
            centerX - 201,
            centerX,
            centerX + 201
        ]

        for index in 0..<3 {
            let x = reelXPositions[index]
            let y = centerY

            let reelNode = SKShapeNode(
                rectOf: CGSize(width: reelWidth, height: reelHeight),
                cornerRadius: 16
            )
            reelNode.fillColor = UIColor(red: 0.95, green: 0.72, blue: 0.43, alpha: 1.0)
            reelNode.strokeColor = UIColor(red: 0.18, green: 0.09, blue: 0.05, alpha: 1.0)
            reelNode.lineWidth = 7
            reelNode.position = CGPoint(x: x, y: y)
            reelNode.name = "reel_\(index)"
            reelNode.zPosition = 10
            addChild(reelNode)
            reelNodes.append(reelNode)

            let topShade = SKShapeNode(
                rectOf: CGSize(width: reelWidth - 14, height: reelHeight / 3),
                cornerRadius: 0
            )
            topShade.fillColor = UIColor(red: 0.84, green: 0.58, blue: 0.32, alpha: 0.62)
            topShade.strokeColor = .clear
            topShade.position = CGPoint(x: x, y: y + reelHeight / 3)
            topShade.zPosition = 11
            addChild(topShade)

            let bottomShade = SKShapeNode(
                rectOf: CGSize(width: reelWidth - 14, height: reelHeight / 3),
                cornerRadius: 0
            )
            bottomShade.fillColor = UIColor(red: 0.84, green: 0.58, blue: 0.32, alpha: 0.62)
            bottomShade.strokeColor = .clear
            bottomShade.position = CGPoint(x: x, y: y - reelHeight / 3)
            bottomShade.zPosition = 11
            addChild(bottomShade)

            let topLabel = makeLabel(text: "💧", fontSize: 38)
            topLabel.position = CGPoint(x: x, y: y + reelHeight * 0.28)
            topLabel.name = "reel_\(index)"
            topLabel.zPosition = 30
            addChild(topLabel)
            topLabels.append(topLabel)

            let centerLabel = makeLabel(text: "🔥", fontSize: 54)
            centerLabel.position = CGPoint(x: x, y: y)
            centerLabel.name = "reel_\(index)"
            centerLabel.zPosition = 30
            addChild(centerLabel)
            centerLabels.append(centerLabel)

            let bottomLabel = makeLabel(text: "🪨", fontSize: 38)
            bottomLabel.position = CGPoint(x: x, y: y - reelHeight * 0.28)
            bottomLabel.name = "reel_\(index)"
            bottomLabel.zPosition = 30
            addChild(bottomLabel)
            bottomLabels.append(bottomLabel)
        }

        let tapLabel = makeLabel(text: "TAP TO PLAY!", fontSize: 40)
        tapLabel.position = CGPoint(x: centerX, y: centerY)
        tapLabel.zPosition = 40
        tapLabel.alpha = 0.88
        addChild(tapLabel)
    }

    private func animateReelStop(
        index: Int,
        finalTop: String,
        finalCenter: String,
        finalBottom: String
    ) {
        guard index >= 0,
              index < topLabels.count,
              index < centerLabels.count,
              index < bottomLabels.count,
              index < reelNodes.count else {
            return
        }

        let possibleSymbols = ["🔥", "💧", "🪨"]

        let top = topLabels[index]
        let center = centerLabels[index]
        let bottom = bottomLabels[index]
        let reel = reelNodes[index]

        let tick = SKAction.run {
            top.text = possibleSymbols.randomElement()
            center.text = possibleSymbols.randomElement()
            bottom.text = possibleSymbols.randomElement()
        }

        let cycle = SKAction.sequence([
            tick,
            .wait(forDuration: 0.05)
        ])

        let spin = SKAction.repeat(cycle, count: 10)

        let stop = SKAction.run {
            top.text = finalTop
            center.text = finalCenter
            bottom.text = finalBottom

            center.run(.sequence([
                .scale(to: 1.18, duration: 0.08),
                .scale(to: 1.0, duration: 0.10)
            ]))

            reel.run(.sequence([
                .scale(to: 1.06, duration: 0.08),
                .scale(to: 1.0, duration: 0.10)
            ]))
        }

        run(.sequence([
            spin,
            stop
        ]))
    }

    private func makeLabel(text: String, fontSize: CGFloat) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontName = "AvenirNext-Heavy"
        label.fontSize = fontSize
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        return label
    }

    private func isReelUsed(_ index: Int) -> Bool {
        guard index >= 0 && index < reelRolledThisTurn.count else {
            return true
        }

        return reelRolledThisTurn[index]
    }

    private func reelIndex(from nodeName: String) -> Int? {
        guard nodeName.starts(with: "reel_") else {
            return nil
        }

        let indexText = nodeName.replacingOccurrences(of: "reel_", with: "")
        return Int(indexText)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let point = touch.location(in: self)
        let touchedNodes = nodes(at: point)

        for node in touchedNodes {
            guard let name = node.name,
                  let index = reelIndex(from: name),
                  !isReelUsed(index) else {
                continue
            }

            onReelTap?(index)
            return
        }
    }
}
