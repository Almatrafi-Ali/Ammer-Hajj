//
//  itemList.swift
//  speechPrac
//
//  Created by Ali on 20/11/1439 AH.
//  Copyright © 1439 정기웅. All rights reserved.
//

import Foundation
import SceneKit

class itemList {
    
    //   var chosenItem = SCNNode()
    //  var myItem = itemList()
    
    func addChair() -> SCNNode {
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        
        let nodeArray = scene!.rootNode.childNodes
        for chilNode in nodeArray{
            node.addChildNode(chilNode as SCNNode)
            
        }
        
        return node
    }
    
    //==================
    func addCup() -> SCNNode {
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/Cup/cup.dae")
        
        let nodeArray = scene!.rootNode.childNodes
        for chilNode in nodeArray{
            node.addChildNode(chilNode as SCNNode)
            
        }
        
        return node
    }
    //==================
    func addLamp() -> SCNNode {
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/k1/k1.dae")
        
        let nodeArray = scene!.rootNode.childNodes
        for chilNode in nodeArray{
            node.addChildNode(chilNode as SCNNode)
            
        }
        
        return node
    }
    //==================
    func addTable() -> SCNNode {
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/table")
        
        let nodeArray = scene!.rootNode.childNodes
        for chilNode in nodeArray{
            node.addChildNode(chilNode as SCNNode)
            
        }
        
        return node
    }
    //=====
    func addVase() -> SCNNode {
        
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/vase.dae")
        
        let nodeArray = scene!.rootNode.childNodes
        for chilNode in nodeArray{
            node.addChildNode(chilNode as SCNNode)
            
        }
        
        return node
    }
}
