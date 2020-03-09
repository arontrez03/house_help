//
//  HouseHelpMainMenuDelegate.h
//  HouseHelp
//
//  Created by Breakstuff on 9/22/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HouseHelpMainMenuDelegate <NSObject>
- (void)didTouchKitchen;
- (void)didTouchGarage;
- (void)didTouchLivingRoom;
- (void)didTouchDiningRoom;
- (void)didTouchRestRoom;
@end
