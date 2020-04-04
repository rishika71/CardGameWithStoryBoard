//
//  ViewController.swift
//  CardGameWithStoryBoard
//
//  Created by Rishika Mathur on 4/1/20.
//  Copyright © 2020 Rishika Mathur. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    enum AllSuits_Enums:String, CaseIterable {
        
         case Spades = "S"
         case Hearts = "H"
         case Diamonds = "D"
         case Clubs = "C"
      
    }
     var randomSuit: AllSuits_Enums {
        return [.Spades, .Hearts, .Diamonds, .Clubs][Int(arc4random_uniform(4))]
          }
    
    enum AllRanks_Enums:String,CaseIterable {
           
            case Two = "2"
            case Three = "3"
            case Four = "4"
            case Five = "5"
            case Six = "6"
            case Seven = "7"
            case Eight = "8"
            case Nine = "9"
            case Ten = "10"
            case Jack = "11"
            case Queen = "12"
            case King = "13"
            case Ace = "14"
       
      
       }
     var randomNumber: AllRanks_Enums {
        return [.Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine, .Ten, .Jack, .Queen, .King, .Ace][Int(arc4random_uniform(13))]

                  }
           
    
    class Cards{
        
        let rank:String
        let suit:String
        init(rank:String, suit:String) {

            self.rank = rank
            self.suit = suit
        }

    }
    
    class Deck{
         
        var deckList:[Cards] = []

        init() {
            self.deckList = Array<Cards>()
        }
         func createDeck()->[Cards]{
            for suit in AllSuits_Enums.allCases{
                for rank in AllRanks_Enums.allCases{
                    let newCard = Cards(rank:rank.rawValue, suit:suit.rawValue)
                    self.deckList.append(newCard)
                }
            }
            return deckList.shuffled()   //shuffle the deck
           
            }
    }

    
    

    @IBOutlet weak var playerCard: UIImageView!
    @IBOutlet weak var cpuCard: UIImageView!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var cpuScoreLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var dealerButton: UIButton!
    @IBOutlet weak var countOfPlayerCardsLabel: UILabel!
    @IBOutlet weak var countOfCpuCardsLabel: UILabel!
    
    
    var playerScore = 0
    var cpuScore = 0
    var numberOfPlayerCards = 0
    var numberOfCpuCards = 0
    var listOfPlayerCards:Array<Cards> = []
    var listOfCpuCards:Array<Cards> = []
    
    var cardObj:Cards!
    var deckObj:Deck!
    var deckOfCards:Array<Cards>!
  
    var rankOfCard: [String: Int] = [AllSuits_Enums.Spades.rawValue:1,
                                     AllSuits_Enums.Hearts.rawValue:2,
                                     AllSuits_Enums.Diamonds.rawValue:3,
                                     AllSuits_Enums.Clubs.rawValue:4]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        dealerButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    
    @IBAction func startButton(_ sender: Any) {
        
        cardObj = Cards(rank: "2", suit: "S")
        deckObj = Deck()
        deckOfCards = deckObj.createDeck()
              // let t = type(of: deckOfCards)
               
        //Distribution of cards
        listOfPlayerCards = distributionOfCards(lower_range: 0, upper_range:25, cardDeck: deckOfCards)
        listOfCpuCards = distributionOfCards(lower_range:26,upper_range:51, cardDeck: deckOfCards)
          
        startGameButton.removeFromSuperview()
         dealerButton.isEnabled = true
    }
    
    
    @IBAction func dealButton(_ sender: Any) {
        
        
            let topCard = 0
            let count_of_playerCards = listOfPlayerCards.count
            let count_of_cpuCards = listOfCpuCards.count
            
            if count_of_playerCards==0{
                print("cpu wins")
               
            }
            else if count_of_cpuCards==0{
                    print("player wins")
              
            }
            
 
            let playerCardNumber = Int(listOfPlayerCards[topCard].rank) ?? 2
            let cpuCardNumber = Int(listOfCpuCards[topCard].rank) ?? 2
            let playerCardSuit = listOfPlayerCards[topCard].suit
            let cpuCardSuit = listOfCpuCards[topCard].suit
          
            // updating card images
            playerCard.image = UIImage(named: String(playerCardNumber) + playerCardSuit)
            cpuCard.image = UIImage(named: String(cpuCardNumber) + cpuCardSuit)
            

            //Update Scores
            if playerCardNumber>cpuCardNumber{

                playerScore+=1
                listOfPlayerCards.append(Cards(rank:String(cpuCardNumber), suit:cpuCardSuit))
                listOfCpuCards.remove(at: topCard)
                listOfPlayerCards.shuffle()
            }
            else if cpuCardNumber>playerCardNumber{
            
                cpuScore+=1
                listOfCpuCards.append(Cards(rank:String(playerCardNumber), suit:playerCardSuit))
                listOfPlayerCards.remove(at: topCard)
                listOfCpuCards.shuffle()
            }
            else if cpuCardNumber==playerCardNumber{
                //compare with Rank of the Cards
                let rankOfPlayerCard = rankOfCard[playerCardSuit]!
                let rankOfCpuCard = rankOfCard[cpuCardSuit]!

                if rankOfPlayerCard>rankOfCpuCard{
                    cpuScore+=1
                    listOfCpuCards.append(Cards(rank:String(playerCardNumber), suit:playerCardSuit))
                    listOfPlayerCards.remove(at: topCard)
                    listOfCpuCards.shuffle()
                }
                else if rankOfCpuCard>rankOfPlayerCard{
                    playerScore+=1
                    listOfPlayerCards.append(Cards(rank:String(cpuCardNumber), suit:cpuCardSuit))
                    listOfCpuCards.remove(at: topCard)
                    listOfPlayerCards.shuffle()
                }
               

            }
      
        //Update Scores
        playerScoreLabel.text = String(playerScore)
        cpuScoreLabel.text = String(cpuScore)
        
        //Update Card Count
        countOfPlayerCardsLabel.text = String(listOfPlayerCards.count)
        countOfCpuCardsLabel.text = String(listOfCpuCards.count)
        
            }
            
           
    
    
            //Function for Distributing Cards
            
            func distributionOfCards(lower_range:Int, upper_range:Int, cardDeck:Array<Cards>) ->Array<Cards> {
               
                var listOfCards:Array<Cards> = []
                for i in lower_range...upper_range{
                           listOfCards.append(cardDeck[i])
                       }
                return listOfCards
    }
    
    
    

}

