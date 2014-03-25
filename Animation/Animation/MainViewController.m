//
//  MainViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "MainViewController.h"
#import "AViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,AViewControllerDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray* cellContent;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"坑爹...";
    _cellContent = @[@"SpringAnimationViewController",
                     @"KeyFrameViewController",
                     @"TransitionViewController",
                     @"PointerViewController",
                     @"KeyFrameSpriteViewController",
                     @"CustomAnimatableProperty",
                     @"GroupedAnimationViewController",
                     @"LayerTranstionController",
                     @"ActionsViewController",
                     @"CAEmitterCellController",
                     @"CIFilterAniamtionController",
                     @"DynamicsController"];
    [_tableView registerClass:[UITableViewCell class]
       forCellReuseIdentifier:CellIdentifier];
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.cellContent[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class keyFrameViewControllerClass = NSClassFromString(_cellContent[indexPath.row]);
    if (keyFrameViewControllerClass) {
        AViewController* obj = [[keyFrameViewControllerClass alloc] init];
        
        obj.aDelegate = self;
        
        [self presentViewController:obj
                           animated:YES
                         completion:nil];
        
    }
}
-(void)backup:(id)content fromController:(UIViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
