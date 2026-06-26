# 🎯 direcionaai — Task Tracker Universitário

> Um aplicativo em SwiftUI desenvolvido para ajudar estudantes universitários a gerenciarem suas matérias, tarefas, exames e horários de forma centralizada e intuitiva.

---

## 📝 Sobre o Projeto

O **direcionaai** nasceu da necessidade de centralizar a rotina acadêmica. Sabemos que a vida universitária é um caos de prazos, matérias e notas. Este app foi desenhado com foco na experiência do usuário (UX) para garantir que o estudante consiga registrar e visualizar seus compromissos acadêmicos sem atritos, utilizando o que há de mais moderno no ecossistema Apple com **SwiftUI**.

### ✨ Funcionalidades Principais
* **Gerenciamento de Matérias:** Cadastro e visualização de disciplinas do semestre.
* **Tracker de Tarefas:** Criação, detalhamento e arquivamento de entregas/trabalhos.
* **Controle de Exames:** Organização de datas de provas importantes.
* **Cronograma Acadêmico:** Visualização integrada dos horários das aulas.

---

## 📁 Estrutura do Repositório

Abaixo está a organização dos arquivos do projeto, seguindo o padrão de arquitetura focado na separação de Modelos e Views do SwiftUI:

```text
direcionaai/
├── direcionaai/
│   ├── App/                        # Ciclo de vida e configurações globais do app
│   ├── Models/                     # Estruturas de dados e regras de negócio
│   │   ├── Schedule.swift          # Modelo de Horários/Cronograma
│   │   ├── Subject.swift           # Modelo de Matérias/Disciplinas
│   │   └── Task.swift              # Modelo de Tarefas
│   ├── Views/                      # Telas e Componentes visuais
│   │   ├── Components/             # Subvisões e componentes reutilizáveis
│   │   │   ├── S_AddTask.swift     # Modal/Sheet para adicionar tarefa
│   │   │   └── S_Task.swift        # Card/Linha de renderização da tarefa
│   │   ├── Subjects/               # Fluxo de Matérias e Grade Horária
│   │   │   ├── S_AddExam.swift     # Modal para adicionar exame
│   │   │   ├── S_AddSubject.swift  # Modal para adicionar matéria
│   │   │   ├── ScheduleView.swift  # Tela de grade de horários
│   │   │   ├── SubjectListView.swift # Lista geral de matérias
│   │   │   └── SubjectView.swift   # Detalhes de uma matéria específica
│   │   ├── Tasks/                  # Fluxo de Tarefas
│   │   │   ├── ArchTasksView.swift # Tela de tarefas arquivadas/concluídas
│   │   │   ├── TaskDetailView.swift # Detalhes de uma tarefa específica
│   │   │   └── TaskView.swift      # Tela principal de listagem de tarefas
│   │   ├── ContentView.swift       # Hub principal/Roteador inicial
│   │   ├── OnboardingView.swift    # Tela de introdução para novos usuários
│   │   └── TabView.swift           # Barra de navegação inferior do app
│   └── Assets.xcassets             # Ícones, cores personalizadas e imagens
```

---

## ✅ Divisão de Tarefas

| Responsável | Tarefa |
| :--- | :--- |
| Débora Lemos | ? | 
| Gabriel Belo | ?|
| Michel Oliveira | ? | 

---

## 📈 Desafios & Lições

### Desafio 1: ...

- Solução: ...

---

## 📸 Mural de Fotos (Screenshots)

Veja como está ficando a interface do nosso aplicativo:

---

## 💻 Membros participantes: 
<table align="center">
  <tr>
    <td align="center">
      <a href="https://github.com/deblemos">
        <img src="https://avatars.githubusercontent.com/u/173482833?v=4" width="120px;" alt="Arthur Luz"/><br>
        <sub><b>Arthur Luz</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/gabrielbelo2007">
        <img src="https://avatars.githubusercontent.com/u/91219977?v=4" width="120px;" alt="Gabriel Belo"/><br>
        <sub><b>Gabriel Belo</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/micheldeoliveirasilva">
        <img src="https://avatars.githubusercontent.com/u/216450765?v=4" width="120px;" alt="João Pedro"/><br>
        <sub><b>João Pedro</b></sub>
      </a>
    </td>
  </tr>
</table>

### 📄 Documentação Adicional

- [Guia de Contribuição (CONTRIBUTING.md)](CONTRIBUTING.md) - Padrões de código e branches.
