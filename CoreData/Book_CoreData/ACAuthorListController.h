//
//  ACAuthorListController.h
//  Book_CoreData
//
//  Created by 潇翔 汪 on 14-4-13.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACAuthorListController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBtm;
- (IBAction)toggleDelete:(id)sender;


@end
