class BoardFactoryImpl : BoardFactory {
    func makeBoard() -> protocol<Board, BoardState> {
        return BoardData()
    }
}

class BoardData: Board, BoardState {
    private let WIDTH=19
    private let HEIGHT=19
    
    var placedStones = [Int: Player]()
    
    func getWidth() -> Int {
        return WIDTH
    }
    func getHeight() -> Int {
        return HEIGHT
    }
    
    func stonesPlaced() -> Int {
        return placedStones.count
    }

    func place(column: Int, _ row: Int, _ player: Player) -> BoardError? {
        let (loc, error) = makeLocation(column, row)
        if (error != nil) {
            return error
        }
        if (placedStones[loc] != nil) {
            return .SpaceOccupied
        }
        placedStones[loc] = player
        return nil
    }
    func makeLocation(column: Int, _ row: Int) -> (Int, BoardError?)  {
        var error : BoardError?
        if row < 0 || row >= HEIGHT || column < 0 || column >= WIDTH {
            error = .BadLocation
        }
        return (column * WIDTH + row, error)
    }
    
    func get(column: Int, _ row: Int) -> (Player?, BoardError?) {
        let (loc, error) = makeLocation(column,row)
        if (error != nil) {
            return (nil, error)
        }
        
        if let stone = placedStones[loc] {
            return (stone, nil)
        }
        else {
            return (Player.Empty, nil)
        }
    }
}
