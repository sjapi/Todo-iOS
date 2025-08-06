# ToDoEffectiveMobile Test Task

<img src="https://github.com/sjapi/Todo-iOS/blob/main/screenshots/1.png" width="200">  <img src="https://github.com/sjapi/Todo-iOS/blob/main/screenshots/2.png" width="200">  <img src="https://github.com/sjapi/Todo-iOS/blob/main/screenshots/3.png" width="200">

## Overview  
Simple ToDo List app with add/edit/delete/search tasks functionality. Uses CoreData for persistence and loads initial data from [dummyjson API](https://dummyjson.com/todos).

## Features  
- Display list of tasks (title, description, creation date, status).  
- Add, edit, delete tasks.  
- Search tasks.  
- Initial task load from API on first launch.  
- Background thread processing for all CoreData operations (GCD used).  
- Data persisted with CoreData and restored on app relaunch.  
- VIPER architecture for clean module separation.  

## Bonus  
- Custom loader with native styling and centered layout.  
- Override point(inside: ...) for task checkbox inside cell.  
- All UI uses native system fonts and components.  

## Requirements  
- Runs on Xcode 15+.  
- Uses GIT for version control.  
- Includes unit tests for core components.  

## Notes 
- Found and fixed retain cycle in VIPER template from GitHub.  

---

