import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    
    
    var scene: GameScene!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the view
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure scne
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //Present Scene
        skView.presentScene(scene)
        
        
        /*
        if let scene = GameScene(fileNamed:"GameScene") {
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        }*/
    }
    /*
    override func viewWillLayoutSubviews() {
    let bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("bgmusic", withExtension: "mp3")!
    do{
    try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL)
    }
    catch{
    print(error)
    }
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
    
    let skView:SKView = self.view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    
    let scene:SKScene = GameScene(size:skView.bounds.size)
    scene.scaleMode = SKSceneScaleMode.AspectFill
    skView.presentScene(scene)
    }
    */
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
