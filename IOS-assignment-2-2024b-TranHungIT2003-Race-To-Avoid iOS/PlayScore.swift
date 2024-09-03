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
