//
//  NTAppDelegate.m
//  PageController01
//
//  Created by 潇翔 汪 on 14-3-24.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTAppDelegate.h"
#import "NTPep.h"

@interface NTAppDelegate ()<UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray* pep;
@end


@implementation NTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self setUpPageViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void) setUpPageViewController
{
    self.pep = @[@"lzl",@"jlm",@"xyx"];
    NSLog(@"你妹...");
    UIPageViewController* pvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                              options:@{UIPageViewControllerOptionInterPageSpacingKey:@(20)}];
    NTPep* pep = [[NTPep alloc] initWithPepBoy:_pep[0] nib:nil bundle:nil];
    
    [pvc setViewControllers:@[pep]
                  direction:UIPageViewControllerNavigationDirectionForward
                   animated:YES
                 completion:nil];
    
    pvc.dataSource = self;
    
    self.window.rootViewController = pvc;
    
    UIPageControl* proxy = [UIPageControl appearanceWhenContainedIn:[UIPageViewController class], nil];
    [proxy setPageIndicatorTintColor:[[UIColor redColor] colorWithAlphaComponent:0.6]];
    [proxy setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [proxy setBackgroundColor:[UIColor yellowColor]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"before %@", viewController);
    NSString* boy = [(NTPep*)viewController boy];
    NSUInteger ix = [self.pep indexOfObject:boy];
    if (ix == 0)
        return nil;
    return [[NTPep alloc] initWithPepBoy:(self.pep)[--ix] nib: nil bundle: nil];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"after %@", viewController);
    NSString* boy = [(NTPep*)viewController boy];
    NSUInteger ix = [self.pep indexOfObject:boy];
    ix++;
    if (ix >= [self.pep count])
        return nil;
    return [[NTPep alloc] initWithPepBoy:(self.pep)[ix] nib: nil bundle: nil];
}
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pvc {
    return [self.pep count];
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pvc {
    NTPep* page = [pvc viewControllers][0];
    NSString* boy = page.boy;
    return [self.pep indexOfObject:boy];
}

@end
