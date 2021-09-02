//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Baptiste Cadoux on 02/09/2021.
//

import SwiftUI

struct ContentView: View {

    @State private var playerMove = GameData.paper
    @State private var opponentMove: GameData?
    @State private var roundResultText = ""
    @State private var turnsLeft = 10
    @State private var scores = [0, 0]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Text("PICK ONE")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                VStack(spacing: 7.5) {
                    ForEach(GameData.allCases, id: \.self) { data in
                        Button(data.rawValue) {
                            playerMove = data
                        }
                        .frame(width: 120, height: 40)
                        .font(.title2)
                        .background(playerMove == data ? Color.red : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }

                VStack(spacing: 10) {
                    Text(getTurnText())
                    Text(roundResultText)
                        .font(.title2)
                }
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()

                Button(isGameFinished() ? "RESET" : "PLAY") {
                    if isGameFinished() {
                        resetGame()
                    } else {
                        checkTurnResult()
                    }
                }
                .frame(width: 120, height: 45)
                .font(.title)
                .background(Color.green)
                .clipShape(Capsule())
                .foregroundColor(.white)

                VStack {
                    Text("Score\n\(scores[0]) <-> \(scores[1])")
                        .bold()
                        .padding()
                        .multilineTextAlignment(.center)
                    Text("Turns left: \(turnsLeft)/10")
                }
                .font(.title3)

                if isGameFinished() {
                    Text(getFinalScoreText())
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    func isGameFinished() -> Bool {
        return turnsLeft == 0
    }

    func checkTurnResult() {
        opponentMove = GameData.allCases.randomElement()
        let result = playerMove.getResult(counterMove: opponentMove!)

        switch result {
        case .win:
            scores[0] += 1
        case .lose:
            scores[1] += 1
        case .draw:
            break
        }

        setRoundResultText(result)
        turnsLeft -= 1
    }

    func resetGame() {
        turnsLeft = 10
        opponentMove = .none
        scores = [0, 0]
    }


    // MARK: - Text

    func setRoundResultText(_ result: GameData.ResultType) {
        switch result {
        case .win:
            roundResultText = "You won this round."
        case .lose:
            roundResultText = "He won this round."
        case .draw:
            roundResultText = "Draw!"
        }
    }

    func getTurnText() -> String {
        if let opponentMove = opponentMove {
            return "Your opponent choose:\n\(opponentMove.rawValue)"
        } else {
            return "The game will start as soon as you press play."
        }
    }

    func getFinalScoreText() -> String {
        if scores[0] == scores[1] {
            return "Draw game 😐"
        } else if scores[0] > scores[1]{
            return "Good job!\nYou win this game 😁"
        } else {
            return "Sad!\nYou lose this game 😱"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
