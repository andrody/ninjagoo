//
//  SceneManager.swift
//  Ninja Goo
//
//  Created by Andrew on 5/14/15.
//  Copyright (c) 2015 Koruja. All rights reserved.
//

import AVFoundation
import StoreKit

enum Sounds: String {
    
    //Music
    case menuMusic = "main-theme"
    
    
    //Sound Effects
    case click = "click1"
    case back = "menu_down.wav"
    case jump = "character_jump1.wav"
    case land = "character_land.wav"
    case spike = "impact2.wav"
    case fall = "impact.wav"
    case moveableWall = "shaking.wav"
    case endsLevel = "victory.wav"
    case portal = "teleport.wav"
    case tutorialAppears = "text_appear.wav"
    case tutorialLeave = "miss_text.wav"
    case buyLevelUnlock = "unlock"
    case passesLevelUnlock = "lockpick_success"

}


private let _SceneManagerSharedInstance = SceneManager()

class SceneManager : NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let sharedInstance = SceneManager()
    var audioPlayer = AVAudioPlayer()
    var scene : W1_Level_1!
    var gameViewCtrl : GameViewController!
    var gameCenter : GameCenter!
    var clickAudio : AVAudioPlayer!
    var backGroundMusic : AVAudioPlayer!
    var endLevel : Bool = false

    

    var soundMuted : Bool {
        get {
            var returnValue: Bool? = NSUserDefaults.standardUserDefaults().objectForKey("soundMuted") as? Bool
            if returnValue == nil //Check for first run of app
            {
                returnValue = false //Default value
            }
            return returnValue!
        }
        set (newValue) {
            SceneManager.sharedInstance.save("soundMuted", value: newValue)
        }
    }


    var keyId : String = "unlockkey"

    var fases = [Scenario]()
    var faseEscolhida : Scenario!
    
    override init(){
        super.init()
        loadFases()
        gameCenter = GameCenter()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)

    }
    
    
    func loadFases() {
    
        var faseOne = Scenario(nome: "minifase1",
            levelNumber: 1,
            corMontanha: [25,47,65],
            corMontanhaClara: [43, 80, 109],
            corNuvemBack: [25,165,166],
            corNuvemMeio: [41,191,192],
            corNuvemFront: [70,209,208],
            corPlataforma: [16,31,39],
            corFundo: [49,95,130],
            corWallEspecial: [43,147,202],
            backgroundFrontName: "montanha_branco",
            backgroundBackName : "montanha_branco",
            rank: Ranks.levelone,
            backgroundMusicName: "music1"
        )
                
        var faseTwo = Scenario(nome: "minifase2",
            levelNumber: 2,
            corMontanha: [0,160,3],
            corMontanhaClara: [119, 215, 0],
            corNuvemBack: [0,90,86],
            corNuvemMeio: [0,116,111],
            corNuvemFront: [0,157,150],
            corPlataforma: [16,31,39],
            corFundo: [191,231,231],
            corWallEspecial: [0,116,111],
            backgroundFrontName: "arvore_branco",
            backgroundBackName : "arvore_b_branco",
            rank: Ranks.leveltwo,
            backgroundMusicName: "rise-up"
        )
        
        
        
        var faseThree = Scenario(nome: "minifase3",
            levelNumber: 3,
            corMontanha: [178,0,103],
            corMontanhaClara: [214, 119, 174],
            corNuvemBack: [64,0,80],
            corNuvemMeio: [98,0,123],
            corNuvemFront: [124,0,155],
            corPlataforma: [16,31,39],
            corFundo: [227,201,234],
            corWallEspecial: [98,0,123],
            backgroundFrontName: "trapezio_branco",
            backgroundBackName : "trapezio_B_branco",
            rank: Ranks.levelthree,
            backgroundMusicName: "music3"

        )
        
        var faseFour = Scenario(nome: "minifase4",
            levelNumber: 4,
            corMontanha: [220,159,0],
            corMontanhaClara: [255, 185, 0],
            corNuvemBack: [164,82,0],
            corNuvemMeio: [222,111,0],
            corNuvemFront: [255,128,0],
            corPlataforma: [16,31,39],
            corFundo: [255,232,168],
            corWallEspecial: [222,111,0],
            backgroundFrontName: "morro_branco",
            backgroundBackName : "morro_B_branco",
            rank: Ranks.levelfour,
            backgroundMusicName: "Winding-Down"

        )
        
        var faseFive = Scenario(nome: "minifase5",
            levelNumber: 5,
            corMontanha: [0,139,134],
            corMontanhaClara: [144, 199, 196],
            corNuvemBack: [119,0,9],
            corNuvemMeio: [148,1,11],
            corNuvemFront: [242,1,18],
            corPlataforma: [16,31,39],
            corFundo: [228,233,130],
            corWallEspecial: [148,1,11],
            backgroundFrontName: "montanha_neve_branco",
            backgroundBackName : "montanha_neve_branco",
            rank: Ranks.levelfive,
            backgroundMusicName: "Exotic-Island"

        )
        
        var faseSix = Scenario(nome: "minifase6",
            levelNumber: 6,
            corMontanha: [0,64,99],
            corMontanhaClara: [0, 66, 102],
            corNuvemBack: [0,33,64],
            corNuvemMeio: [0,49,96],
            corNuvemFront: [0,86,167],
            corPlataforma: [16,31,39],
            corFundo: [0,120,185],
            corWallEspecial: [0,49,96],
            backgroundFrontName: "montanha_branco",
            backgroundBackName : "montanha_branco",
            rank: Ranks.levelsix,
            backgroundMusicName: "music6"

        )
        
        fases.append(faseOne)
        fases.append(faseTwo)
        fases.append(faseThree)
        fases.append(faseFour)
        fases.append(faseFive)
        fases.append(faseSix)

        
        loadAudio()
    }
    
    func playClickSound(name : String = "click"){
        
        if name == "click" {
            self.clickAudio.play()
        }
        else {
            // Load
            let soundURL = NSBundle.mainBundle().URLForResource(name, withExtension: "wav")
            
            var error:NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: &error)
            audioPlayer.play()
        }
    }
    
    func loadAudio(){
        
        // Load
        let soundURL = NSBundle.mainBundle().URLForResource("click", withExtension: "wav")
        // Load Music
        let mainThemeUrl = NSBundle.mainBundle().URLForResource("main-theme", withExtension: "wav")
        
        // Removed deprecated use of AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        self.clickAudio = AVAudioPlayer(contentsOfURL: soundURL, error: &error)
        
        self.backGroundMusic = AVAudioPlayer(contentsOfURL: mainThemeUrl, error: &error)
        self.backGroundMusic.volume = 0.2
        self.backGroundMusic.numberOfLoops = -1

    }
    
    func loadAudio(name : String) -> AVAudioPlayer {
        
        let music = NSBundle.mainBundle().URLForResource(name, withExtension: "wav")
        var error:NSError?
        
        let audio = AVAudioPlayer(contentsOfURL: music, error: &error)
        
        audio.volume = 0.2

        if(self.faseEscolhida.levelNumber == 6) {
            audio.volume = 0.4
        }
        
        if(self.faseEscolhida.levelNumber == 2) {
            audio.volume = 0.03
        }

        audio.numberOfLoops = -1
        return audio   
        
    }
    
    func playCaf(name : String){
        
        // Load
        let soundURL = NSBundle.mainBundle().URLForResource(name, withExtension: "caf")
     
        
        var error:NSError?
        let jump  = AVAudioPlayer(contentsOfURL: soundURL, error: &error)
        
        jump.play()
    }

    
    func playMusic(music : AVAudioPlayer) {
        
        if(!SceneManager.sharedInstance.soundMuted) {
        
            music.play()
        }
        else {
            music.stop()
        }
    }
    
    
    
    func save(key : String, value : AnyObject?) {
        
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func load(key : String) -> AnyObject? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }
    
    func unlockNextLevel() {
        var flag = false
        playClickSound(name: "unlock")

        
        for fase in fases {
            if(flag) {
                println("desbloqueaVEL fase \(fase.nome)")

                fase.unlockable = true
                flag = false
                break
            }

            if fase.unlockable && fase.locked {
                println("desbloqueado fase \(fase.nome)")
                fase.locked = false
                fase.unlockable = false
                flag = true
            }
        }
        
    }
    
    func buyKey(){
        println("About to fetch the products");
        // We check that we are allow to make the purchase.
        if (SKPaymentQueue.canMakePayments())
        {
            var productID:NSSet = NSSet(object: self.keyId);
            var productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>);
            productsRequest.delegate = self;
            productsRequest.start();
            println("Fething Products");
        }else{
            println("can't make purchases");
        }
    }
    
    // Helper Methods
    
    func buyProduct(product: SKProduct){
        println("Sending the Payment Request to Apple");
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment);
        
    }
    
    
    // Delegate Methods for IAP
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        println("got the request from Apple")
        var count : Int = response.products.count
        if (count>0) {
            var validProducts = response.products
            var validProduct: SKProduct = response.products[0] as! SKProduct
            if (validProduct.productIdentifier == self.keyId) {
                println(validProduct.localizedTitle)
                println(validProduct.localizedDescription)
                println(validProduct.price)
                buyProduct(validProduct);
            } else {
                println(validProduct.productIdentifier)
            }
        } else {
            println("nothing")
        }
    }
    
    
    func request(request: SKRequest!, didFailWithError error: NSError!) {
        println("La vaina fallo");
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!)    {
        println("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                    println("Product Purchased");
                    SceneManager.sharedInstance.unlockNextLevel()
                    NSNotificationCenter.defaultCenter().postNotificationName("unlockedLevel", object: nil)
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .Failed:
                    println("Purchased Failed");
                    NSNotificationCenter.defaultCenter().postNotificationName("hideLoad", object: nil)

                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
               // case .Restored:
                    //[self restoreTransaction:transaction];
                    //SKPaymentQueue.defaultQueue().restoreCompletedTransactions() RESTAURAÇÅO DE COMPRAS
                default:
                    break;
                }
            }
        }
        
    }

    
    
    
}