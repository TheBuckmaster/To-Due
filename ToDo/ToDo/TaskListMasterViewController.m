//
//  TaskListMasterViewController.m
//  ToDo
//
//  Created by BENJAMIN BUCKMASTER on 1/31/13.
//  Copyright (c) 2013 BENJAMIN BUCKMASTER. All rights reserved.
//

#import "TaskListMasterViewController.h"
#import "TaskListViewController.h"

@interface TaskListMasterViewController () {
    NSMutableArray *_objects;
}
@end




@implementation TaskListMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = _objects[indexPath.row];
    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
                                                                    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Selected Cell");
    
            //When we select a cell, we if its text is colored red, we return it to normal. 
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.textLabel.textColor == [UIColor redColor])
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text =[[NSString alloc]initWithString:cell.textLabel.text];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else    // Or, if its text is not red, we color it red and strikethrough it. We also turn on the checkmark.
    {
        cell.textLabel.textColor = [UIColor redColor];
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attrText = [[NSAttributedString alloc] initWithString:cell.textLabel.text attributes:attributes];
        cell.textLabel.attributedText = attrText;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
  
}

- (void)insertNewObject:(NSString*) str
{
    if (!_objects){
        _objects = [[NSMutableArray alloc] init];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_objects.count inSection:0];
       [_objects insertObject:[NSString stringWithString:(str)] atIndex:_objects.count];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:)name:UIApplicationDidEnterBackgroundNotification object:app];

    
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"])
         {
             TaskListViewController *addController = [segue sourceViewController];
             if(addController.string)
             {
                 //NSLog(addController.string);
                 [self insertNewObject:addController.string];

             }
         }
         
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
        if ([[segue identifier] isEqualToString:@"CancelInput"])
        {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
}

- (void)applicationDidEnterBackground:(NSNotification *) notification{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullpath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
}
         
         
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
