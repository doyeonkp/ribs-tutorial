//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by M Kim on 2021/11/24.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener{
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController:ViewControllable)
    func dismiss(viewController:ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
           viewController: LoggedInViewControllable,
           offGameBuilder: OffGameBuildable) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }
    
    func cleanupViews(){
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
    
    func routeToOffGame(){
        detachCurrentChild()
        attachOffGame()
    }
    
    func routeToTicTacToe() {
        print("TicTacToe")
    }
    
    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private var currentChild: ViewableRouting?
    
    private func attachOffGame(){
        let offGame = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController: offGame.viewControllable)
    }
    
    private func detachCurrentChild(){
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
}
