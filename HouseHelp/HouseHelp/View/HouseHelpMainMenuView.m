//
//  HouseHelpMainMenuView.m
//  HouseHelp
//
//  Created by Breakstuff on 9/20/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "HouseHelpMainMenuView.h"

@implementation HouseHelpMainMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Background
        backGroundImage = [UIImage imageNamed:@"blackground.jpg"];
        backGroundViewImage = [[UIImageView alloc] initWithImage:backGroundImage];
        // Splash screen
        splashScreen = [UIImage imageNamed:@"hhelp.png"];
        splashScreenView = [[UIImageView alloc] initWithImage:splashScreen];
        
        // Images
        imageKitchen = [UIImage imageNamed:@"kitchen.png"];
        imageGarage = [UIImage imageNamed:@"garage.png"];
        imageDining = [UIImage imageNamed:@"dining.png"];
        imageRestRoom = [UIImage imageNamed:@"bathroom.png"];
        imageLivingRoom = [UIImage imageNamed:@"living.png"];
        // Image views
        imageViewKitchen = [[UIImageView alloc] initWithImage:imageKitchen];
        imageViewGarage = [[UIImageView alloc] initWithImage:imageGarage];
        imageViewDining = [[UIImageView alloc] initWithImage:imageDining];
        imageViewRestRoom = [[UIImageView alloc] initWithImage:imageRestRoom];
        imageViewLivingRoom = [[UIImageView alloc] initWithImage:imageLivingRoom];
        backGroundViewImage.alpha = 1.0;
        splashScreenView.alpha = 0.0;
        imageViewKitchen.alpha = 0.0;
        imageViewGarage.alpha = 0.0;
        imageViewDining.alpha = 0.0;
        imageViewRestRoom.alpha = 0.0;
        imageViewLivingRoom.alpha = 0.0;
        r_adjusterx = 0;
        r_adjustery = 0;
        r_adjusterxr = 0;
        r_adjusteryr = 0;
        animate_duration = 0.5;
        flag = YES;
        flag_selected = YES;
        
        // Layouting subviews
        [self addSubview:backGroundViewImage];
        [self addSubview:splashScreenView];
        [self addSubview:imageViewKitchen];
        [self addSubview:imageViewGarage];
        [self addSubview:imageViewDining];
        [self addSubview:imageViewRestRoom];
        [self addSubview:imageViewLivingRoom];
    }
    return self;
}

- (void)layoutSubviews
{
    x = self.bounds.size.width / 2 - self.bounds.size.width * SPLASH_WIDTH / 2;
    y = self.bounds.size.height / 2 - self.bounds.size.height * SPLASH_HEIGHT / 2;
    w = self.bounds.size.width * SPLASH_WIDTH;
    h = self.bounds.size.height * SPLASH_HEIGHT;
    rx = self.bounds.size.width / 2 - self.bounds.size.height * SPLASH_WIDTH / 2;
    ry = self.bounds.size.height / 2 - self.bounds.size.width * SPLASH_HEIGHT / 2;
    rw = self.bounds.size.height * SPLASH_WIDTH;
    rh = self.bounds.size.width * SPLASH_HEIGHT;
    backGroundViewImage.frame = CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height);
    if(self.bounds.size.height > self.bounds.size.width){
            splashScreenView.frame = CGRectMake(x,y,w,h);
    }
    else{
            splashScreenView.frame = CGRectMake(rx,ry,rw,rh);
    }
    if(flag){
        [self splashScreen];
    }
    else{
        if(flag_selected){
            [self show];
        }
        else{
            if(flag_enumerations == eKitchen){
                [self animateShowKitchen];
            }
            else if(flag_enumerations == eGarage){
                [self animateShowGarage];
            }
            else if(flag_enumerations == eDining){
                [self animateShowDining];
            }
            else if(flag_enumerations == eRestRoom){
                [self animateShowRestRoom];
            }
            else if(flag_enumerations == eLivingRoom){
                [self animateShowLivingRoom];
            }
        }
    }
    //Debugging purposes
    //NSLog(@"Height: %d Width: %d X:%d Y:%d",h,w,x,y);
    //Debugging purposes
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

     UITouch *touch = [touches anyObject];
     if([touch view] == imageViewKitchen)
     {
         if(flag_selected){
             [self removeAdjuster];
             [self animateShowKitchen];
             flag_selected = NO;
             flag_enumerations = eKitchen;
         }
         else{
             [_delegate didTouchKitchen];
         }
     }
     else if([touch view] == imageViewGarage){
         if(flag_selected){
            [self removeAdjuster];
             [self animateShowGarage];
             flag_selected = NO;
             flag_enumerations = eGarage;
         }
         else{
             [_delegate didTouchGarage];
         }
     }
     else if([touch view] == imageViewDining){
         if(flag_selected){
             [self removeAdjuster];
             [self animateShowDining];
             flag_selected = NO;
             flag_enumerations = eDining;
         }
         else{
             [_delegate didTouchDiningRoom];
         }
     }
     else if([touch view] == imageViewRestRoom){
         if(flag_selected){
             [self removeAdjuster];
             [self animateShowRestRoom];
             flag_selected = NO;
             flag_enumerations = eRestRoom;
         }
         else{
             [_delegate didTouchRestRoom];
         }
     }
     else if([touch view] == imageViewLivingRoom){
         if(flag_selected){
             [self removeAdjuster];
             [self animateShowLivingRoom];
             flag_selected = NO;
             flag_enumerations = eLivingRoom;
         }
         else{
             [_delegate didTouchLivingRoom];
         }
     }
     else
     {
        [self returnAdjuster];
        [self show];
        flag = NO;
     }

}
- (void)splashScreen{

    if(self.bounds.size.height > self.bounds.size.width){
        [UIView animateWithDuration:1.0 animations:^{
            splashScreenView.alpha = 1.0;
            splashScreenView.frame = CGRectMake(x,y,w,h);
        }];
    }
    else{
        [UIView animateWithDuration:1.0 animations:^{
            splashScreenView.alpha = 1.0;
            splashScreenView.frame = CGRectMake(rx,ry,rw,rh);
        }];
    }
}

- (void)show{
    [UIView animateWithDuration:1.0 animations:^{
        splashScreenView.alpha = 0.1;
        imageViewKitchen.alpha = 1.0;
        imageViewGarage.alpha = 1.0;
        imageViewDining.alpha = 1.0;
        imageViewRestRoom.alpha = 1.0;
        imageViewLivingRoom.alpha = 1.0;
        backGroundViewImage.alpha = 0.5;
        imageViewKitchen.userInteractionEnabled = YES;
        imageViewGarage.userInteractionEnabled = YES;
        imageViewDining.userInteractionEnabled = YES;
        imageViewRestRoom.userInteractionEnabled = YES;
        imageViewLivingRoom.userInteractionEnabled = YES;
        flag_selected = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];

        [self showDiningRoomMenu];
        [self showGarageMenu];
        [self showKitchenMenu];
        [self showRestRoomMenu];
        [self showLivingRoomMenu];
    }];
}
- (void)animateShowKitchen{
    imageViewGarage.userInteractionEnabled = NO;
    imageViewDining.userInteractionEnabled = NO;
    imageViewRestRoom.userInteractionEnabled = NO;
    imageViewLivingRoom.userInteractionEnabled = NO;
    [UIView animateWithDuration:1.0 animations:^{
        imageViewGarage.alpha = 0.5;
        imageViewDining.alpha = 0.5;
        imageViewRestRoom.alpha = 0.5;
        imageViewLivingRoom.alpha = 0.5;
        backGroundViewImage.alpha = 0.3;
        imageViewKitchen.alpha = 1.0;
        [self showDiningRoomMenu];
        [self showGarageMenu];
        [self showRestRoomMenu];
        [self showLivingRoomMenu];
    }];
    [self drawAnimateKitchen];

}
- (void)animateShowGarage{
    imageViewKitchen.userInteractionEnabled = NO;
    imageViewDining.userInteractionEnabled = NO;
    imageViewRestRoom.userInteractionEnabled = NO;
    imageViewLivingRoom.userInteractionEnabled = NO;
    [UIView animateWithDuration:1.0 animations:^{
        imageViewGarage.alpha = 1.0;
        imageViewDining.alpha = 0.5;
        imageViewRestRoom.alpha = 0.5;
        imageViewLivingRoom.alpha = 0.5;
        backGroundViewImage.alpha = 0.3;
        imageViewKitchen.alpha = 0.5;
        [self showDiningRoomMenu];
        [self showKitchenMenu];
        [self showRestRoomMenu];
        [self showLivingRoomMenu];
    }];
    [self drawAnimateGarage];
}
- (void)animateShowDining{
    imageViewKitchen.userInteractionEnabled = NO;
    imageViewGarage.userInteractionEnabled = NO;
    imageViewRestRoom.userInteractionEnabled = NO;
    imageViewLivingRoom.userInteractionEnabled = NO;
    [UIView animateWithDuration:1.0 animations:^{
        imageViewGarage.alpha = 0.5;
        imageViewDining.alpha = 1.0;
        imageViewRestRoom.alpha = 0.5;
        imageViewLivingRoom.alpha = 0.5;
        backGroundViewImage.alpha = 0.3;
        imageViewKitchen.alpha = 0.5;
        [self showGarageMenu];
        [self showKitchenMenu];
        [self showRestRoomMenu];
        [self showLivingRoomMenu];
    }];
    [self drawAnimateDining];
}
- (void)animateShowRestRoom{
    imageViewKitchen.userInteractionEnabled = NO;
    imageViewDining.userInteractionEnabled = NO;
    imageViewGarage.userInteractionEnabled = NO;
    imageViewLivingRoom.userInteractionEnabled = NO;
    [UIView animateWithDuration:1.0 animations:^{
        imageViewGarage.alpha = 0.5;
        imageViewDining.alpha = 0.5;
        imageViewRestRoom.alpha = 1.0;
        imageViewLivingRoom.alpha = 0.5;
        backGroundViewImage.alpha = 0.3;
        imageViewKitchen.alpha = 0.5;
        [self showDiningRoomMenu];
        [self showKitchenMenu];
        [self showGarageMenu];
        [self showLivingRoomMenu];
    }];
    [self drawAnimateRestRoom];
}
- (void)animateShowLivingRoom{
    imageViewKitchen.userInteractionEnabled = NO;
    imageViewDining.userInteractionEnabled = NO;
    imageViewRestRoom.userInteractionEnabled = NO;
    imageViewGarage.userInteractionEnabled = NO;
    [UIView animateWithDuration:1.0 animations:^{
        imageViewGarage.alpha = 0.5;
        imageViewDining.alpha = 0.5;
        imageViewRestRoom.alpha = 0.5;
        imageViewLivingRoom.alpha = 1.0;
        backGroundViewImage.alpha = 0.3;
        imageViewKitchen.alpha = 0.5;
        [self showDiningRoomMenu];
        [self showKitchenMenu];
        [self showRestRoomMenu];
        [self showGarageMenu];
    }];
    [self drawAnimateLivingRoom];
}
- (void)showKitchenMenu{
    if(self.bounds.size.height > self.bounds.size.width){
        imageViewKitchen.frame = CGRectMake(
            (self.bounds.size.width / 2) - (self.bounds.size.height * MMICON_HEIGHT) / 2,
            (self.bounds.size.width * MMICON_WIDTH) + ADJUSTERY - r_adjustery,
            self.bounds.size.height * MMICON_HEIGHT,
            self.bounds.size.width * MMICON_WIDTH);
    }
    else{
        imageViewKitchen.frame = CGRectMake(
            self.bounds.size.width / 2 - (self.bounds.size.height * MMICON_HEIGHT) / 2,
            self.bounds.size.height * MMICON_HEIGHT + ADJUSTERYR - r_adjusteryr,
            self.bounds.size.width * MMICON_HEIGHT,
            self.bounds.size.height * MMICON_WIDTH);
    }
}
- (void)showGarageMenu{
    if(self.bounds.size.height > self.bounds.size.width){
        imageViewGarage.frame = CGRectMake(
            self.bounds.size.width * IMAGEX2 + ADJUSTERX - r_adjusterx,
            self.bounds.size.height / 2 + self.bounds.size.height * IMAGEY2 +(self.bounds.size.height * MMICON_HEIGHT) / 2 + (self.bounds.size.height * MMICON_HEIGHT) - ADJUSTERY + r_adjustery,
            self.bounds.size.height * MMICON_HEIGHT,
            self.bounds.size.width * MMICON_WIDTH);
    }
    else{
        imageViewGarage.frame = CGRectMake(
            self.bounds.size.width * IMAGEX2 + ADJUSTERXR - r_adjusterxr,
            self.bounds.size.height / 2 - (self.bounds.size.width * MMICON_WIDTH) / 2 + (self.bounds.size.width * MMICON_WIDTH) - ADJUSTERYR + r_adjusteryr,
            self.bounds.size.width * MMICON_HEIGHT,
            self.bounds.size.height * MMICON_WIDTH);
    }
}
- (void)showDiningRoomMenu{
    if(self.bounds.size.height > self.bounds.size.width){
        imageViewDining.frame = CGRectMake(
            self.bounds.size.width * IMAGEX1 + ADJUSTERX - r_adjusterx,
            self.bounds.size.height / 2 - (self.bounds.size.height * MMICON_HEIGHT) / 2,
            self.bounds.size.height * MMICON_HEIGHT,
            self.bounds.size.width * MMICON_WIDTH);
    }
    else{
        imageViewDining.frame = CGRectMake(
            self.bounds.size.width * IMAGEX1 + ADJUSTERXR - r_adjusterxr,
            self.bounds.size.height / 2 - (self.bounds.size.width * MMICON_WIDTH) / 2,
            self.bounds.size.width * MMICON_HEIGHT,
            self.bounds.size.height * MMICON_WIDTH);
    }

}
- (void)showRestRoomMenu{
    if(self.bounds.size.height > self.bounds.size.width){
        imageViewRestRoom.frame = CGRectMake(
            self.bounds.size.width * IMAGEX4 - self.bounds.size.height * MMICON_HEIGHT - ADJUSTERX + r_adjusterx,
            self.bounds.size.height / 2 - (self.bounds.size.height * MMICON_HEIGHT) / 2,
            self.bounds.size.height * MMICON_HEIGHT,
            self.bounds.size.width * MMICON_WIDTH);
    }
    else{
        imageViewRestRoom.frame = CGRectMake(
            self.bounds.size.width * IMAGEX4 - self.bounds.size.width * MMICON_HEIGHT - ADJUSTERXR + r_adjusterxr,
            self.bounds.size.height / 2 - (self.bounds.size.width * MMICON_WIDTH) / 2,
            self.bounds.size.width * MMICON_HEIGHT,
            self.bounds.size.height * MMICON_WIDTH);
    }

}
- (void)showLivingRoomMenu{
    if(self.bounds.size.height > self.bounds.size.width){
        imageViewLivingRoom.frame = CGRectMake(
            self.bounds.size.width * IMAGEX5 - self.bounds.size.height *MMICON_HEIGHT - ADJUSTERX + r_adjusterx,
            self.bounds.size.height / 2 + self.bounds.size.height * IMAGEY2 +(self.bounds.size.height * MMICON_HEIGHT) / 2 + (self.bounds.size.height * MMICON_HEIGHT) - ADJUSTERY + r_adjustery,
            self.bounds.size.height * MMICON_HEIGHT,
            self.bounds.size.width * MMICON_WIDTH);
    }
    else{
        imageViewLivingRoom.frame = CGRectMake(
            self.bounds.size.width * IMAGEX5 - self.bounds.size.width * MMICON_HEIGHT - ADJUSTERXR + r_adjusterxr,
            self.bounds.size.height / 2 - (self.bounds.size.width * MMICON_WIDTH) / 2 + (self.bounds.size.width * MMICON_WIDTH) - ADJUSTERYR + r_adjusteryr,
            self.bounds.size.width * MMICON_HEIGHT,
            self.bounds.size.height * MMICON_WIDTH);
    }
}
- (void)drawAnimateKitchen{
    if(self.bounds.size.height > self.bounds.size.width){
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewKitchen.frame = CGRectMake(x,y,w,h);
        }];
    }
    else{
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewKitchen.frame = CGRectMake(rx,ry,rw,rh);
        }];
    }
}
- (void)drawAnimateGarage{
    if(self.bounds.size.height > self.bounds.size.width){
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewGarage.frame = CGRectMake(x,y,w,h);
        }];
    }
    else{
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewGarage.frame = CGRectMake(rx,ry,rw,rh);
        }];
    }
}
- (void)drawAnimateDining{
    if(self.bounds.size.height > self.bounds.size.width){
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewDining.frame = CGRectMake(x,y,w,h);
        }];
    }
    else{
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewDining.frame = CGRectMake(rx,ry,rw,rh);
        }];
    }
}
- (void)drawAnimateRestRoom{
    if(self.bounds.size.height > self.bounds.size.width){
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewRestRoom.frame = CGRectMake(x,y,w,h);
        }];
    }
    else{
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewRestRoom.frame = CGRectMake(rx,ry,rw,rh);
        }];
    }
}
- (void)drawAnimateLivingRoom{
    if(self.bounds.size.height > self.bounds.size.width){
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewLivingRoom.frame = CGRectMake(x,y,w,h);
        }];
    }
    else{
        [UIView animateWithDuration:animate_duration animations:^{
            imageViewLivingRoom.frame = CGRectMake(rx,ry,rw,rh);
        }];
    }
}
- (void)removeAdjuster{
    r_adjusterx = 20;
    r_adjustery = 25;
    r_adjusterxr = 35;
    r_adjusteryr = 15;
}
- (void)returnAdjuster{
    r_adjusterx = 0;
    r_adjustery = 0;
    r_adjusterxr = 0;
    r_adjusteryr = 0;
}
@end
