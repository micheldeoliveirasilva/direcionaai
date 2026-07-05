//
//  TaskView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TELA PRINCIPAL DE TAREFAS
import SwiftUI
import SwiftData

struct TaskView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var S_addTask = false;
    @State private var currentDetent: PresentationDetent = .medium
    @State private var selectedTask: UserTask?
    @State private var selectedDateFilter: TaskFilter = .all
    @Query var tasks: [UserTask]
    // busca no swiftData as tasks armazenadas no model UserTask
    
    func passesDateFilter(_ task: UserTask) -> Bool {
        
        print("Filtro:", selectedDateFilter)
        print("Tarefa:", task.taskName)

        switch selectedDateFilter {

        case .all:

            return true

        case .today:

            return Calendar.current.isDateInToday(task.dateLimit)

        case .week:

            return Calendar.current.isDate(
                task.dateLimit,
                equalTo: Date(),
                toGranularity: .weekOfYear
            )

        case .month:

            return Calendar.current.isDate(
                task.dateLimit,
                equalTo: Date(),
                toGranularity: .month
            )

        }

    }
    
    // filterStatus
    
    private var toDoTasks: [UserTask] {
        tasks.filter { $0.status == .toDo }
    }

    private var inProgressTasks: [UserTask] {
        tasks.filter { $0.status == .inProgress }
    }

    private var doneTasks: [UserTask] {
        tasks.filter { $0.status == .done }
    }
    
    // remove
    
    private func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let taskToDelete = tasks[index]
            modelContext.delete(taskToDelete)
        }
    }
    
    var body: some View {
        
        NavigationStack{
            
            ScrollView {
                
                DateLimitSegmentedControl(
                    selectedFilter: $selectedDateFilter
                )
                
                VStack(alignment: .leading) {
                    Text("Para fazer")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        if toDoTasks.isEmpty {
                            Text("Não há tarefas para fazer.")
                                .foregroundStyle(.secondary)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding()
                            
                        }
                        
                        else {
                            
                            HStack {
                                
                                
                                ForEach(toDoTasks) { task in
                                    if
                                        passesDateFilter(task)  {
                                        TaskDetail(task: task)
                                            .onTapGesture {
                                                    selectedTask = task
                                                }
                                            .draggable(UserTaskTransfer(id: task.id))
                                    }
                                }

                                // percore e cria cada task exibindo dentro do molde criado em TaskDetailView e filtrando pelo status
                                
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .contentShape(Rectangle())
                .dropDestination(for: UserTaskTransfer.self) { items, location in
                    
                    guard let transfer = items.first,
                          let draggedTask = tasks.first(where: { $0.id == transfer.id }) else {
                        return false
                    }

                    withAnimation(.snappy) {
                        draggedTask.status = .toDo
                    }
                    
                    print("DROP")
                    return true
                }
                
                VStack(alignment: .leading) {
                    Text("Em andamento")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        if inProgressTasks.isEmpty {
                            Text("Não há tarefas em andamento.")
                                .foregroundStyle(.secondary)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding()
                            
                        }
                        
                        else {
                            
                            HStack {ForEach(inProgressTasks) { task in
                                if  passesDateFilter(task) {
                                    TaskDetail(task: task)
                                        .onTapGesture {
                                                selectedTask = task
                                            }
                                        .draggable(UserTaskTransfer(id: task.id))
                                }
                            }
                                
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .contentShape(Rectangle())
                .dropDestination(for: UserTaskTransfer.self) { items, location in
                    
                    guard let transfer = items.first,
                          let draggedTask = tasks.first(where: { $0.id == transfer.id }) else {
                        return false
                    }

                    withAnimation(.snappy) {
                        draggedTask.status = .inProgress
                    }
                    
                    print("DROP")
                    return true
                }
                
                VStack(alignment: .leading) {
                    Text("Concluído")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        if doneTasks.isEmpty {
                            Text("Não há tarefas concluídas.")
                                .foregroundStyle(.secondary)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding()
                            
                        }
                        
                        else {
                        
                        HStack {ForEach(doneTasks) { task in
                            if
                                passesDateFilter(task)  {
                                TaskDetail(task: task)
                                    .onTapGesture {
                                            selectedTask = task
                                        }
                                    .draggable(UserTaskTransfer(id: task.id))
                            }
                        }
                            
                        }
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .contentShape(Rectangle())
                .dropDestination(for: UserTaskTransfer.self) { items, location in
                    
                    guard let transfer = items.first,
                          let draggedTask = tasks.first(where: { $0.id == transfer.id }) else {
                        return false
                    }

                    withAnimation(.snappy) {
                        draggedTask.status = .done
                    }
                    
                    print("DROP")
                    return true
                }
                
            }
            .padding(10)
            .navigationTitle("Tarefas")
            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink{
                        ArchTasksView()
                    } label : {
                        Image(systemName: "archivebox.fill")
                    }
                    
                }
                
                ToolbarSpacer(.flexible, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        S_addTask.toggle()
                    }) {
                        Label("Adicionar tarefa", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        print("Visualizar lembretes")
                    }) {
                        Label("Lembretes", systemImage: "bell.fill")
                    }
                }
            }
            .sheet(isPresented: $S_addTask) {
                
                S_Task(actualDetent: $currentDetent)
                    .presentationDetents([.medium, .large], selection: $currentDetent)
                    .presentationDragIndicator(.visible)
                    .onDisappear{
                        currentDetent = .medium
                    }
            }
            
            .sheet(item: $selectedTask) { task in

                S_Task(
                    actualDetent: $currentDetent,
                    existTask: task
                )

                .presentationDetents(
                    [.medium, .large],
                    selection: $currentDetent
                )

                .presentationDragIndicator(.visible)

                .onDisappear {

                    currentDetent = .medium
                    selectedTask = nil

                }
            }
            
        }
        
    }
}


#Preview {
    
    TaskView()
        .modelContainer(
            for: [
                Subject.self,
                UserTask.self
            ],
            inMemory: true
        )
}
