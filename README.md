# Team Task Order and Separation

The project uses the following structure:

- **MVVM** for game state and gameplay coordination
- **SpriteKit** for rendering, animation, and visual feedback
- **GameplayKit** for random reel output
- **SwiftData** for persistence and save/load data

## 0. Initial Shared Task: Project Foundation

This task should be done first because everyone depends on the basic project structure.

**Main PIC:** Person 4
**Support:** All members

### Tasks

```text
1. Create the final folder structure
2. Create AppModelContainer.swift
3. Register all main SwiftData @Model classes
4. Create empty/stub model files
5. Create empty/stub manager files
6. Create initial GameViewModel
7. Make sure the project can build successfully
````

### Initial Files to Create

```text
App/
├── AppModelContainer.swift

ViewModels/
└── GameViewModel.swift

Models/
├── Element.swift
├── Monster.swift
├── UpgradeOption.swift
├── CombatSummary.swift
├── ComboEffect.swift
└── GameBalance.swift

Systems/
├── RandomManager.swift
├── ReelManager.swift
├── CombatManager.swift
├── UpgradeManager.swift
└── StageManager.swift
```

The purpose of this phase is not to finish the gameplay, but to prepare the structure so everyone can start working on their own files.


# Recommended Task Order

## Phase 1: Build Independent Foundations

After the project structure is ready, all four members can work in parallel.


## Person 1: FX / SpriteKit Feel

Person 1 can start without waiting for combat logic to be finished. The first step is to create placeholder functions for visual and audio feedback.

### Main Responsibilities

```text
1. Create SoundPlayer.swift
2. Create HapticPlayer.swift
3. Create AssetNames.swift
4. Create VFXConfig.swift
5. Create dummy functions for:
   - playAttackSound()
   - playHitSound()
   - playStageClearSound()
   - triggerLightHaptic()
   - triggerHeavyHaptic()
6. Prepare GameScene+CombatFX.swift
7. Prepare GameScene+ReelAnimation.swift
```

### Example

```swift
final class SoundPlayer {
    static let shared = SoundPlayer()

    func playAttackSound() {
        // TODO: play attack sound
    }

    func playHitSound() {
        // TODO: play hit sound
    }

    func playStageClearSound() {
        // TODO: play stage clear sound
    }
}
```

Person 1 does not need to wait for the damage formula. Later, Person 4 can call these functions when an attack, hit, or stage clear happens.

## Person 2: Balance / Progression / Rewards

Person 2 can start with balancing and progression formulas without waiting for the reel or combat system.

### Main Responsibilities

```text
1. Create GameBalance.swift
2. Create Monster.swift structure
3. Create UpgradeOption.swift
4. Create StageManager.swift
5. Create UpgradeManager.swift
6. Define formulas for:
   - monster HP per stage
   - monster attack per stage
   - reward per stage
   - upgrade percentage
   - boss/elite scaling
```

### Example

```swift
struct GameBalance {
    static func monsterHP(stage: Int) -> Int {
        return 50 + (stage * 10)
    }

    static func monsterAttack(stage: Int) -> Int {
        return 5 + (stage * 2)
    }

    static func rewardCoins(stage: Int) -> Int {
        return 10 + (stage * 3)
    }
}
```

Person 2 does not need to wait for `GameViewModel` to be finished. The most important thing is to provide clear output, such as:

```swift
generateMonster(stage:)
generateUpgradeOptions()
```


## Person 3: GameplayKit / Reel System

Person 3 can start directly from random output and reel rules. This does not depend on combat or animation.

### Main Responsibilities

```text
1. Create Element.swift
2. Create RandomManager.swift
3. Create ReelManager.swift
4. Define symbol distribution
5. Create 3-roll chance logic
6. Create turn reset logic
7. Create validation for whether the player can still roll
```

### Example

```swift
enum Element: String, Codable, CaseIterable {
    case fire
    case water
    case earth
}
```

```swift
final class ReelManager {
    private(set) var remainingRolls: Int = 3

    func canRoll() -> Bool {
        return remainingRolls > 0
    }

    func roll() -> Element? {
        guard canRoll() else { return nil }
        remainingRolls -= 1
        return RandomManager.shared.randomElement()
    }

    func resetRolls() {
        remainingRolls = 3
    }
}
```

Person 3 does not need to wait for SpriteKit animation. The reel system only needs to produce the roll result. Later, Person 1 can create the animation based on that result.


## Person 4: Combat / GameViewModel / Save Integration

Person 4 owns the main gameplay integration. Since this role connects many systems, the first task should be a simple playable flow using dummy data.

### Main Responsibilities

```text
1. Create CombatManager.swift
2. Create CombatSummary.swift
3. Create ComboEffect.swift
4. Create initial GameViewModel state
5. Create simple resolveAttack logic
6. Create element advantage logic
7. Create enemy death condition
8. Create placeholder spawn next enemy logic
```

### Example

```swift
final class CombatManager {
    func calculateDamage(playerElement: Element, enemyElement: Element, baseDamage: Int) -> Int {
        if isWeakness(playerElement: playerElement, enemyElement: enemyElement) {
            return baseDamage * 2
        }

        return baseDamage
    }

    private func isWeakness(playerElement: Element, enemyElement: Element) -> Bool {
        switch (playerElement, enemyElement) {
        case (.water, .fire):
            return true
        case (.earth, .water):
            return true
        case (.fire, .earth):
            return true
        default:
            return false
        }
    }
}
```

Person 4 can use dummy data first from Person 2 and Person 3. After the other systems are ready, the dummy data can be replaced with the real managers.

# Dependency-Based Task Order

The safest development order is:

```text
1. Project structure + empty files
2. Shared basic models
3. Manager stubs
4. Each person works on their own area
5. Integrate ReelManager into GameViewModel
6. Integrate CombatManager into GameViewModel
7. Integrate StageManager and UpgradeManager
8. Integrate FX calls from GameViewModel/GameScene
9. Integrate SwiftData save/load
10. Test the full gameplay loop
```

# Dependency Map

## Can Be Done Without Waiting

These tasks can be worked on in parallel:

```text
Person 1:
FX, sound, haptic, animation placeholder

Person 2:
Game balance, monster scaling, upgrade formula

Person 3:
RandomManager, ReelManager, roll chance logic

Person 4:
CombatManager, GameViewModel state, save/load structure
```

## Requires Partial Dependency

These tasks should be done after the related system is available:

```text
GameViewModel integrates ReelManager
Requires output from Person 3

GameViewModel integrates StageManager
Requires output from Person 2

GameScene triggers reel animation
Requires output from Person 1 and Person 3

Save active run
Requires stable state from Person 4

Run history
Requires combat result and stage result
```


# Suggested Task Board

## Initial Backlog

```text
[Setup] Create project folder structure
[Setup] Create AppModelContainer
[Setup] Create basic Models
[Setup] Create manager stubs
[Setup] Create empty repositories
```


## Person 1 Task Board

```text
[FX] Create SoundPlayer
[FX] Create HapticPlayer
[FX] Create AssetNames
[FX] Create VFXConfig
[FX] Create attack VFX function
[FX] Create hit feedback function
[FX] Create reel spin animation
[FX] Create stage clear effect
[FX] Create defeat effect
[FX] Add settings toggle for sound/haptic
```


## Person 2 Task Board

```text
[Balance] Define GameBalance constants
[Balance] Create monster scaling formula
[Balance] Create boss/elite scaling
[Balance] Create stage reward formula
[Balance] Create UpgradeOption model
[Balance] Create UpgradeManager
[Balance] Create StageManager
[Balance] Write balance notes per stage
```



## Person 3 Task Board

```text
[Reel] Create Element enum
[Reel] Create RandomManager with GameplayKit
[Reel] Create ReelManager
[Reel] Create roll chance logic
[Reel] Create reroll validation
[Reel] Create reset turn logic
[Reel] Define symbol probability
[Reel] Connect reel input function
[Reel] Optional: save reel stats
```

## Person 4 Task Board

```text
[Combat] Create CombatSummary
[Combat] Create ComboEffect
[Combat] Create CombatManager
[Combat] Create element weakness logic
[Combat] Create resolveAttack flow
[Combat] Create enemy counterattack
[Combat] Create death condition
[Combat] Create stage clear trigger
[Integration] Create GameViewModel state
[Integration] Connect ReelManager to GameViewModel
[Integration] Connect CombatManager to GameViewModel
[Persistence] Create SavedRunModel
[Persistence] Create RunHistoryModel
[Persistence] Create repositories and mappers
[Persistence] Connect save/load flow
```

# Recommended Sprint Order

## Sprint 1: Project Foundation

### Target

All members can work without major conflicts.

### Tasks

```text
- Finalize folder structure
- Create AppModelContainer
- Create basic models
- Create manager stubs
- Make sure the project can build
```

### Output

```text
The project has the final structure, but gameplay does not need to work perfectly yet.
```


## Sprint 2: Core System Per Role

### Target

Each member has their main system working independently.

### Tasks

```text
Person 1:
Basic FX functions

Person 2:
Basic monster scaling and reward

Person 3:
Basic 3-roll system

Person 4:
Basic attack and enemy death logic
```

### Output

```text
The gameplay can be tested in a simple form, even if the visuals are not final yet.
```


## Sprint 3: Gameplay Loop Integration

### Target

The main gameplay loop works.

### Required Flow

```text
1. Enemy appears
2. Player rolls up to 3 times
3. Player gets an element
4. Player attacks enemy
5. Damage is calculated based on weakness
6. Enemy dies or counterattacks
7. If the enemy dies, a new enemy appears
```

### Output

```text
The game is playable in a basic form.
```


## Sprint 4: Persistence and Polish

### Target

Progress can be saved, loaded, and the game starts to feel polished.

### Tasks

```text
- Save active run
- Load active run
- Save run history
- Save settings
- Add sound
- Add haptic
- Add VFX
- Add reel animation polish
```

### Output

```text
The game feels more complete, and data is not lost when the app is closed.
```

# Recommended Git Branches

```text
refactor/project-structure
feature/fx-feedback
feature/balance-progression
feature/reel-system
feature/combat-integration
```

## Suggested Merge Order

```text
1. refactor/project-structure
2. feature/reel-system
3. feature/balance-progression
4. feature/combat-integration
5. feature/fx-feedback
```

The `fx-feedback` branch is recommended to be merged last because FX usually depends on gameplay events such as attack, hit, enemy death, and stage clear.
                                

# Final Recommended Order

```text
1. Create shared folder structure and empty files
2. Create basic models: Element, Monster, CombatSummary, UpgradeOption
3. Person 1 works on FX independently
4. Person 2 works on balance and progression
5. Person 3 works on reel and random system
6. Person 4 works on combat and GameViewModel
7. Integrate ReelManager into GameViewModel
8. Integrate CombatManager into GameViewModel
9. Integrate StageManager and UpgradeManager
10. Add FX calls to GameScene
11. Add SwiftData save/load
12. Test and polish
```


# Team Rules to Avoid Conflict

```text
Person 1 should not change combat formulas.
Person 2 should not change SpriteKit animation.
Person 3 should not change damage formulas.
Person 4 should not change balance numbers without coordination.
Everyone must use the same AppModelContainer.
```

```
```
