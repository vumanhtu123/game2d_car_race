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

class GameScene: SKScene {
    
    private var track1: SKSpriteNode!
    private var track2: SKSpriteNode!
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?
    override func didMove(to view: SKView) {
            super.didMove(to: view)
            createRaceTrack()
            startTrackScrolling()
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
        
        override func update(_ currentTime: TimeInterval) {
            super.update(currentTime)
            
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

