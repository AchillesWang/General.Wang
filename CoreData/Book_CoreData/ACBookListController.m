//
//  ACBookListController.m
//  Book_CoreData
//
//  Created by 汪潇翔 on 14-4-14.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import "ACBookListController.h"
#import <CoreData/CoreData.h>
#import "ACAppDelegate.h"
#import "ACAddBookController.h"
#import "Book.h"



@interface ACBookListController ()
{
    NSMutableArray* bookArray;
}
@property (nonatomic,weak)ACAppDelegate *appDelegate;
@end

@implementation ACBookListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDelegate = [UIApplication sharedApplication].delegate;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"正在获取...");
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    NSEntityDescription* desc = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:desc];
    request.predicate = [NSPredicate predicateWithFormat:@"author=%@",self.author];
    NSError* error = nil;
    bookArray = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!bookArray||error) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
        abort();
    }
    [self.tableView reloadData];
    NSLog(@"获取完成！");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return bookArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"book";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Book* book = [bookArray objectAtIndex:indexPath.row];
    cell.textLabel.text = book.name;
    cell.detailTextLabel.text = book.publishHouse;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isMemberOfClass:[ACAddBookController class]]) {
        ACAddBookController* addBookController = segue.destinationViewController;
        addBookController.author = self.author;
    }
}


@end
