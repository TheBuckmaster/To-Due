//
//  TaskListMasterViewController.h
//  ToDo
//
//  Created by BENJAMIN BUCKMASTER on 1/31/13.
//  Copyright (c) 2013 BENJAMIN BUCKMASTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListMasterViewController : UITableViewController
- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
