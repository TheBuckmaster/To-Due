To-Due [sic]
======

This application duplicates the functionality from [this video](http://www.youtube.com/watch?v=WsdY60D4IUQ). It is completed in fulfilment of an assignment for Professor Donald Curtis's Spring 2013 iPhone App development Course. The title was chosen by professor Curtis. 

User-generated tasks are stored and displayed in a list. If the user selects one of the tasks, it is struck through, colored red, and marked with a checkmark. The application stores data in two files if it enters the background, and loads from these input files when it restarts. 

The application stores the tasks in two simple arrays of type NSMutableArray; _objects and _flags. _objects stores the raw string which is the user's labeling of the task to be completed ("Task #1, etc.). _flags stores whether a task has been marked as completed. Each of these arrays is local to the View Controller (i.e. TaskListViewController.m) and action which modifies the arrays is ultimately the determination of what the user sees. Each array is associated with a file that is written (data.plist and flags.plist) when the application enters the background. 
