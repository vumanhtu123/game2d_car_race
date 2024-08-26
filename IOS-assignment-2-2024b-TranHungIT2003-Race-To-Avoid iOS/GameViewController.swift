
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var playerName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .green
//        if let skView = view as? SKView {
   
//        let scene = GameScene.newGameScene()
            // Present the scene
//            let skView = self.view as! SKView
//            skView.presentScene(scene)
        setupScene()
        hideBackButton()
//        }
        // Thiết lập giao diện trò chơi tại đây
    }
    
    private func setupScene() {
          let skView = SKView(frame: view.bounds)
          skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          view.addSubview(skView)
          let scene = GameScene(size: skView.bounds.size)
          scene.viewController = self
          scene.scaleMode = .aspectFill
          skView.presentScene(scene)
          
          // Optional: Use playerName in the game scene or display it
          if let name = playerName {
              print("Player Name: \(name)")
              // You can also pass this name to the GameScene if needed
          }
      }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    private func hideBackButton() {
          // Nếu view controller này nằm trong một navigation stack, nút back có thể được điều chỉnh ở đây
          self.navigationItem.hidesBackButton = true
      }
}
