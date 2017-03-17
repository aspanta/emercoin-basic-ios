//
//  Constants.swift
//  EmercoinOne
//
//  Created by Sergey Lyubeznov on 14/02/2017.
//  Copyright © 2017 Aspanta. All rights reserved.
//

import Foundation

import UIKit

struct Constants {
    
    struct API {
        static let BaseURL = "https://159.203.138.164:6662"
        static let User = "emccoinrpc"
        static let Password = "shei7xaoJush6Hoo7shophooqu5doo7vei2riey5saik5egae9quie3sahx1naiw"
        static let getInfo = "getinfo"
    }
    
    struct CellHeights {
        struct HomeMyMoneyCell {
            static let MoneyView = 95.0
            static let Collapsed = 70.0
        }
        struct HomeCourseCell {
            static let CourseView = 112.0
            static let Collapsed = 70.0
        }
        struct LCBCell {
            static let Expanded = 140.0
            static let Collapsed = 72.0
        }
    }
    
    struct Permissions {
        static let PrintDeinit = true
        static let NeedAuth = true
        static let JsonBody = true
    }
    
    struct Colors {
        struct ContactCell {
            static let Edit = "d9743c"
            static let Delete = "da3975"
        }
        
        struct Coins {
            static let Bitcoin = "#ED650A"
            static let Emercoin = "#9B73AE"
        }
        
        struct Status {
            static let Main = "#684979"
            static let Menu = "#3d3d3d"
            static let Emercoin = "#684979"
            static let Settings = "#897295"
            static let Blockchain = "#5b5e7d"
        }
        
        struct TabBar {
            static let Tint = "#287580"
        }
        
        struct NavBar {
            static let Tint = "#2B7582"
            static let BarTint = "#8A58A4"
        }
    }
    
    struct Constraints {
        struct Login {
            struct Top {
                static let iphone5 = 20.0
            }
 
        }
    }
    
    struct Controllers {
        
        struct CoinsOperation {
            
            static let RecipientAddress = "Address of recipient"
            static let Send = "Send Coins"
            static let MyAddress = "My Addresses"
            static let Get = "Receive"
            
            struct ExchangeCoins {
                 static let Bitcoin = "BTC to EMC Exchange"
                 static let Emercoin = "EMC to BTC Exchange"
            }
        }
        
        struct Get {
            static let iphone5 = 40.0
        }
        
        struct Blockchain {
            
            static let HeaderColor = "8387B3"
        }
        
        struct Send {
            struct HeaderView {
                static let BitcoinColor = "#5db1bc"
                static let EmercoinColor = "#9c73b1"
                static let BitcoinImage = "send_bit_icon"
                static let EmercoinImage = "send_emer_icon"
            }
            struct StatusColor {
                static let BitcoinColor = "#417c83"
                static let EmercoinColor = "#684979"
            }
            
            static let MaxCountNumbers = 15
        }
        
        struct Menu {
            
            struct Home {
                static let Title = "Dashboard"
                static let Image = "menu_home_icon"
            }
            struct Send {
                static let Title = "Send Coins"
                static let Image = "menu_send_icon"
            }
            struct Get {
                static let Title = "Receive Coins"
                static let Image = "menu_get_icon"
            }
            struct BCTools {
                static let Title = "BC Tools"
                static let Image = "menu_bctools_icon"
                static let SubTitles = ["EMC DPO,EMC DNS, NVS Etitor"]
            }
            struct About {
                static let Title = "About"
                static let Image = "menu_about_icon"
            }
            struct Settings {
                static let Title = "Settings"
                static let Image = "menu_settings_icon"
            }
            
            struct Politics {
                static let Title = "Privacy Policy"
                static let Image = "menu_politics_icon"
                static let SubTitles = ["Terms of Use"]
            }
            
            struct Contacts {
                static let Title = "Feedback"
                static let Image = "menu_contacts_icon"
            }
            
            struct Exit {
                static let Title = "Logout"
                static let Image = "menu_exit_icon"
                static let SubTitles = ["Alexxx30"]
            }
            
        }
        
        struct TabTitle {
            static let Home = "Dashboard"
            static let Send = "Send"
            static let Get = "Receive"
            static let Exchange = "Exchange"
            static let BlockChain = "Blockchain"
        }
        
        struct TabImage {
            static let Home = "tab_home_icon"
            static let Send = "tab_send_icon"
            static let Get = "tab_get_icon"
            static let Exchange = "tab_exchange_icon"
            static let BlockChain = "tab_blockchain_icon"
        }
    }

}
