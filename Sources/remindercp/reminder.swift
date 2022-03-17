//
//  File.swift
//  
//
//  Created by Christian Paulo on 17/03/22.
//
//

import EventKit

@main
struct Reminder {
    
    static func main() async throws {
        
        let eventStore = EKEventStore()
        
        do {
            
            try await eventStore.requestAccess(to: .event)
            
            //            ====Para calendários====
            //            guard let calendar = eventStore.defaultCalendarForNewEvents else { return }
            guard let calendar = eventStore.defaultCalendarForNewReminders() else { return }
            let event = EKReminder(eventStore: eventStore)
            //            let event = EKEvent(eventStore: eventStore)
            
            print("Qual o nome do lembrete?")
            
            event.title = readLine()!
            //            ====Para calendários====
            //            event.isAllDay = true
            //            event.startDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            //            event.endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
            event.calendar = calendar
            
            try eventStore.save(event, commit: true)
            
            print("Lembrete Criado")
            
        } catch {
            print(error)
        }
        
    }
    
}
