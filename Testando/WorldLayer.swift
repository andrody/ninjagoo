//
//  WorldLayer.swift
//  Testando
//
//  Created by Jose Mauricio Barroso Monteiro Junior on 21/03/15.
//  Copyright (c) 2015 Jose Mauricio Barroso Monteiro Junior. All rights reserved.
//

import UIKit
import SpriteKit




class WorldLayer: SKNode {
    

    //Arrays of backgrounds
    var backgroundsTree = [SKNode]()
    var backgroundsMountain = [SKNode]()
    var backgroundsCloud = [SKNode]()
    
    //Array of platformers
    var platform = [SKNode]()
    
    //Floor
    var floor = SKSpriteNode()
    
    //Camera
    let camera = SKNode()
    
    //Platformer layer
    let platformerLayer = SKNode()

    //Actions
//    let moveTrees: SKAction
//    let moveMountins: SKAction
//    let moverClouds: SKAction
    
    let sizeOfScene: CGSize

    
    init(sceneSize: CGSize){
        
        self.sizeOfScene = sceneSize
        
        super.init()
        
        self.addChild(platformerLayer)
        self.addChild(camera)
 
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startNewWorld(#stageName: String){
        
        self.floor = self.generateFloor(stageName)
        self.addChild(self.floor)
        
        //Gerar 3 backgrounds de cada onde a posicao do proximo comeca no fim da anterior
        var posicaoX: CGFloat = 0.0
        var posicaoY: CGFloat = 0.0
        
        for(var i = 0 ; i < 100 ; i++){
            
            self.backgroundsTree.append( self.generateBackgroundTree(stageName, atPosition: CGPoint(x: posicaoX, y: posicaoY) ) )
                
            self.backgroundsMountain.append( self.generateBackgroundMountain(stageName, atPosition: CGPoint(x: posicaoX, y: posicaoY) ) )
            
            self.backgroundsCloud.append( self.generateBackgroundCloud(stageName, atPosition: CGPoint(x: posicaoX, y: posicaoY) ) )
            
            self.addChild( self.backgroundsTree[i])
            self.addChild( self.backgroundsMountain[i])
            self.addChild( self.backgroundsCloud[i])
            
            posicaoX = posicaoX + self.sizeOfScene.width

        }
        
        self.generatePlatform(stageName)

    }
    
    func deleteWorld(){
        
//        NSObject.cancelPreviousPerformRequestsWithTarget(background)
//        background.physicsBody = nil
//        background.removeFromParent()
        
        //Delete backdrounds
        var deleteBackground: SKNode?
        var deleteFloor: SKSpriteNode
        
        while( self.backgroundsTree.count > 0){
            
            deleteBackground = self.backgroundsTree[0]
            NSObject.cancelPreviousPerformRequestsWithTarget(deleteBackground!)
            deleteBackground!.removeFromParent()
            deleteBackground = nil
            self.backgroundsTree.removeAtIndex(0)
            
            deleteBackground = self.backgroundsMountain[0]
            NSObject.cancelPreviousPerformRequestsWithTarget(deleteBackground!)
            deleteBackground!.removeFromParent()
            deleteBackground = nil
            self.backgroundsMountain.removeAtIndex(0)
            
            deleteBackground = self.backgroundsCloud[0]
            NSObject.cancelPreviousPerformRequestsWithTarget(deleteBackground!)
            deleteBackground!.removeFromParent()
            deleteBackground = nil
            self.backgroundsCloud.removeAtIndex(0)


        }
        
        deleteFloor = self.floor
        
        NSObject.cancelPreviousPerformRequestsWithTarget(deleteFloor)
        deleteFloor.removeFromParent()
        
        
    }
    
    func generateBackgroundTree(stageName: String , atPosition: CGPoint) -> SKNode {
        
        
        let background = SKNode()
        let texture = SKTexture(imageNamed: "\(stageName)Tree")
        
        var numberOfObjects = (Int8)(1 + arc4random() % 10)
        var maxDistanceX: UInt32
        var sortedScale: CGFloat
    
        background.position = atPosition
        background.zPosition = -1
        
        for(var i:Int8 = numberOfObjects ; i >= 0 ; i--){
            
            //Sort Scale
            sortedScale = (CGFloat) ( 3 + arc4random() % 4 ) / 10
            
            let node = SKSpriteNode(texture: texture)
            node.name = "backgroundTree"
            node.anchorPoint = CGPoint(x: 0, y: 0)
            node.zPosition = background.zPosition
            node.setScale(sortedScale)
            
            maxDistanceX = (UInt32)(self.sizeOfScene.width - node.size.width)
            
            node.position.y = 101
            node.position.x = CGFloat( arc4random() % maxDistanceX)
            
            background.addChild(node)
        }
        
        return background
        
    }
    
    func generateBackgroundMountain(stageName: String , atPosition: CGPoint) -> SKNode {
        
        
        let background = SKNode()
        let texture = SKTexture(imageNamed: "\(stageName)Mountain")
        
        var numberOfObjects = (Int8)(1 + arc4random() % 4)
        var maxDistance: UInt32
        var sortedScale: CGFloat
        
        background.position = atPosition
        background.zPosition = -2
        
        for(var i:Int8 = numberOfObjects ; i >= 0 ; i--){
            
            //Sort Scale
            sortedScale = (CGFloat) ( 3 + arc4random() % 4 ) / 10
            
            let node = SKSpriteNode(texture: texture)
            node.name = "backgroundMountain"
            node.anchorPoint = CGPoint(x: 0, y: 0)
            node.zPosition = background.zPosition
            node.setScale(sortedScale)
            
            maxDistance = (UInt32)(self.sizeOfScene.width - node.size.width)
            
            node.position.y = 101
            node.position.x = CGFloat( arc4random() % maxDistance)
            
            background.addChild(node)
        }
        
        return background
        
    }
    
    func generateBackgroundCloud(stageName: String , atPosition: CGPoint) -> SKNode {
        
        
        let background = SKNode()
        let texture = SKTexture(imageNamed: "\(stageName)Cloud")
        
        var numberOfObjects = (Int8)(1 + arc4random() % 5)
        var maxDistanceX: UInt32
        var maxDistanceY: UInt32
        var minDistanceY: UInt32 = 300
        var sortedScale: CGFloat
        
        background.position = atPosition
        background.zPosition = -3
        
        for(var i:Int8 = numberOfObjects ; i >= 0 ; i--){
            
            //Sort Scale
            sortedScale = (CGFloat) ( 3 + arc4random() % 4 ) / 10
            
            let node = SKSpriteNode(texture: texture)
            node.name = "backgroundTree"
            node.anchorPoint = CGPoint(x: 0, y: 0)
            node.zPosition = background.zPosition
            node.setScale(sortedScale)
            
            maxDistanceX = (UInt32)(self.sizeOfScene.width - node.size.width)
            maxDistanceY = (UInt32)(self.sizeOfScene.height - node.size.height)

            node.position.x = CGFloat( arc4random() % maxDistanceX)
            node.position.y = CGFloat(minDistanceY + arc4random() % maxDistanceY)

            
            background.addChild(node)
        }
        
        return background
        
    }
    
    func generatePlatform(stageName: String) -> SKNode{
        
        let platformerLayer = SKNode()
        let scale = CGFloat(0.3)
        let walls = RandomGenerator.getWalls(quantity: 10)
        var positionX = CGFloat(500)
        var positionY: CGFloat
        
        
        
        for node in walls{
            
            let wallNode = SKNode()
            wallNode.setScale(scale)
            
            for (var i = 0; i <= node.height ; i++ ) {
            
                let blockNode = SKSpriteNode(texture: SKTexture(imageNamed: "textura"))
                blockNode.anchorPoint = CGPoint(x: 0.5, y: 0)
                
                blockNode.physicsBody = SKPhysicsBody(rectangleOfSize: blockNode.size, center: CGPoint(x:0, y: blockNode.size.height/2))
                blockNode.physicsBody?.dynamic = false
                blockNode.physicsBody?.affectedByGravity = false
                
                // println("\(node.distance)")
                
                //if(node.direction == 1){
                    
                    //blockNode.zRotation = degreesToRadians(90)
                  //  positionY = self.sizeOfScene.height - blockNode.size.height * CGFloat(i)
                    
                    
                //}
                //else{
                    
                    //blockNode.zRotation = degreesToRadians(-90)
                    
                    
                //}
                
                positionY = blockNode.size.height * CGFloat(i)
                
                
                blockNode.position = CGPoint(x: positionX, y: positionY )
                
                wallNode.addChild(blockNode)
            }
            
            var wallPositionY : CGFloat
            
            if(node.direction == 1){
                
                positionY = self.sizeOfScene.height - CGFloat(node.height) * CGFloat(233) * scale
                
                
            }
            else{
                
                positionY = 0
                
            }
            
            wallNode.position = CGPoint(x: positionX, y: positionY )

            
            positionX = positionX + CGFloat(node.distance)

            
            
            self.platformerLayer.addChild(wallNode)
            
        }
        
        
        return platformerLayer
        
    }
    
    func degreesToRadians(degrees : CGFloat) -> CGFloat {
        return CGFloat(degrees * CGFloat(M_PI) / 180)
    }
    
    func generateFloor(stageName: String) -> SKSpriteNode{
        
        let floor = SKSpriteNode(texture: SKTexture(imageNamed: "\(stageName)Floor"))
        
        floor.anchorPoint = CGPointZero
        floor.position = CGPointZero
        floor.setScale(0.5)

        
        //TESTE
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: floor.size.width, height: 10), center: CGPoint(x: floor.size.width / 2 , y: floor.size.height))
        floor.physicsBody?.dynamic = false
        floor.physicsBody?.affectedByGravity = false
        
        return floor

    }
    
    //TEST
    func move(#amountToMoveX: CGFloat , amountToMoveY: CGFloat , withPoring: Bool){
        
        
        
        
    }
    
    
    func moveWorld(#amountTomove: CGFloat , withPoring: Bool){
        
        let moveTrees = SKAction.moveBy(CGVector(dx: amountTomove, dy: 0), duration: 1)
        let moveMountains = SKAction.moveBy(CGVector(dx: amountTomove + 30, dy: 0), duration: 1)
        let moveClounds = SKAction.moveBy(CGVector(dx: amountTomove , dy: 0), duration: 1)
        let movePoringLayer = SKAction.moveBy(CGVector(dx: amountTomove * -1 , dy: 0), duration: 1)
        
        for node in self.backgroundsTree{
            
            node.removeAllActions()
            node.runAction(moveTrees, withKey: "moveTree")
        }
        
        for node in self.backgroundsMountain{
            
            node.removeAllActions()
            node.runAction(moveMountains)
        }
        
        for node in self.backgroundsCloud{
            
            node.removeAllActions()
            node.runAction(moveClounds)
        }
        
        
       // self.platformerLayer.runAction(moveTrees)

        

        

 
    }
    
}
