//
//  BoxObservable.swift
//  contactsApp
//
//  Created by Memo Figueredo on 7/12/21.
//

import Foundation

class Observable<T> {

    var value: T? {
        didSet {
            listerner.forEach {
                $0(value)
            }
        }
    }

    
    init(_ value: T?) {
        self.value = value
    }

      private var listerner: [((T?) -> Void)] = []
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listerner.append(listener)
    }
    
    

}


//class Observable<T> {
//
//    var value: T? {
//        didSet {
//            listerner?(value)
//        }
//    }
//
//
//    init(_ value: T?) {
//        self.value = value
//    }
//
//      private var listerner: ((T?) -> Void)?
//
//    func bind(_ listener: @escaping (T?) -> Void) {
//        listener(value)
//        self.listerner = listener
//    }
//
//
//
//}

