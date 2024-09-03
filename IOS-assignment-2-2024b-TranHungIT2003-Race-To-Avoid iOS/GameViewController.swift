/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2024B
  Assessment: Assignment 2
  Author: Tran Duy Hung
  ID: s3928533
  Created date: 12/08/2024
  Last modified: 01/09/2024
  Acknowledgement:
*/
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var playerName: String = "" // Giá trị mặc định
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
          scene.playerName = self.playerName
          skView.presentScene(scene)
          
          // Optional: Use playerName in the game scene or display it
     
      }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func showLeaderboard(withLeaderboard leaderboard: [[String: Any]]) {
         let leaderboardVC = LeaderboardViewController()
         navigationController?.pushViewController(leaderboardVC, animated: true)
     }
    
    private func hideBackButton() {
          // Nếu view controller này nằm trong một navigation stack, nút back có thể được điều chỉnh ở đây
          self.navigationItem.hidesBackButton = true
      }
}
