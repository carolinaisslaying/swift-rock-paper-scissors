import Foundation

print("""
    Welcome to Rock, Paper, Scissors!
    
    This is a simple CLI game built in Swift by Carolina Mitchell (github.com/carolinaisslaying).
    
    To exit the game, please type 'exit' in the terminal at any time.
    
    ———
    """)

var score: Dictionary<String, Int> = [
    "wins": 0,
    "losses": 0,
    "ties": 0
]

// Enum for each of the available actions the user can perform in the CLI.
enum Action: Int, CaseIterable {
    case rock
    case paper
    case scissors
    case exit
    
    // Converts user-input from string to enum.
    static func from (_ string: String) -> Action? {
        switch string.lowercased() {
        case "rock": return .rock
        case "paper": return .paper
        case "scissors": return .scissors
        case "exit": return .exit
        default: return nil
        }
    }
    
    // Allows to reference the string name for an enum.
    var name: String {
        switch self {
        case .rock: return "rock"
        case .paper: return "paper"
        case .scissors: return "scissors"
        case .exit: return "exit"
        }
    }
}

// Defines ASCII colours to allow for setting colours in print() using Colours.red + ...
struct Colours {
    static let reset = "\u{001B}[0;0m"
    static let black = "\u{001B}[0;30m"
    static let red = "\u{001B}[0;31m"
    static let green = "\u{001B}[0;32m"
    static let yellow = "\u{001B}[0;33m"
    static let blue = "\u{001B}[0;34m"
    static let magenta = "\u{001B}[0;35m"
    static let cyan = "\u{001B}[0;36m"
    static let white = "\u{001B}[0;37m"
}

// Establishes a clear input function, similar to Python's input(), to reduce duplication.
func input (_ prompt: String) -> String {
    print(prompt, terminator: " ")
    return readLine() ?? ""
}

// Main round logic; randomly generates the computer's decision and determins the winner.
func playRound (_ userAction: Action) {
    let computerDecision = Action(rawValue: Int.random(in: 0..<3))!
    
    print("Computer chose '\(computerDecision.name)'")
    
    if userAction == .rock && computerDecision == .scissors
        || userAction == .rock && computerDecision == .paper
        || userAction == .scissors && computerDecision == .paper {
        
        print(Colours.green + "Computer says no. You win! \(userAction) beats \(computerDecision)." + Colours.reset)
        
        score["wins", default: 0] += 1
    } else if userAction == computerDecision {
        print(Colours.magenta + "Awkward. It's a tie!" + Colours.reset)
        
        score["ties", default: 0] += 1
    } else {
        print(Colours.red + "Computer is happy. You lose! \(computerDecision) beats \(userAction)." + Colours.reset)
        
        score["losses", default: 0] += 1
    }
}

func exitGame() {
    print("———")
    
    print("""
        Your scores:
            \(Colours.green)
            - \(score["wins"] ?? 0) win(s)
            \(Colours.magenta)
            - \(score["ties"] ?? 0) tie(s)
            \(Colours.red)
            - \(score["losses"] ?? 0) loss(es)
            
        \(Colours.cyan)Goodbye! \(Colours.reset)
        """)
}

// Main game logic. Accepts user input, performs error handling to ensure input is valid, handles game exit logic and calls main round logic if no errors and user does not wish to exit the game.
while true {
    let userAction = input("Your turn! Rock, paper, or scissors?").lowercased()
    
    guard let userAction = Action.from(userAction) else {
        print(Colours.yellow + "That is an invalid response! Please respond with either, rock, paper, or scissors. If you want to exit the game, type 'exit'." + Colours.reset)
        continue
    }
    
    if userAction == .exit {
        exitGame()
        break
    } else {
        playRound(userAction)
    }
    
    print("———")
}
