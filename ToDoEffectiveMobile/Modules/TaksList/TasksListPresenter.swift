//
//  TasksListPresenter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//
//

import Foundation

final class TasksListPresenter: ViewToPresenterTasksListProtocol {
    // MARK: - VIPER Properties
    var view: PresenterToViewTasksListProtocol?
    var interactor: PresenterToInteractorTasksListProtocol?
    var router: PresenterToRouterTasksListProtocol?
    
    // MARK: - Other Properties
    private var allTasksList: [TodoTaskModel] = []
    var tasksList: [TodoTaskModel] = []
    
    // MARK: - Init
    init() {
        allTasksList = loadTasksList()
        tasksList = allTasksList
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        view?.showEmptyStateLabel(tasksList.count == 0)
    }
    
    func onTaskCheckboxTapped(index: Int) {
        self.tasksList[index].isCompleted.toggle()
        view?.updateCell(at: IndexPath(row: index, section: 0))
    }
    
    func onTaskTapped(index: Int) {
        print("Navigate to task detail module")
    }
    
    func searchTextDidChange(_ text: String) {
        if text.isEmpty {
            tasksList = allTasksList
        } else {
            tasksList = allTasksList.filter {
                $0.name.lowercased().contains(text.lowercased()) ||
                $0.description?.lowercased().contains(text.lowercased()) ?? false
            }
        }
        view?.showEmptyStateLabel(tasksList.count == 0)
        view?.updateTable()
    }
}

// MARK: - Private Methods
private extension TasksListPresenter {
    func loadTasksList() -> [TodoTaskModel] {
        return [
            .init(name: "Купить продукты", description: "Список: молоко, хлеб, яйца", timestampCreated: 1627812000, timestampModified: 1627815600, isCompleted: true),
            .init(name: "Позвонить маме", description: "Узнать, как дела", timestampCreated: 1627812600, timestampModified: 1627816200, isCompleted: true),
            .init(name: "Написать отчёт", description: "Финальный отчёт по проекту", timestampCreated: 1627813200, timestampModified: 1627816800, isCompleted: false),
            .init(name: "Сходить в спортзал", description: "Тренировка: ноги и спина", timestampCreated: 1627813800, timestampModified: 1627817400, isCompleted: true),
            .init(name: "Погулять с собакой", description: "Прогулка вечером", timestampCreated: 1627814400, timestampModified: 1627818000, isCompleted: true),
            .init(name: "Прочитать книгу", description: "Закончить последнюю главу", timestampCreated: 1627815000, timestampModified: 1627818600, isCompleted: false),
            .init(name: "Оплатить счета", description: "Коммуналка и интернет", timestampCreated: 1627815600, timestampModified: 1627819200, isCompleted: false),
            .init(name: "Убраться дома", description: "Пропылесосить и помыть пол", timestampCreated: 1627816200, timestampModified: 1627819800, isCompleted: true),
            .init(name: "Посмотреть фильм", description: "Выбрать новый фильм", timestampCreated: 1627816800, timestampModified: 1627820400, isCompleted: true),
            .init(name: "Составить план на завтра", description: "Записать задачи и встречи", timestampCreated: 1627817400, timestampModified: 1627821000, isCompleted: true)
        ]
    }
    
}

extension TasksListPresenter: InteractorToPresenterTasksListProtocol {
    
}
