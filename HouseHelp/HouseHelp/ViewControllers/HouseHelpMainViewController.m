//
//  HouseHelpMainViewController.m
//  HouseHelp
//
//  Created by Breakstuff on 9/20/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "HouseHelpMainViewController.h"


@implementation HouseHelpMainViewController

- (void)loadView
{
    HouseHelpMainMenuView* hhMainMenuView = [[HouseHelpMainMenuView alloc] init];
    hhMainMenuView.delegate = self;
    self.view = hhMainMenuView;
}

- (void)didTouchKitchen{
//    KitchenViewController* kvc = [[KitchenViewController alloc] init];
//    [self presentViewController:kvc animated:YES completion:nil];
    KitchenTabBarController* ktbc = [[KitchenTabBarController alloc] init];
    [self presentViewController:ktbc animated:YES completion:nil];
}
- (void)didTouchGarage{
    GarageTabBarController* gtbc = [[GarageTabBarController alloc] init];
    [self presentViewController:gtbc animated:YES completion:nil];
}
- (void)didTouchLivingRoom{
    LivingroomTabBarController* ltbc = [[LivingroomTabBarController alloc] init];
    [self presentViewController:ltbc animated:YES completion:nil];
}
- (void)didTouchDiningRoom{
    DiningroomTabBarController* dtbc = [[DiningroomTabBarController alloc] init];
    [self presentViewController:dtbc animated:YES completion:nil];
}
- (void)didTouchRestRoom{
    RestroomTabBarController* rtbc = [[RestroomTabBarController alloc] init];
    [self presentViewController:rtbc animated:YES completion:nil];
}
@end
