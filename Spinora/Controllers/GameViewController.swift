//
//  GameViewController.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Pastikan view utama adalah SKView
        guard let skView = self.view as? SKView else {
            print("Error: View di Storyboard bukan SKView")
            return
        }
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // 2. Buat Scene secara manual (tanpa file .sks)
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        
        // 3. BAGIAN PALING PENTING: Isi viewModel-nya! (Jika ini terlewat, akan error nil)
        scene.viewModel = GameViewModel()
        
        // 4. Tampilkan scene ke layar
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
