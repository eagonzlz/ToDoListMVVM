# MVVM To-Do List App

## Project Description

The **To-Do List Application** is a task management tool built using SwiftUI. It allows users to create, view, edit, and delete tasks in a simple, user-friendly interface.

## Architecture Overview

The app is implemented using the **MVVM (Model-View-ViewModel)** architectural pattern:

- **Model**:
  - Represents the core data structure, like the `ToDo` object, including its properties.

- **View**:
  - The SwiftUI views (`ToDoListView`, `EditToDoView`, and `ProfileView`) handle the UI presentation.
  - They are reactive and update automatically when the data in the `ViewModel` changes.

- **ViewModel**:
  - Contains the business logic and acts as the intermediary between the Model and the View.
  - `ToDoViewModel` manages the list of `ToDo` items, handles operations like adding, toggling completion, and deleting tasks, then exposes this data to the views.

## Usage Instructions
* Tap the (+) button to add a task.
* Tap on a task to edit it.
* Swipe on a task to delete it.
* Alternatively, tap the Edit button to delete tasks.
* Tap the checkmark on a task to mark it as complete.
* Tap the profile icon to add profile details and toggle dark mode.

## Features Implemented

- **Adding To-Do Items**:
  - Users can create new tasks by entering a title in the text field and tapping the "+" button.

- **Toggling Completion**:
  - Users can mark tasks as completed or incomplete by tapping the checkmark icon.

- **Editing To-Do Items**:
  - Users can edit the title of a task by tapping on it and updating the text in the edit screen.

- **Deleting To-Do Items**:
  - Users can delete tasks by swiping left on a task and confirming the deletion.

- **Dark Mode Support**:
  - The app dynamically adapts its colors based on the system's dark mode settings. Users can also toggle dark mode manually in the Profile view.

## Screenshots

### Main Screen
![ToDoListView](screenshots/ToDoListView.png?raw=true "ToDoListView")

### Adding a To-Do
![AddingTask](screenshots/AddingTask.png?raw=true "AddingTask")
![AddedTask](screenshots/AddedTask.png?raw=true "AddedTask")

### Deleting Items
![DeletingTask](screenshots/DeletingTask.png?raw=true "DeletingTask")
![ConfirmDelete](screenshots/ConfirmDelete.png?raw=true "ConfirmDelete")

### Editing To-Do Items
![EditToDoView](screenshots/EditToDoView.png?raw=true "EditToDoView")
![EditedTask](screenshots/EditedTask.png?raw=true "EditedTask")

### Profile Screen
![ProfileView](screenshots/ProfileView.png?raw=true "ProfileView")
![DarkmodeToggle](screenshots/DarkmodeToggle.png?raw=true "DarkmodeToggle")

## Future Enhancements
- **User Authentication**:
  - Add support for user accounts, enabling personalized task management and cloud sync.

- **Notifications**:
  - Implement reminders for tasks using local notifications.

- **Task Categorization**:
  - Allow users to group tasks into categories for better organization.

- **Enhanced Editing**:
  - Support for additional task details, such as due dates, priorities, and descriptions.
