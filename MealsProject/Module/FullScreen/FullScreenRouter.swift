//
//  FullScreenRouter.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 14.06.2021.
//

import UIKit

protocol IFullScreenRouter
{
    func close()
}

class FullScreenRouter: IFullScreenRouter
{
   var controller: UIViewController?
    
    func close() {
        controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
