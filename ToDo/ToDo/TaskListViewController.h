//
//  TaskListViewController.h
//  ToDo
//
//  Created by BENJAMIN BUCKMASTER on 1/31/13.
//  Copyright (c) 2013 BENJAMIN BUCKMASTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *taskNameInput;
@property (strong, nonatomic) NSString *string;
@end
