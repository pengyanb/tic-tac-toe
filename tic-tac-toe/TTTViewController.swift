//
//  TTTViewController.swift
//  tic-tac-toe
//
//  Created by Yanbing Peng on 14/06/16.
//  Copyright © 2016 Yanbing Peng. All rights reserved.
//

import UIKit

class TTTViewController: UIViewController {
    
    // MARK: - Constants and Variables
    let PLAYER_1_LABEL = "X"
    let PLAYER_2_LABEL = "O"
    
    var isPlayer1Turn = true
    
    let indexArrayToCheck = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    // MAKR: - Outlets
    @IBOutlet var labelCollection: [UILabel]!

    // MARK: - Target actions
    @IBAction func newGameButtonPressed(sender: AnyObject) {
        newGame()
    }
    
    
    @IBAction func viewTapped(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.locationInView(self.view)
        //print("view tapped at \(tapLocation)")
        var tapIndex = -1
        var label : UILabel? = nil
        for labelView in labelCollection{
            //print("Rect \(labelView.tag): \(labelView.frame)")
            if labelView.superview!.frame.contains(tapLocation){
                print("View \(labelView.tag) tapped")
                tapIndex = labelView.tag
                label = labelView
                break
            }
        }
        if let labelView = label{   //if identifies which UIlabel is tapped
            if tapIndex >= 0{       //and also have UIlabel's tag
                if labelView.text == ""{   //if this UILabel is still a available space
                    if isPlayer1Turn{       //if it is player1's turn
                        labelView.text = PLAYER_1_LABEL
                        self.title = "Player2 Turn" //player 2 turn next
                    }
                    else{                   //else it is player2's turn
                        labelView.text = PLAYER_2_LABEL
                        self.title = "Player1 Turn" //player 1 turn next
                    }
                    isPlayer1Turn = !isPlayer1Turn
                    resolveGameCompletionStatus()
                }
            }
        }
    }
    
    // MARK: - Private functions
    private func newGame(){
        self.title = "tic-tac-toe"
        isPlayer1Turn = true
        for labelView in labelCollection{
            labelView.text = ""
        }
    }
    
    private func resolveGameCompletionStatus(){
        var labelDictionary = [Int:UILabel]()
        var hasEmptySlot = false
        for labelView in labelCollection{
            labelDictionary[labelView.tag] = labelView
            if labelView.text == ""{
                hasEmptySlot = true
            }
        }
        var completed = false
        var winner = ""
        for indexArray in indexArrayToCheck{
            if (labelDictionary[indexArray[0]]!.text == labelDictionary[indexArray[1]]!.text) &&
                (labelDictionary[indexArray[1]]!.text == labelDictionary[indexArray[2]]!.text) &&
                (labelDictionary[indexArray[2]]!.text == PLAYER_1_LABEL){
                completed = true
                winner = "Player 1, you win!"
                break
            }
            else if (labelDictionary[indexArray[0]]!.text == labelDictionary[indexArray[1]]!.text) &&
                (labelDictionary[indexArray[1]]!.text == labelDictionary[indexArray[2]]!.text) &&
                (labelDictionary[indexArray[2]]!.text == PLAYER_2_LABEL){
                completed = true
                winner = "Player 2, you win!"
            }
        }
        if completed{ //if game is completed
            let alert = UIAlertController.init(title: "Congratulation", message: winner, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self] (action) in
                self?.newGame()
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{       //else if game not completed, but no more free slot
            if !hasEmptySlot{
                let alert = UIAlertController.init(title: "Draw", message: "No one wins", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self] (action) in
                    self?.newGame()
                    }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        newGame()
    }

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
