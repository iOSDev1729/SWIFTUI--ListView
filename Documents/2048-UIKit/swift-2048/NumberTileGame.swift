import UIKit

/// A view controller representing the swift-2048 game. It serves mostly to tie a GameModel and a GameboardView
/// together. Data flow works as follows: user input reaches the view controller and is forwarded to the model. Move
/// orders calculated by the model are returned to the view controller and forwarded to the gameboard view, which
/// performs any animations to update its state.
class NumberTileGameViewController : UIViewController, GameModelProtocol {
    
    // Protocol
    func scoreChanged(to score: Int) {
        if scoreView == nil {
            return
        }
        let s = scoreView!
        s.scoreChanged(to: score)
    }
    
    // How many tiles in both directions the gameboard contains
    var dimension: Int
    // The value of the winning tile. Can be incremented later on when the user gets there
    var threshold: Int
    
    var board: GameboardView?
    var model: GameModel?
    
    // Create the gameboard
    
    
    var scoreView: ScoreViewProtocol?
    
    let undoButton = UndoButton()
    
    let secondUndoButton = CustomButton(backgroundColour: .black, title: "Undo")
    
    // Width of the gameboard
    var boardWidth: CGFloat = UIScreen.main.bounds.width * 0.809
    
    // How much padding to place between the tiles
    let thinPadding: CGFloat = 3.0
    let thickPadding: CGFloat = 6.0

    lazy var padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
    lazy var v1 = boardWidth - padding*(CGFloat(dimension + 1))
    lazy var width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
    lazy var gameboard = GameboardView(dimension: dimension,
                                  tileWidth: width,
                                  tilePadding: padding,
                                  cornerRadius: 6,
                                  backgroundColor: UIColor.black,
                                  foregroundColor: UIColor.darkGray)
    
    //var gameboard = GameboardView(cornerRadius: 9)
    
    // Amount of space to place between the game and the stack view
    let viewPadding: CGFloat = 10.0
    
    init(dimension d: Int, startingTarget t: Int) {
        dimension = d > 2 ? d : 2
        threshold = t > 8 ? t : 8
        super.init(nibName: nil, bundle: nil)
        model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
        // TODO: Figure out how to change the system to only do iOS 13
        view.backgroundColor = UIColor.white
        setupSwipeControls()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func setupSwipeControls() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.upCommandFromSwipe(_:)))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.downCommandFromSwipe(_:)))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.leftCommandFromSwipe(_:)))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.rightCommandFromSwipe(_:)))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(rightSwipe)
    }
    
    // creates a board object and clears it? Dont know why it has to make a new object
    func clearBoard() {
        assert(board != nil)
        let b = board!
        b.clearBoard()
    }
    
    // View Controller
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupGame()
    }
    
    func reset() {
        assert(model != nil)
        let m = model!
        clearBoard()
        m.reset()
        startNewGame(with: m)
    }
    
    func startNewGame(with model: GameModel){
        model.insertTileAtRandomLocation(withValue: 2)
        model.insertTileAtRandomLocation(withValue: 2)
    }
    
    func setupGame() {
        
        let vcWidth = view.bounds.size.width
        
        // This nested function provides the x-position for a component view
        func xPositionToCenterView(_ v: UIView) -> CGFloat {
            let viewWidth = v.bounds.size.width
            let tentativeX = 0.5*(vcWidth - viewWidth)
            return tentativeX >= 0 ? tentativeX : 0
        }
        
        // Create the score view
        let scoreView = ScoreView(backgroundColor: UIColor.black,
                                  textColor: UIColor.white,
                                  font: UIFont.systemFont(ofSize: 16.0),
                                  radius: 6)
        scoreView.score = 0
        
        // Set up the frames
        configureGameboardView()
        //board?.putTilesOnBoard(boardWidth: board?.bounds.width)
        
        
        var f = scoreView.frame
        f.origin.x = xPositionToCenterView(scoreView)
        f.origin.y = 200
        scoreView.frame = f
        
        f = undoButton.frame
        f.origin.x = xPositionToCenterView(undoButton)
        f.origin.y = 100
        undoButton.addTarget(self, action: #selector(undoButtonAction), for: .touchUpInside)
        
        undoButton.frame = f
        
//        f = gameboard.frame
//        f.origin.x = xPositionToCenterView(gameboard)
//        f.origin.y = 0.5*(view.bounds.size.height - boardWidth)
//        gameboard.frame = f
        
        
        // Add to game state
        //view.addSubview(gameboard)
        board = gameboard
        view.addSubview(scoreView)
        self.scoreView = scoreView
        view.addSubview(undoButton)
        
        assert(model != nil)
        let m = model!
        //TODO: Move this to a function which checks to see if there has been any initialisation. Dont want to add new tiles if a user has already added tiles
        startNewGame(with: m)
    }
    
    func configureGameboardView() {
        view.addSubview(gameboard)
        gameboard.translatesAutoresizingMaskIntoConstraints = false
        
        let offSet: CGFloat = view.bounds.width * ((1 - 0.809)/2)
        
        NSLayoutConstraint.activate([
            gameboard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameboard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameboard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offSet),
            gameboard.heightAnchor.constraint(equalTo: self.view.widthAnchor, constant: (offSet * -2))
        ])
    }
    
    @objc func undoButtonAction() {
        model?.undoButtonHit()
    }
    
    func shakeTheButton() {
        undoButton.shakeButton()
    }
    
    // doubles the target when the user gets to a goal ie from 2048 to 4096
    func increaseTarget() {
        assert(model != nil)
        model!.threshold *= 2
    }
    
    // Misc
    func followUp() {
        assert(model != nil)
        let m = model!
        let (userWon, _) = m.userHasWon()
        if userWon {
            let alertController = UIAlertController(title: Strings.userWonTitle, message: Strings.userWonMessage, preferredStyle: .alert)
            //TODO: Actually implement the reset button
            alertController.addAction(UIAlertAction(title: Strings.alertReset, style: .destructive, handler: nil))
            alertController.addAction(UIAlertAction(title: Strings.alertContinue, style: .default, handler: {
            action in self.increaseTarget()}))
            self.present(alertController, animated: true)
            return
        }
        
        // Now, insert more tiles
        let randomVal = Int(arc4random_uniform(10))
        m.insertTileAtRandomLocation(withValue: randomVal == 1 ? 4 : 2)
        
        // At this point, the user may lose
        if m.userHasLost() {
            let alertController = UIAlertController(title: Strings.userLostTitle, message: Strings.userLostMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: Strings.alertReset, style: .destructive, handler: nil))
            alertController.addAction(UIAlertAction(title: Strings.alertUndo, style: .default, handler: {
            action in self.undoButtonAction()}))
            self.present(alertController, animated: true)
        }
    }
    
    // Commands from swipes
    @objc(up:)
    func upCommandFromSwipe(_ r: UIGestureRecognizer!) {
        upAction()
    }
    @objc(down:)
    func downCommandFromSwipe(_ r: UIGestureRecognizer!) {
        downAction()
    }
    @objc(left:)
    func leftCommandFromSwipe(_ r: UIGestureRecognizer!) {
        leftAction()
    }
    @objc(right:)
    func rightCommandFromSwipe(_ r: UIGestureRecognizer!) {
        rightAction()
    }
    
    // Allows control of the game via the keyboard.
    // Super useful for testing and when playing on a device with a physical keyboard
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let key = presses.first?.key else { return }
        
        switch key.keyCode {
        case .keyboardUpArrow:
            upAction()
        case .keyboardDownArrow:
            downAction()
        case .keyboardLeftArrow:
            leftAction()
        case .keyboardRightArrow:
            rightAction()
        case .keyboardDeleteOrBackspace:
            undoButtonAction()
        default:
            super.pressesBegan(presses, with: event)
        }
    }
    
    // functions to perform actions based on directional input.
    // I made them all into functions to make it more usable
    // They were previously in the functions for swipe inputs
    func downAction() {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.down,
                    onCompletion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
        })
    }
    func upAction() {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.up,
                    onCompletion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
        })
    }
    func leftAction() {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.left,
                    onCompletion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
        })
    }
    func rightAction() {
        assert(model != nil)
        let m = model!
        m.queueMove(direction: MoveDirection.right,
                    onCompletion: { (changed: Bool) -> () in
                        if changed {
                            self.followUp()
                        }
        })
    }
    
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
        assert(board != nil)
        let b = board!
        b.moveOneTile(from: from, to: to, value: value)
    }
    
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        assert(board != nil)
        let b = board!
        b.moveTwoTiles(from: from, to: to, value: value)
    }
    
    func insertTile(at location: (Int, Int), withValue value: Int) {
        assert(board != nil)
        let b = board!
        b.insertTile(at: location, value: value)
    }
}
