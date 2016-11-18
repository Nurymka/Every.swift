//
//  Every.swift
//  Every
//
//  Created by Samhan on 05/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import Foundation

public typealias TimerElapsedHandler = () -> Bool

public struct TimerHandler{
    public var isValid: Bool {
        guard let timer = item?.timer else { return false }
        return timer.isValid
    }
    fileprivate let item: TimerItem?
    fileprivate init(item: TimerItem) {
        self.item = item
    }
}

internal class TimerItem: NSObject {
    fileprivate weak var timer: Timer?
    fileprivate var elapsedHandler: TimerElapsedHandler
    fileprivate weak var owner: AnyObject?
    
    fileprivate init(duration: TimeInterval, owner: AnyObject, elapsedHandler: @escaping TimerElapsedHandler) {
        self.owner = owner
        self.elapsedHandler = elapsedHandler
        super.init()
        self.timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(TimerItem.timerElapsed(_:)), userInfo: nil, repeats: true)
    }
    
    internal func timerElapsed(_ timer: Timer) {
        guard timer == self.timer else { return }
        // Each time a timer is elapsed we check if the owner has been deallocated.
        // If it has been we deallocate the timer to.
        if owner == nil || !elapsedHandler() {
            clearTimer()
            TimerManager.clearTimer(timer)
        }
    }
    
    fileprivate func clearTimer() {
        self.timer?.invalidate()
    }
}

public struct TimerManager {
    fileprivate static var timers = [TimerItem]()
    
    public static func every(_ interval: DateComponents, owner: AnyObject, elapsedHandler: @escaping TimerElapsedHandler) -> TimerHandler {
        let handler = TimerItem(duration: interval.durationInSeconds(), owner: owner, elapsedHandler: elapsedHandler)
        timers.append(handler)

        return TimerHandler(item: handler)
    }
    
    public static func clearTimer(_ handler: TimerHandler) {
        guard let timer = handler.item?.timer, timer.isValid else { return }
        
        func timerItemPredicate(_ item: TimerItem) -> Bool {
            return item.timer == timer
        }
        
        if let index = timers.index(where: timerItemPredicate) {
            handler.item?.clearTimer()
            timers.remove(at: index)
        }
    }
    
    public static func clearTimersForOwner(_ owner: AnyObject) {
        timers.filter({ $0.owner === owner }).forEach({ $0.clearTimer() })
        timers = timers.filter {
            $0.owner !== owner
        }
    }
    
    public static func clearAllTimers() {
        timers.forEach {
            $0.clearTimer()
        }
        timers.removeAll()
    }
    
    fileprivate static func clearTimer(_ timer: Timer) {
        func timerItemPredicate(_ item: TimerItem) -> Bool {
            return item.timer == timer
        }
        
        if let index = timers.index(where: timerItemPredicate) {
            timers.remove(at: index)
        }
        print("Timer cleared !")
    }
}
