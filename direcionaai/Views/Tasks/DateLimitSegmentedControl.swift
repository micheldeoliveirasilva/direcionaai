//
//  DateLimitSegmentedControl.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 05/07/26.
//

import SwiftUI
import SwiftData

enum TaskFilter: String, Codable, CaseIterable {

case all = "Todos"
case today = "Hoje"
case week = "Semana"
case month = "Mês"

}

struct DateLimitSegmentedControl: View {

@Binding var selectedFilter: TaskFilter

    var body: some View {
        
        Picker("Filtro", selection: $selectedFilter) {

                  ForEach(TaskFilter.allCases, id: \.self) { filter in

                      Text(filter.rawValue)
                          .tag(filter)

                  }

              }
              .pickerStyle(.segmented)    }
}

#Preview {
    DateLimitSegmentedControl(selectedFilter: .constant(TaskFilter.all))
}
