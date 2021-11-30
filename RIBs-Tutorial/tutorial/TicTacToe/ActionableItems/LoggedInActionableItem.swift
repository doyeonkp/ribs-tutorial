//
//  LoggedInActionableItem.swift
//  TicTacToe
//
//  Created by M Kim on 2021/11/26.
//  Copyright © 2021 Uber. All rights reserved.
//

import Foundation
import RxSwift

public protocol LoggedInActionableItem: class {
    func lunchGaem(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}
