//
//  BlockchainLoadingView.swift
//  EmercoinBasic
//

import UIKit

class BlockchainLoadingView: PopupView {
    
    @IBOutlet internal weak var textLabel:UILabel!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var checkBlockchain:((Void) -> (Void))?
    
    private var seconds = 0
    private var interval = 15
    
    private var timer:Timer?
    
    var blockchain:Blockchain? {
        didSet {
            updateUI()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        startTimer(at:interval)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func startTimer(at seconds:Int) {
        
        self.seconds = seconds
        
        if interval != seconds {
            interval = seconds
        }
        
        let selector = #selector(self.handleTimer)
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:selector, userInfo: nil, repeats: true)
        
        self.timer = timer
        timer.fire()
    }
    
    internal func handleTimer() {
        
        seconds -= 1
        
        if seconds == 0 {
            
            seconds = 60
            
            if checkBlockchain != nil {
                checkBlockchain!()
            }
        }
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    private func updateUI() {
        
        if let blockchain = blockchain {
            textLabel.text = String(format:"Depth done: %i blocks",blockchain.blocks)
        }
    }

}