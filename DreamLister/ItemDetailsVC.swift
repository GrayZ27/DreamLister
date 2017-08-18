//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Gray Zhen on 8/18/17.
//  Copyright © 2017 GrayStudio. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
    }

}
