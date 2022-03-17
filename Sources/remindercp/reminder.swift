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
        
        
        print("O que você quer fazer?")
        print("1 - Adicionar novo alarme")
        print("2 - Ver meus alarmes")
        
        let receberValue = readLine()
        let valueConverter = getInt(value: receberValue ?? "0")
        
        var closingApp = true
        
        
        while(closingApp){
            
            switch valueConverter{
                
            case 1:
                
                let eventStore = EKEventStore()
                
                do {
                    
                    try await eventStore.requestAccess(to: .reminder)
                    
                    
                    
                    guard let calendar = eventStore.defaultCalendarForNewReminders() else {
                        
                        return
                    }
                    
                    //                    Criando o Event Kit para Lembretes
                    let event = EKReminder(eventStore: eventStore)
                    
                    
                    print("Qual o nome do seu alarme?")
                    
                    event.title = readLine()!
                    
                    let date = Date()
                    
                    
                    let dateCalendar = Calendar.current
                    let hourCalendar = dateCalendar.component(.hour, from: date)
                    let minuteCalendar = dateCalendar.component(.minute, from: date)
                    //                  Pegar o dia atual
                    var components = dateCalendar.dateComponents(in: .current, from: date)
                    
                    
                    print("Que horas você quer seu alarme?")
                    let hours = readLine()!
                    let separatorHours = hours.components(separatedBy: ":")
                    components.hour = getInt(value: separatorHours[0])
                    components.minute = getInt(value: separatorHours[1])
                    
                    if components.hour ?? 00 < hourCalendar && components.minute ?? 00 < minuteCalendar {
                        let dayCalendar = dateCalendar.component(.day, from: date)
                        components.day = dayCalendar + 1
                    }

                    //
                    event.dueDateComponents = components
                    
                    
                    event.calendar = calendar
                    
                    try eventStore.save(event, commit: true)
                    
                    print("Lembrete Criado")
                    
                } catch {
                    
                    print(error)
                }
                closingApp = false
                
            default:
                print("Você saiu")
                closingApp = false
                
            }
            
        }
    }
    
}
