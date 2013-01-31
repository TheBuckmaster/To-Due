//
//  TaskListDetailViewController.h
//  ToDo
//
//  Created by BENJAMIN BUCKMASTER on 1/31/13.
//  Copyright (c) 2013 BENJAMIN BUCKMASTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
