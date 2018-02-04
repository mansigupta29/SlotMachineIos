//Slot Machine Game
// Version 1.1
// Team Members
//Mansi Gupta (300969816)
//Abhinav Sharma (3009)
// This is a simple Slot Machine Game
// Date: 4 Feb 2017


import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {


    /*--- Some pre declared variables ---*/
    var playerMoney:Int = 1000
    var playerBet: Int = 10
    var jackpot:Int = 5000
    var winnings:Int = 0
    var component1: Int = 0
    var component2: Int = 0
    var componenet3: Int = 0
    
    
  /*--- Outlets ---*/
    
    /*--- 3 components of reels ---*/
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var picker3: UIPickerView!

    /*labels, textfield and button for UI ---*/
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var jackpotLbl: UILabel!
    @IBOutlet weak var playerMoneyLbl: UILabel!
    @IBOutlet weak var spinBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var quitBtn: UIButton!
    @IBOutlet weak var playerBetTxt: UITextField!
    

    /*--- to show number of component per picker ---*/
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*--- number of rows per picker ---*/
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 200
    }
    
    /*--- row height of each picker ---*/
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 60.0
        
    }
    
    /*--- width of each picker ---*/
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60.0
    }
    
    /*--- to generate random number ---*/
    func randomNumber() -> Int {
        let lower : UInt32 = 20
        let upper : UInt32 = 150
        let randomNumber = arc4random_uniform(upper - lower) + lower
        
        return Int(arc4random_uniform(UInt32(randomNumber)))+5
    }
    
    /*--- reels with 7 images and 200 rows for spinning ---*/
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        /*--- view for each picker ---*/
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 60))
        
        /* image view ---*/
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        var Banana:Int=0
        var Grape:Int=1
        var Strawberry:Int=2
        var Orange:Int=3
        var Bell:Int=4
        var Seven:Int=5
        var Apple:Int=6
        
        /* to create multiple rows of same image for spinning effect more visible */
        for _ in 6 ... 200 {
            Apple=Apple+7
        
     
        switch row {
   
        case Banana:
             myImageView.image = UIImage(named:"Banana.png")
            
            
        case Grape:
             myImageView.image = UIImage(named:"Grape.png")
            
        case Strawberry:
            myImageView.image = UIImage(named:"Strawberry.png")
            
        case Orange:
            myImageView.image = UIImage(named:"Orange.jpg")
            
        case Bell:
            myImageView.image = UIImage(named:"Bell.png")
            
        case Seven:
            myImageView.image = UIImage(named:"Seven.jpg")
            
        default :
            myImageView.image = UIImage(named:"Apple.png")
            Banana=Banana+7
            Grape=Grape+7
            Strawberry=Strawberry+7
            Orange=Orange+7
            Bell=Bell+7
            Seven=Seven+7
      
        }
        }

        /*--- setting image view inside picker view ---*/
        myView.addSubview(myImageView)
        
        
        return myView
    }
    
  
    
    /*--- function for spinning the reel ---*/
    @IBAction func spin(_ sender: AnyObject) {
        
        spinBtn.isHidden=false
         playerBet =  NumberFormatter().number(from: playerBetTxt.text!) as! Int
        
    
    if playerBet > playerMoney && playerMoney != 0{
        resultLabel.text = "You don't have enough Money to place that bet."
    }
    else if (playerBet < 0) {
        resultLabel.text = "All bets must be a positive $ amount."
    }
    else if playerMoney == 0
    {
        resultLabel.text="You ran out of Money! Do you want to play again?"
        playerMoneyLbl.text="Player Money : 0"
        spinBtn.isHidden=true
    }else if playerBet == 0 {
        resultLabel.text="Please enter a valid bet amount"
        }else if playerBet <= playerMoney
        {
            resultLabel.text=""
            picker.selectRow((randomNumber()) , inComponent: 0, animated: true)
            picker2.selectRow((randomNumber()) , inComponent: 0, animated: true)
            picker3.selectRow((randomNumber()) , inComponent: 0, animated: true)
            determineWinnings();
        }
   
  }

    /*--- Utility function to reset the state of game ---*/
    @IBAction func reset(_ sender: AnyObject) {
       
       
        playerMoneyLbl.text="Player Money : 1000 "
        playerBetTxt.text = "10"
        jackpotLbl.text = "Jackpot : 5000"
        resultLabel.text="Best Of Luck!"
        spinBtn.isHidden=false
        quitBtn.isHidden = false
        
        playerMoney = 1000
        jackpot = 5000
        playerBet = 10
        winnings = 0
    
    }
    
    /*--- Function to quit the game. ---*/
    @IBAction func quit(_ sender: AnyObject) {
        exit(0)
    }
    
    
    /*--- Utility function to show a win message and increase player money ---*/
    func showWinMessage() {
        playerMoney += winnings
            resultLabel.text = "You Won: $\(winnings)"
        playerMoneyLbl.text="Player Money : \(playerMoney)"
        checkJackPot()
    }

    /*--- Utility function to show a loss message and reduce player money ---*/
    func showLossMessage() {
        playerMoney -= playerBet
        resultLabel.text = "You Lost! $\(playerBet)"
          playerMoneyLbl.text="Player Money : \(playerMoney)"
    }
    
    /*--- Check to see if the player won the jackpot ---*/
    func checkJackPot() {
        
        /*--- To get the image of each picker ---*/
        component1 = picker.selectedRow(inComponent: 0)
        component2 = picker2.selectedRow(inComponent: 0)
        componenet3 = picker3.selectedRow(inComponent: 0)
        
        if(component1>6){
            component1 = component1%7
        }
        if(component2>6){
            component2 = component2%7
        }
        if(componenet3>6){
            componenet3 = componenet3%7
        }
        
        /*--- Condition to win jackpot ---*/
         if (component1 == component2 && component2 == componenet3  ){
                if (component1 == 5 && component2 == 5 && componenet3 == 5) || (component1 == 6 && component2 == 6 && componenet3 == 6) {
                    resultLabel.text = "You Won the $\(jackpot) Jackpot"
                playerMoney += jackpot
                playerMoneyLbl.text="Player Money : \(playerMoney)"
                jackpotLbl.text = "Jackpot : 1000"
                jackpot = 1000
                }
            }
        }
    
    /*--- Utility function to decide result of spin is win or lose ---*/
    func determineWinnings()
    {
        /*--- To get the image of each picker ---*/
        component1 = picker.selectedRow(inComponent: 0)
        component2 = picker2.selectedRow(inComponent: 0)
        componenet3 = picker3.selectedRow(inComponent: 0)
        
        if(component1>6){
            component1 = component1%7
        }
        if(component2>6){
            component2 = component2%7
        }
        if(componenet3>6){
            componenet3 = componenet3%7
        }
         winnings = 0
        /*--- if three images are same ---*/
        if (component1 == component2 && component2 == componenet3  ){
            if component1 == 0
            {
                print("banana")
                winnings = playerBet * 3
            }
            else if component1 == 1 {
                print("grapes")
                winnings = playerBet * 5
            }
            else if component1 == 2 {
                print("strawbery")
                winnings = playerBet * 7
            }
            else if component1 == 3 {
                print("orange")
                winnings = playerBet * 9
            }
            else if component1 == 4 {
                print("bell")
                winnings = playerBet * 10
            }
            else if component1 == 5 {
                print("seven")
                winnings = playerBet * 15
            }
            else if component1 == 6 {
                print("apple")
                winnings = playerBet * 2
            }
            showWinMessage()
        
            
        }
            /*--- if two images are same ---*/
        else if (component1 == component2 || component1 == componenet3){
            if component1 == 2 {
                print("strawbery")
                winnings = playerBet * 2
                showWinMessage()
              
            }
            else if component1 == 4 {
                print("bell")
                winnings = playerBet * 2
                showWinMessage()
            
            }
            else if component1 == 5 {
                print("seven")
                winnings = playerBet * 3
                showWinMessage()
            
            }
            else {
                showLossMessage()
        
            }
        }
            /*--- if last two images are same ---*/
        else if (component2 == componenet3 ){
            if component2 == 2 {
                print("strawbery")
                winnings = playerBet * 2
                showWinMessage()
 
            }
            else if component2 == 4 {
                print("bell")
                winnings = playerBet * 2
                showWinMessage()
     
            }
            else if component2 == 5 {
                print("seven")
                winnings = playerBet * 3
                showWinMessage()
               
            }
            else {
                showLossMessage()
             
            }
        }
            /*--- if no image is same ---*/
        else {
            showLossMessage()
       
        }
    
    
        
    }
   
}

