import UIKit
import SpriteKit
import GameplayKit

class LeaderboardViewController: UIViewController {
    
    var leaderboard: [PlayerScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        // Lấy dữ liệu từ UserDefaults
        if let savedLeaderboard = loadLeaderboard() {
            leaderboard = savedLeaderboard
        } else {
            // Nếu không có dữ liệu, bạn có thể khởi tạo dữ liệu mẫu
            leaderboard = [
                PlayerScore(name: "John", score: 100),
                PlayerScore(name: "Jane", score: 95),
                PlayerScore(name: "Alex", score: 80)
            ]
        }
        
        setupLeaderboard()
    }
    
    func setupLeaderboard() {
        let leaderboardView = UIView()
        let labelHeight: CGFloat = 40
        let startY: CGFloat = 100
        
        for (index, player) in leaderboard.enumerated() {
            let yPos = startY + CGFloat(index) * labelHeight
            
            let label = UILabel(frame: CGRect(x: 20, y: yPos, width: view.frame.width - 40, height: labelHeight))
            label.text = "\(index + 1). \(player.name) - \(player.score) points"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18)
            
            view.addSubview(label)
        }
        
    }
}
