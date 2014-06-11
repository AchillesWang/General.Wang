//
//  ACAuthorListController.m
//  Book_CoreData
//
//  Created by 潇翔 汪 on 14-4-13.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import "ACAuthorListController.h"
#import "ACAppDelegate.h"
#import <CoreData/CoreData.h>
#import "Author.h"
#import "ACBookListController.h"


@interface ACAuthorListController ()
{
    NSMutableArray* authorArray;
}
@property(weak,nonatomic) ACAppDelegate* appDelegate;
@end

@implementation ACAuthorListController

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
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Author"
                                              inManagedObjectContext:self.appDelegate.managedObjectContext];
    [request setEntity:entity];
    NSError* error = nil;
    authorArray = [[self.appDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (error || !authorArray) {
        NSLog(@"获取作者出错:%@,%@",error,[error userInfo]);
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return authorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"author";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Author* author = [authorArray objectAtIndex:indexPath.row];
    cell.textLabel.text = author.name;
    cell.detailTextLabel.text = author.authorDesc;
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Author* dAuthor = [authorArray objectAtIndex:indexPath.row];
        [self.appDelegate.managedObjectContext deleteObject:dAuthor];
        NSError* error = nil;
        if (![self.appDelegate.managedObjectContext save:&error]) {
            NSLog(@"错误:%@,%@",error,[error userInfo]);
        }else{
            NSLog(@"删除成功");
            [authorArray removeObject:dAuthor];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
    }
}
//-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"确认删除";
//}

- (IBAction)toggleDelete:(id)sender {
    self.tableView.editing = !self.tableView.editing;
    if (self.tableView.editing) {
        self.deleteBtm.title = @"完成";
  ; }else{
        self.deleteBtm.title = @"删除";
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//	// 如果目标视图控制器是FKBookListController
//	if ([segue.destinationViewController isMemberOfClass:
//		 [FKBookListController class]] )
//	{
//		// 获取被点击的单元格
//		UITableViewCell* cell = (UITableViewCell*)sender;
//		// 获取触发跳转的单元格所在的NSIndexPath
//		NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//		FKBookListController* bookListController = (FKBookListController*)segue
//        .destinationViewController ;
//		// 将触发跳转的单元格显示的FKAuthor对象传给下一个视图控制器
//		bookListController.selectedAuthor = [authorArray
//                                             objectAtIndex:indexPath.row]; // ②
//	}
    if ([segue.destinationViewController isMemberOfClass:[ACBookListController class]]) {
        UITableViewCell* cell = (UITableViewCell *)sender;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        ACBookListController* bookListController = segue.destinationViewController;
        bookListController.author = [authorArray objectAtIndex:indexPath.row];
    }
}

@end
