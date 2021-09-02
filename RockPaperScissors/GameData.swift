//
//  GameData.swift
//  RockPaperScissors
//
//  Created by Baptiste Cadoux on 02/09/2021.
//

import Foundation

enum GameData: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"

    enum ResultType {
        case win
        case lose
        case draw
    }

    func getResult(counterMove: GameData) -> ResultType {
        switch self {
        case .rock:
            return didRockWinAgainst(counterMove)
        case .paper:
            return didPaperWinAgainst(counterMove)
        case .scissors:
            return didScissorsWinAgainst(counterMove)
        }
    }

    private func didRockWinAgainst(_ counterMove: GameData) -> ResultType {
        switch counterMove {
        case .rock:
            return .draw
        case .paper:
            return .lose
        case .scissors:
            return .win
        }
    }

    private func didPaperWinAgainst(_ counterMove: GameData) -> ResultType {
        switch counterMove {
        case .rock:
            return .win
        case .paper:
            return .draw
        case .scissors:
            return .lose
        }
    }

    private func didScissorsWinAgainst(_ counterMove: GameData) -> ResultType {
        switch counterMove {
        case .rock:
            return .lose
        case .paper:
            return .win
        case .scissors:
            return .draw
        }
    }
}
