//
//  GameScene.swift
//  Pong
//
//  Created by Summer Long on 5/20/20.
//  Copyright © 2020 Summer Long. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    var ball = SKSpriteNode()
    var Main = SKSpriteNode()
    var Enemy = SKSpriteNode()
    
    var ELabel = SKLabelNode()
    var MLabel = SKLabelNode()
    
    var Score = [Int]()
    
    override func didMove(to view: SKView) {
        
        BeginGame()
        
        ELabel = self.childNode(withName: "EnemyLabel") as! SKLabelNode
        MLabel = self.childNode(withName: "MainLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        Main = self.childNode(withName: "Main") as! SKSpriteNode
        Enemy = self.childNode(withName: "Enemy") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let frame = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        frame.friction = 0
        frame.restitution = 1
        self.physicsBody = frame
    }
    
    func BeginGame(){
        Score = [0,0]
        ELabel.text = "\(Score[1])"
        MLabel.text = "\(Score[0])"
    }
    func addScore(Winner : SKSpriteNode){
        
        ball.position = CGPoint(x:0, y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if Winner == Main {
            Score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if Winner == Enemy{
            Score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        ELabel.text = "\(Score[1])"
        MLabel.text = "\(Score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            Main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
            Enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1))
        
        if ball.position.y <= Main.position.y - 70 {
            addScore(Winner: Enemy)
        }
        else if ball.position.y >= Enemy.position.y + 70 {
            addScore(Winner: Main)
        }
    }
}

