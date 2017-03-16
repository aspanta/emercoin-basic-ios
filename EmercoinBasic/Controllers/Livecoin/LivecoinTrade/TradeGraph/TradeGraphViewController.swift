//
//  TradeGraphViewController.swift
//  EmercoinOne
//

import UIKit

enum TimeLine {
    
    case m15
    case h1
    case d1
    
    var description:String {
        
        switch self {
            case .m15:return "M15"
            case .h1:return "H1"
            case .d1:return "D1"
        }
    }
}

let graphImagePort = "graph_image"
let graphImageLand = "graph_image_land"

class TradeGraphViewController: UIViewController, IndicatorInfoProvider, UIGestureRecognizerDelegate {
    
    var isLandscape:Bool = false
    
    @IBOutlet internal weak var imageView: UIImageView!
    internal weak var popupView:TradeCandlePopupView?
    
    var timeLine:TimeLine = .m15


    override class func storyboardName() -> String {
        return "Livecoin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView(at: isLandscape)
        setupGestures()
    }
    
    private func setupGestures() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func handleTap(sender:Any) {
        if isLandscape {
            if popupView != nil {
                popupView?.removeFromSuperview()
            } else {
                addTradeCandleView()
            }
        }
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: timeLine.description)
    }
    
    func changeOrientation(at landscape:Bool) {
        isLandscape = landscape
        
        if !isLandscape && popupView != nil {
            popupView?.removeFromSuperview()
        }
        
        setupImageView(at: landscape)
    }
    
    private func setupImageView(at landscape:Bool) {
        
        if imageView != nil {
            let imageName = landscape ? graphImageLand : graphImagePort
            imageView.image = UIImage(named: imageName)
        }
    }
    
    private func addTradeCandleView() {
        
        let view = loadViewFromXib(name: "TradeGraph", index: 0) as! TradeCandlePopupView
        view.center = self.imageView.center
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
        popupView = view
    }

}
