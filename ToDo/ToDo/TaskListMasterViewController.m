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
    NSMutableArray *_flags; //True for finished tasks. 
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

    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    
    if(_flags[indexPath.row] == [NSNumber numberWithBool:YES]) //If a task is finished.
    {
        cell.textLabel.textColor = [UIColor redColor];
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attrText = [[NSAttributedString alloc] initWithString:cell.textLabel.text attributes:attributes];
        cell.textLabel.attributedText = attrText;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else                    //The task is unfinished.
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text =[[NSString alloc]initWithString:cell.textLabel.text];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //NSString *object = _tasks[indexPath.row][0];

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
        [_flags removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
                                                                    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //If the task was marked completed, mark it is incomplete and return it to natural text.  
    if(_flags[indexPath.row] == [NSNumber numberWithBool:YES])
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.text =[[NSString alloc]initWithString:cell.textLabel.text];
        cell.accessoryType = UITableViewCellAccessoryNone;
        _flags[indexPath.row] = [NSNumber numberWithBool:NO];
    }
    else    // Or, if the task is now incomplete, we color it red and strikethrough it.
            // We also turn on the checkmark.
    {
        cell.textLabel.textColor = [UIColor redColor];
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attrText = [[NSAttributedString alloc] initWithString:cell.textLabel.text attributes:attributes];
        cell.textLabel.attributedText = attrText;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _flags[indexPath.row] = [NSNumber numberWithBool:YES];
    }
  
}
//This should only be called for User-Generated New tasks. 
- (void)insertNewObject:(NSString*) str
{
    if (!_objects){
        _objects = [[NSMutableArray alloc] init];
    }
    
    if (!_flags){
        _flags = [[NSMutableArray alloc] init];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_objects.count inSection:0];
    [_objects insertObject:[NSString stringWithString:(str)] atIndex:_objects.count];
    [_flags addObject:[NSNumber numberWithBool:NO]];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullpath1 = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSString *fullpath2 = [documentsDirectory stringByAppendingPathComponent:@"flags.plist"];
    NSLog(@"Reading Data");
    NSMutableArray *arrayFromDisk1  = [NSKeyedUnarchiver unarchiveObjectWithFile:fullpath1];
    NSMutableArray *arrayFromDisk2 = [NSKeyedUnarchiver unarchiveObjectWithFile:fullpath2];
    
    
    _objects = [[NSMutableArray alloc] initWithArray:arrayFromDisk1];
    _flags = [[NSMutableArray alloc] initWithArray:arrayFromDisk2];
    
    if(_objects.count > 0)
    {
        int a = 0;
        for(;a<_objects.count; a++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:a inSection:0];
            [self.tableView cellForRowAtIndexPath:indexPath];
        }
        
    }
    
    
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
    NSString *fullpath1 = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSString *fullpath2 = [documentsDirectory stringByAppendingPathComponent:@"flags.plist"];
    
    NSMutableArray *dataToFile = [[NSMutableArray alloc] initWithArray:_objects];
    NSMutableArray *flagsToFile = [[NSMutableArray alloc] initWithArray:_flags];

    
    NSLog(@"Writing Data");
    [NSKeyedArchiver archiveRootObject:dataToFile toFile:fullpath1];
    [NSKeyedArchiver archiveRootObject:flagsToFile toFile:fullpath2];
    
}

         

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}




@end
