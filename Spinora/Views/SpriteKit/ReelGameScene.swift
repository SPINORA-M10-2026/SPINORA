//
//  ReelGameScene.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SpriteKit

final class ReelGameScene: SKScene {

    private var reelColumns: [[String]] = [
        ["water", "fire", "fire"],
        ["fire", "water", "earth"],
        ["earth", "earth", "water"]
    ]

    private var reelRolledThisTurn: [Bool] = [false, false, false]

    var onReelTap: ((Int) -> Void)?

    var showTapToPlay: Bool = true {
        didSet {
            if !showTapToPlay { hideTapToPlay() }
        }
    }

    private var tapLabel: SKLabelNode?
    private var panelNode = SKShapeNode()

    private var reelNodes: [SKShapeNode] = []
    private var topSymbols: [SKSpriteNode] = []
    private var centerSymbols: [SKSpriteNode] = []
    private var bottomSymbols: [SKSpriteNode] = []

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

        guard topSymbols.count == 3,
              centerSymbols.count == 3,
              bottomSymbols.count == 3,
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
                topSymbols[index].texture = SKTexture(imageNamed: "icon_element_\(symbols[0])")
                centerSymbols[index].texture = SKTexture(imageNamed: "icon_element_\(symbols[1])")
                bottomSymbols[index].texture = SKTexture(imageNamed: "icon_element_\(symbols[2])")
            }

            let alpha: CGFloat = isUsed ? 0.45 : 1.0

            reelNodes[index].alpha = alpha
            topSymbols[index].alpha = alpha
            centerSymbols[index].alpha = alpha
            bottomSymbols[index].alpha = alpha

            reelNodes[index].strokeColor = isUsed
                ? UIColor.gray
                : UIColor(red: 0.18, green: 0.09, blue: 0.05, alpha: 1.0)
        }
    }

    private func buildScene() {
        removeAllChildren()

        reelNodes.removeAll()
        topSymbols.removeAll()
        centerSymbols.removeAll()
        bottomSymbols.removeAll()

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

            let topSymbol = SKSpriteNode(imageNamed: "icon_element_water")
            topSymbol.size = CGSize(width: 80, height: 80)
            topSymbol.position = CGPoint(x: x, y: y + reelHeight * 0.28)
            topSymbol.name = "reel_\(index)"
            topSymbol.zPosition = 30
            addChild(topSymbol)
            topSymbols.append(topSymbol)

            let centerSymbol = SKSpriteNode(imageNamed: "icon_element_fire")
            centerSymbol.size = CGSize(width: 100, height: 100)
            centerSymbol.position = CGPoint(x: x, y: y)
            centerSymbol.name = "reel_\(index)"
            centerSymbol.zPosition = 30
            addChild(centerSymbol)
            centerSymbols.append(centerSymbol)

            let bottomSymbol = SKSpriteNode(imageNamed: "icon_element_earth")
            bottomSymbol.size = CGSize(width: 80, height: 80)
            bottomSymbol.position = CGPoint(x: x, y: y - reelHeight * 0.28)
            bottomSymbol.name = "reel_\(index)"
            bottomSymbol.zPosition = 30
            addChild(bottomSymbol)
            bottomSymbols.append(bottomSymbol)
        }

        tapLabel = nil
        if showTapToPlay {
            let label = makeLabel(text: "TAP TO PLAY!", fontSize: 40)
            label.position = CGPoint(x: centerX, y: centerY)
            label.zPosition = 40
            label.alpha = 0.88
            addChild(label)
            tapLabel = label
        }
    }

    func hideTapToPlay() {
        guard let label = tapLabel else { return }
        tapLabel = nil
        label.run(.sequence([
            .fadeOut(withDuration: 0.25),
            .removeFromParent()
        ]))
    }

    private func animateReelStop(
        index: Int,
        finalTop: String,
        finalCenter: String,
        finalBottom: String
    ) {
        guard index >= 0,
              index < topSymbols.count,
              index < centerSymbols.count,
              index < bottomSymbols.count,
              index < reelNodes.count else {
            return
        }

        let possibleSymbols = ["fire", "water", "earth"]

        let top = topSymbols[index]
        let center = centerSymbols[index]
        let bottom = bottomSymbols[index]
        let reel = reelNodes[index]

        let tick = SKAction.run {
            if let randomSymbol = possibleSymbols.randomElement() {
                top.texture = SKTexture(imageNamed: "icon_element_\(randomSymbol)")
                center.texture = SKTexture(imageNamed: "icon_element_\(randomSymbol)")
                bottom.texture = SKTexture(imageNamed: "icon_element_\(randomSymbol)")
            }
        }

        let cycle = SKAction.sequence([
            tick,
            .wait(forDuration: 0.05)
        ])

        let spin = SKAction.repeat(cycle, count: 10)

        let stop = SKAction.run {
            top.texture = SKTexture(imageNamed: "icon_element_\(finalTop)")
            center.texture = SKTexture(imageNamed: "icon_element_\(finalCenter)")
            bottom.texture = SKTexture(imageNamed: "icon_element_\(finalBottom)")

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
