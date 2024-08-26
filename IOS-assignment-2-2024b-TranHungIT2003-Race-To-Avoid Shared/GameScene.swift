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

import SpriteKit
import UIKit
import GameplayKit

class GameScene: SKScene {
    
    private var track1: SKSpriteNode!
    private var track2: SKSpriteNode!
    private var pauseButton: SKSpriteNode!
    
    private var pauseOverlay: SKSpriteNode?
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?
    
    private var player: SKSpriteNode?
    private let laneWidth: CGFloat = 60.0
    private var lanes: [CGFloat] = []
    private var currentLane: Int = 1
    private var obstacles: [SKSpriteNode] = []
    weak var viewController: GameViewController?
    
    
    override func didMove(to view: SKView) {
            super.didMove(to: view)
            createRaceTrack()
            startTrackScrolling()
            addPauseButton()
        setupLanes()
        setupPlayer()
        spawnObstacles()
        }
        
    private func createRaceTrack() {
            // Xóa tất cả các nút hiện có
            removeAllChildren()
            
            let trackTexture = SKTexture(imageNamed: "road")

            let trackWidth = trackTexture.size().width
            let trackHeight = trackTexture.size().height

            // Tính kích thước của track sao cho phù hợp với màn hình
            let screenSize = size
            let newTrackWidth = screenSize.width
            let newTrackHeight = (screenSize.width / trackWidth) + 1000

            // Tạo hai bản sao của đường đua
            track1 = SKSpriteNode(texture: trackTexture)
            track2 = SKSpriteNode(texture: trackTexture)

            // Đặt kích thước cho các bản sao
            track1.size = CGSize(width: newTrackWidth, height: newTrackHeight)
            track2.size = track1.size
            
            // Đặt vị trí cho các bản sao
            track1.position = CGPoint(x: frame.midX, y: frame.midY)
            track2.position = CGPoint(x: frame.midX, y: frame.midY + newTrackHeight)

            // Đặt zPosition để đường đua nằm dưới các đối tượng khác
            track1.zPosition = -1
            track2.zPosition = -1
            
            // Thêm đường đua vào scene
            addChild(track1)
            addChild(track2)
        }
        
        private func startTrackScrolling() {
            guard let track1 = track1, let track2 = track2 else { return }
            
            let trackHeight = track1.size.height
            
            let moveAction = SKAction.moveBy(x: 0, y: -trackHeight, duration: 5)
            let resetAction = SKAction.moveBy(x: 0, y: trackHeight, duration: 0)
            let sequence = SKAction.sequence([moveAction, resetAction])
            let repeatAction = SKAction.repeatForever(sequence)
            
            // Thực hiện cuộn cho cả hai bản sao
            track1.run(repeatAction)
            track2.run(repeatAction)
            
            // Đảm bảo rằng track2 di chuyển ngay sau track1 để tạo hiệu ứng liên tục
            track2.position = CGPoint(x: track1.position.x, y: track1.position.y + trackHeight)
        }
    
    private func addPauseButton() {
            let pauseIcon = SKTexture(imageNamed: "pause")
            pauseButton = SKSpriteNode(texture: pauseIcon)
            pauseButton?.position = CGPoint(x: size.width - 50, y: size.height - 120)
            pauseButton?.size = CGSize(width: 40, height: 40)
            pauseButton?.zPosition = 100
            pauseButton?.name = "pauseButton"
            if let pauseButton = pauseButton {
                addChild(pauseButton)
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let touchLocation = touch.location(in: self)
            
            if let pauseButton = pauseButton, pauseButton.contains(touchLocation) {
                togglePause()
            } else {
                let node = atPoint(touchLocation) as? SKSpriteNode
                handleMenuTouch(node: node)
            }
        }
        
      private func togglePause() {
        if view?.isPaused == true {
            resumeGame()
        } else {
            pauseGame()
        }
    }

    private func pauseGame() {
        self.showPauseOverlay()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.view?.isPaused = true
                // Ví dụ: Hiển thị một thông báo hoặc thực hiện hành động khác
                print("Paused for 3 seconds")
            }
      }

        
        private func resumeGame() {
            view?.isPaused = false
            pauseButton?.texture = SKTexture(imageNamed: "pause")
            hidePauseOverlay()
        }
        
        private func showPauseOverlay() {
            if pauseOverlay == nil {
                pauseOverlay = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: size)
                pauseOverlay?.position = CGPoint(x: size.width / 2, y: size.height / 2)
                pauseOverlay?.zPosition = 99
                pauseOverlay?.name = "pauseOverlay"
                
                let menuBackground = SKSpriteNode(color: UIColor.white, size: CGSize(width: 300, height: 200))
                menuBackground.position = CGPoint(x: 0, y: 0)
                menuBackground.zPosition = 100
                menuBackground.name = "menuBackground"
                
                let resumeButton = SKSpriteNode(imageNamed: "play")
                resumeButton.position = CGPoint(x: 0, y: 50)
                resumeButton.size = CGSize(width: 50, height: 50)
                resumeButton.zPosition = 101
                resumeButton.name = "resumeButton"
                
                let quitButton = SKSpriteNode(imageNamed: "quit")
                quitButton.position = CGPoint(x: 0, y: -50)
                quitButton.size = CGSize(width: 50, height: 50)
                quitButton.zPosition = 101
                quitButton.name = "quitButton"
                
                menuBackground.addChild(resumeButton)
                menuBackground.addChild(quitButton)
                pauseOverlay?.addChild(menuBackground)
                if let pauseOverlay = pauseOverlay {
                    addChild(pauseOverlay)
                }
            }
        }
        
        private func hidePauseOverlay() {
            pauseOverlay?.removeFromParent()
            pauseOverlay = nil
        }
        
        private func handleMenuTouch(node: SKSpriteNode?) {
            if let node = node {
                if node.name == "resumeButton" {
                    resumeGame()
                } else if node.name == "quitButton" {
                    quitGame()
                }
            }
        }
       
       private func quitGame() {
           // Xử lý khi người dùng chọn thoát
           print("Quitting game...")
           viewController?.navigationController?.popViewController(animated: true)
           // Có thể thực hiện hành động quay lại màn hình chính hoặc thoát ứng dụng
       }
    
    private func setupPlayer() {
            let playerTexture = SKTexture(imageNamed: "car") // Thay thế bằng tên ảnh của bạn
            player = SKSpriteNode(texture: playerTexture)
            player?.size = CGSize(width: 50, height: 50) // Kích thước của nhân vật
            player?.position = CGPoint(x: size.width / 2, y: size.height / 4) // Vị trí ban đầu của nhân vật
            player?.zPosition = 5 // Đặt lớp z để nhân vật nằm trên nền
            if let player = player {
                addChild(player)
            }
        }
        
        private func setupLanes() {
            let laneCount = 3
            let totalWidth = CGFloat(laneCount) * laneWidth
            let startX = (size.width - totalWidth) / 2 + laneWidth / 2
            
            for i in 0..<laneCount {
                lanes.append(startX + CGFloat(i) * laneWidth)
            }
        }
    
    private func spawnObstacles() {
            let obstacleTexture = SKTexture(imageNamed: "enemy_car_1") // Thay thế bằng tên ảnh của bạn
            let obstacleWidth: CGFloat = 50
            let obstacleHeight: CGFloat = 50
            let spawnInterval: TimeInterval = 2.0
            
            let spawnAction = SKAction.run {
                let obstacle = SKSpriteNode(texture: obstacleTexture)
                obstacle.size = CGSize(width: obstacleWidth, height: obstacleHeight)
                let randomLaneIndex = Int(arc4random_uniform(UInt32(self.lanes.count)))
                obstacle.position = CGPoint(x: self.lanes[randomLaneIndex], y: self.size.height + obstacleHeight)
                obstacle.zPosition = 1
                self.addChild(obstacle)
                self.obstacles.append(obstacle)
                
                let moveAction = SKAction.moveBy(x: 0, y: -self.size.height - obstacleHeight, duration: 5)
                let removeAction = SKAction.removeFromParent()
                let sequence = SKAction.sequence([moveAction, removeAction])
                obstacle.run(sequence)
            }
            
            let waitAction = SKAction.wait(forDuration: spawnInterval)
            let spawnSequence = SKAction.sequence([spawnAction, waitAction])
            run(SKAction.repeatForever(spawnSequence))
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let touchLocation = touch.location(in: self)
            
            if let player = player {
                let closestLaneIndex = closestLaneIndex(for: touchLocation.x)
                if currentLane != closestLaneIndex {
                    currentLane = closestLaneIndex
                    let newPosition = CGPoint(x: lanes[currentLane], y: player.position.y)
                    player.position = newPosition
                }
            }
        }
        
        private func closestLaneIndex(for xPosition: CGFloat) -> Int {
            var closestIndex = 0
            var closestDistance = CGFloat.greatestFiniteMagnitude
            
            for (index, lane) in lanes.enumerated() {
                let distance = abs(xPosition - lane)
                if distance < closestDistance {
                    closestDistance = distance
                    closestIndex = index
                }
            }
            
            return closestIndex
        }
        
        private func checkForCollisions() {
            guard let player = player else { return }
            
            for obstacle in obstacles {
                if player.frame.intersects(obstacle.frame) {
                    gameOver()
                    break
                }
            }
        }
        
        private func gameOver() {
            // Dừng trò chơi và hiển thị thông báo Game Over
            if pauseOverlay == nil {
                pauseOverlay = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: size)
                pauseOverlay?.position = CGPoint(x: size.width / 2, y: size.height / 2)
                pauseOverlay?.zPosition = 99
                pauseOverlay?.name = "pauseOverlay"
                
                let menuBackground = SKSpriteNode(color: UIColor.white, size: CGSize(width: 300, height: 200))
                menuBackground.position = CGPoint(x: 0, y: 0)
                menuBackground.zPosition = 100
                menuBackground.name = "menuBackground"
                
                let gameOverLabel = SKLabelNode(text: "Game Over")
                gameOverLabel.fontSize = 40
                gameOverLabel.fontColor = SKColor.red
                gameOverLabel.position = CGPoint(x: 0, y: -5)
                gameOverLabel.zPosition = 101
                gameOverLabel.name = "textOver"
                
                let quitButton = SKSpriteNode(imageNamed: "quit")
                quitButton.position = CGPoint(x: 0, y: -50)
                quitButton.size = CGSize(width: 50, height: 50)
                quitButton.zPosition = 101
                quitButton.name = "quitButton"
                isPaused = true
                
                menuBackground.addChild(gameOverLabel)
                menuBackground.addChild(quitButton)
                pauseOverlay?.addChild(menuBackground)
                if let pauseOverlay = pauseOverlay {
                    addChild(pauseOverlay)
                }
           
            }
        }
    
        override func update(_ currentTime: TimeInterval) {
            super.update(currentTime)
            checkForCollisions()
            
            // Cập nhật vị trí của track2 nếu cần thiết để đảm bảo liên tục
            if let track1 = track1, let track2 = track2 {
                if track1.position.y <= -track1.size.height {
                    track1.position.y = track2.position.y + track2.size.height
                }
                if track2.position.y <= -track2.size.height {
                    track2.position.y = track1.position.y + track1.size.height
                }
            }
        }
}

