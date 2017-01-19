//
//  ComplicationController.swift
//  HBO WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 17/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let hour: TimeInterval = 60 * 60
    var programs: [[String: Any]] = []
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date(timeIntervalSinceNow: hour*24))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        guard let programsList = UserDefaults.standard.object(forKey: "complicationData") else {
            handler(nil)
            return
        }
        programs = programsList as! [[String : Any]]
        let currentProgram = programs.first!
        let title = currentProgram["title"] as! String
        let timeInit = currentProgram["timeInit"] as! Date
        let timeFinish = currentProgram["timeEnd"] as! Date
        
        let template = CLKComplicationTemplateModularLargeStandardBody()
        template.headerTextProvider = CLKTimeIntervalTextProvider(start: timeInit, end: timeFinish)
        template.body1TextProvider = CLKSimpleTextProvider(text: title)
        
        let entry = CLKComplicationTimelineEntry(date: Date(timeInterval: hour * -0.25, since: timeInit), complicationTemplate: template)
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        
        var entries: [CLKComplicationTimelineEntry] = []

        for program in programs {
            let title = program["title"] as! String
            let timeInit = program["timeInit"] as! Date
            let timeFinish = program["timeEnd"] as! Date
            
            if entries.count < limit && timeInit.timeIntervalSince(date) > 0 {
                let template = CLKComplicationTemplateModularLargeStandardBody()
                template.headerTextProvider = CLKTimeIntervalTextProvider(start: timeInit, end: timeFinish)
                template.body1TextProvider = CLKSimpleTextProvider(text: title)
                
                let entry = CLKComplicationTimelineEntry(date: Date(timeInterval: hour * -0.25, since: timeInit), complicationTemplate: template)
                entries.append(entry)
            }
        }
        
        handler(entries)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        if (complication.family == .modularLarge) {
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKTimeIntervalTextProvider(start: Date(), end: Date(timeIntervalSinceNow: hour*24))
            template.body1TextProvider = CLKSimpleTextProvider(text: "HBO Program")
            handler(template)
        } else {
            handler(nil)
        }
    }
    
}
