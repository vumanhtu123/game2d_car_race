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
            leaderboard = []
        }
        
        setupLeaderboard()
    }
    
    func setupLeaderboard() {
        let leaderboardView = UIView()
        let scrollView = UIScrollView(frame: view.bounds)
        let contentView = UIView()
        
        let labelHeight: CGFloat = 40
        let startY: CGFloat = 10
        let padding: CGFloat = 20
        
        // Giả sử `leaderboard` là mảng các đối tượng Player với thuộc tính `score`
        let sortedLeaderboard = leaderboard.sorted(by: { $0.score > $1.score })
        
        var yPos: CGFloat = startY
        for (index, player) in sortedLeaderboard.enumerated() {
            let label = UILabel(frame: CGRect(x: padding, y: yPos, width: view.frame.width - 2 * padding, height: labelHeight))
            label.text = "\(index + 1). \(player.name) - \(player.score) points"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = UIColor.black
            
            contentView.addSubview(label)
            yPos += labelHeight
        }
        
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: yPos)
        scrollView.contentSize = contentView.frame.size
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
}
