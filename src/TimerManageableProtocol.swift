//
//  ManagedTimerProtocol.swift
//  Every
//
//  Created by Pierre TACCHI on 08/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//
import Foundation

public protocol TimerManageable: class {
    func every(_ interval: DateComponents, elapsedHandler: @escaping TimerElapsedHandler) -> TimerHandler;
    func clearTimer(_ handler: TimerHandler);
    func clearTimers();
    func clearAllTimers();
}

extension TimerManageable {
    public func every(_ interval: DateComponents, elapsedHandler: @escaping TimerElapsedHandler) -> TimerHandler {
        return TimerManager.every(interval, owner: self, elapsedHandler: elapsedHandler)
    }
    
    public func clearTimer(_ handler: TimerHandler) {
        TimerManager.clearTimer(handler)
    }
    
    public func clearTimers() {
        TimerManager.clearTimersForOwner(self)
    }
    
    public func clearAllTimers() {
        TimerManager.clearAllTimers()
    }
}
