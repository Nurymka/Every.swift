//
//  NSDateComponentsExtensions.swift
//  Every
//
//  Created by Samhan on 05/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

import Foundation

private struct DateConstants {
    static let secPerMinute         = 60
    static let secPerHour           = secPerMinute * 60
    static let secPerDay            = secPerHour * 24
    static let secPerMonth          = secPerDay * 30
    static let secPerYear           = secPerMonth * 12
    static let secPerNanosecond     = 1e-9
}

public extension DateComponents
{
    static public func zero()->DateComponents
    {
        var new         = DateComponents()
        new.hour        = 0
        new.minute      = 0
        new.second      = 0
        new.day         = 0
        new.month       = 0
        new.year        = 0
        new.nanosecond  = 0
        return new
    }
    
    func durationInSeconds() -> TimeInterval
    {
        let nanosecond = Double(self.nanosecond!) * DateConstants.secPerNanosecond
        let secAndMin = self.second! + self.minute! * DateConstants.secPerMinute
        let hourAndDay = self.hour! * DateConstants.secPerHour + self.day! * DateConstants.secPerDay
        let monthAndYear = self.month! * DateConstants.secPerMonth + self.year! * DateConstants.secPerYear
        return TimeInterval(Double(secAndMin) + Double(hourAndDay) + Double(monthAndYear) + nanosecond)
    }
    
}


public extension Int {
    public var hours: DateComponents {
            var components = DateComponents.zero()
            components.hour = self
            return components
    }
    
    public var minutes: DateComponents {
            var components = DateComponents.zero()
            components.minute = self
            return components
    }
    
    public var seconds: DateComponents {
            var components = DateComponents.zero()
            components.second = self
            return components
    }
    
    public var nanoseconds: DateComponents {
        var components = DateComponents.zero()
        components.nanosecond = self
        return components
    }
    
    
    public var milliseconds: DateComponents {
        var components = DateComponents.zero()
        components.nanosecond = self * 1000000
        return components
    }
    
    public var days: DateComponents {
            var components = DateComponents.zero()
            components.day = self
            return components
    }
    
    public var months : DateComponents {
            var components = DateComponents.zero()
            components.month = self
            return components
    }
    
    public var weeks: DateComponents {
            var components = DateComponents.zero()
            components.day = self*7
            return components
    }
    
    
    public var years: DateComponents {
        var components = DateComponents.zero()
        components.year = self
        return components
    }
}

public func +(compOne: DateComponents , compTwo: DateComponents) -> DateComponents {
    var newComponent = DateComponents()
    newComponent.minute     =   compOne.minute!      + compTwo.minute!
    newComponent.second     =   compOne.second!      + compTwo.second!
    newComponent.hour       =   compOne.hour!        + compTwo.hour!
    newComponent.day        =   compOne.day!         + compTwo.day!
    newComponent.month      =   compOne.month!       + compTwo.month!
    newComponent.year       =   compOne.year!        + compTwo.year!
    newComponent.nanosecond =   compOne.nanosecond!  + compTwo.nanosecond!
    return newComponent
}


public func -(frmDate: Date , toDate: Date) -> DateComponents{
    return (Calendar.current as NSCalendar).components([.year, .month, .day, .hour, .minute, .second,.nanosecond], from: toDate, to: frmDate, options: NSCalendar.Options(rawValue:0))
}
