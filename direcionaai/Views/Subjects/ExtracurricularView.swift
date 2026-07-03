//
//  ExtracurricularView.swift
//  direcionaai
//
//  Created by Débora Lemos on 02/07/26.
//

import SwiftUI
import SwiftData

struct ExtracurricularView: View {
    
    let activity: ExtracurricularActivity
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 28) {
                
                HStack(spacing: 12) {
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(activity.activityColor.color)
                        .frame(width: 7, height: 52)
                    
                    Text(activity.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Horários")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(activity.activitySchedule, id: \.self) { schedule in
                        
                        HStack {
                            
                            Text(schedule.day.rawValue)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Text(
                                "\(schedule.startTime.formatted(date: .omitted, time: .shortened)) – \(schedule.endTime.formatted(date: .omitted, time: .shortened))"
                            )
                            .foregroundStyle(.secondary)
                        }
                        
                        Divider()
                    }
                }
                
                if !activity.activityDescription.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Descrição")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(activity.activityDescription)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Atividade")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Atividade extracurricular") {
    
    NavigationStack {
        
        ExtracurricularView(
            activity: ExtracurricularActivity(
                name: "Apple Developer Academy",
                activitySchedule: [
                    SubjectDay(
                        day: .ter,
                        startTime: .now,
                        endTime: .now
                    ),
                    SubjectDay(
                        day: .qui,
                        startTime: .now,
                        endTime: .now
                    )
                ],
                activityDescription: "Atividade voltada ao desenvolvimento de aplicativos e produtos digitais.",
                activityColor: .roxo
            )
        )
    }
    .modelContainer(
        for: ExtracurricularActivity.self,
        inMemory: true
    )
}
