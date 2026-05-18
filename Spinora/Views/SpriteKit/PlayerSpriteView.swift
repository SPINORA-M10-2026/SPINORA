//
// playerspriteview.swift
// spinora
//
// created by assistant on 18/05/26.
//

import SwiftUI

// player animation states
enum PlayerAnimationState {
    case idle
    case attack
    case dead
}

// generic frame-based sprite animator
struct FrameAnimatedSprite: View {
    let frames: [String]
    let duration: TimeInterval   // total duration for one pass through all frames
    let repeats: Bool
    let cornerRadius: CGFloat

    init(
        frames: [String],
        duration: TimeInterval,
        repeats: Bool,
        cornerRadius: CGFloat = 16
    ) {
        self.frames = frames
        self.duration = max(0.01, duration)
        self.repeats = repeats
        self.cornerRadius = cornerRadius
    }

    private var step: TimeInterval {
        let count = max(frames.count, 1)
        return max(0.01, duration / Double(count))
    }

    @State private var startTime: Date = .now

    var body: some View {
        TimelineView(.periodic(from: startTime, by: step)) { context in
            if frames.isEmpty {
                Image(systemName: "photo.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .cornerRadius(cornerRadius)
            } else {
                let count = frames.count
                let elapsed = max(0, context.date.timeIntervalSince(startTime))
                let rawIndex = Int((elapsed / step).rounded(.down))
                let frameIndex = repeats ? (rawIndex % count) : min(rawIndex, count - 1)

                Image(frames[frameIndex])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(cornerRadius)
            }
        }
    }
}

// player sprite view
struct PlayerSpriteView: View {
    let state: PlayerAnimationState

    // default sequences using asset names
    let idleFrames: [String]
    let attackFrames: [String]
    let deadFrames: [String]

    init(
        state: PlayerAnimationState = .idle,
        idleFrames: [String] = ["knight_idle_01", "knight_idle_02"],
        attackFrames: [String] = ["knight_attack_01", "knight_attack_02", "knight_attack_03", "knight_attack_04", "knight_attack_05"],
        deadFrames: [String] = ["knight_dead_01", "knight_dead_02", "knight_dead_03", "knight_dead_04", "knight_dead_05", "knight_dead_06", "knight_dead_07"]
    ) {
        self.state = state
        self.idleFrames = idleFrames
        self.attackFrames = attackFrames
        self.deadFrames = deadFrames
    }

    var body: some View {
        Group {
            switch state {
            case .idle:
                FrameAnimatedSprite(
                    frames: idleFrames,
                    duration: 0.8,
                    repeats: true,
                    cornerRadius: 16
                )

            case .attack:
                FrameAnimatedSprite(
                    frames: attackFrames,
                    duration: 0.6,
                    repeats: false,
                    cornerRadius: 16
                )

            case .dead:
                FrameAnimatedSprite(
                    frames: deadFrames,
                    duration: 1.2,
                    repeats: false,
                    cornerRadius: 16
                )
            }
        }
        .id(state)
    }
}
