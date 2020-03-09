//
//  HouseHelpMainMenuView.h
//  HouseHelp
//
//  Created by Breakstuff on 9/20/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseHelpMainMenuDelegate.h"
#define SPLASH_HEIGHT .35
#define SPLASH_WIDTH .45
#define MMICON_HEIGHT .13
#define MMICON_WIDTH .20

#define IMAGEX1 .05
#define IMAGEX2 .15
#define IMAGEX3 .25
#define IMAGEX4 .95
#define IMAGEX5 .85

#define IMAGEY1 .00
#define IMAGEY2 .05
#define IMAGEY3 .25
#define IMAGEY4 .35
#define IMAGEY5 .95

#define ADJUSTERX 20
#define ADJUSTERY 30
#define ADJUSTERXR 35
#define ADJUSTERYR 17
@interface HouseHelpMainMenuView : UIView
{
    //background image
    UIImage* backGroundImage;
    UIImageView* backGroundViewImage;
    //^background image
    
    //splash screen
    UIImage* splashScreen;
    UIImageView* splashScreenView;
    //^splash screen
    
    //main menu objects
    UIImage* imageKitchen;
    UIImage* imageGarage;
    UIImage* imageDining;
    UIImage* imageRestRoom;
    UIImage* imageLivingRoom;
    
    UIImageView* imageViewDining;
    UIImageView* imageViewKitchen;
    UIImageView* imageViewGarage;
    UIImageView* imageViewRestRoom;
    UIImageView* imageViewLivingRoom;
    //^main menu objects
    float r_adjusterx;
    float r_adjustery;
    float r_adjusterxr;
    float r_adjusteryr;
    float x,y,w,h;
    float rx,ry,rw,rh;
    int flag_enumerations;
    BOOL flag;
    BOOL flag_selected;
    float animate_duration;
    enum{eKitchen,eGarage,eDining,eRestRoom,eLivingRoom} HHEnum;
}
@property id <HouseHelpMainMenuDelegate> delegate;
- (void)splashScreen;
- (void)show;
- (void)animateShowKitchen;
- (void)animateShowGarage;
- (void)animateShowDining;
- (void)animateShowRestRoom;
- (void)animateShowLivingRoom;
- (void)showKitchenMenu;
- (void)showGarageMenu;
- (void)showDiningRoomMenu;
- (void)showRestRoomMenu;
- (void)showLivingRoomMenu;

- (void)drawAnimateKitchen;
- (void)drawAnimateGarage;
- (void)drawAnimateDining;
- (void)drawAnimateRestRoom;
- (void)drawAnimateLivingRoom;
- (void)removeAdjuster;
- (void)returnAdjuster;
@end
