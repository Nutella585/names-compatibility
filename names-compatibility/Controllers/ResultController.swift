//
//  ResultController.swift
//  names-compatibility
//

import UIKit

class ResultController: UIViewController {

    @IBOutlet weak var nameLbl       : UILabel!
    @IBOutlet weak var progressView  : UIProgressView!
    @IBOutlet weak var percentageLbl : UILabel!
    
    var firstName  : String!
    var secondName : String!
    private var resultValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = "\(firstName ?? "") and \(secondName ?? "") are compitable for ..."

        resultValue = findResult()
        percentageLbl.text = resultValue.formatted(.percent)
        
        // Progress view config
        progressView.progress = Float(resultValue) / 100                        // takes range 0.0 ... 1.0;
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)    // makes `progressView` heigher;
    }

    
    
    /**
     Counts points for name.
     */
    private func _findValue (for name: String) -> Int {
        var count = 0
        
        for character in name.lowercased () {
            switch character {
            case "a", "i","j","q","v"   : count += 1
            case "b", "k", "r"          : count += 2
            case "c","g", "l", "s"      : count += 3
            case "d", "m","t"           : count += 4
            case "e", "h", "n", "x"     : count += 5
            case "u", "V", "W"          : count += 6
            case "o", "z"               : count += 7
            case "f", "p"               : count += 8
            default: count += 0
            }
        }
        
        return count
    }
    
    /**
     Calculates result in percanteges
     */
    private func findResult () -> Int {
        var result = 0
        
        let firstValue = _findValue (for: firstName)
        let secondValue = _findValue (for: secondName)
        let absDifference = abs(firstValue - secondValue)
        
        switch absDifference {
            case 0, 1, 2    : result = 100
            case 3, 4       : result = 65
            case 5          : result = 50
            case 6          : result = 40
            default: result = 30
        }
        
        return result
    }
    
}
