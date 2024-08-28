import Foundation

struct PlayerScore: Codable {
    let name: String
    let score: Int
}

func saveLeaderboard(leaderboard: [PlayerScore]) {
    let defaults = UserDefaults.standard
    
    if let encodedData = try? JSONEncoder().encode(leaderboard) {
        defaults.set(encodedData, forKey: "leaderboard")
    }
}

func loadLeaderboard() -> [PlayerScore]? {
    let defaults = UserDefaults.standard
    
    if let savedData = defaults.data(forKey: "leaderboard") {
        if let decodedLeaderboard = try? JSONDecoder().decode([PlayerScore].self, from: savedData) {
            return decodedLeaderboard
        }
    }
    return nil
}
