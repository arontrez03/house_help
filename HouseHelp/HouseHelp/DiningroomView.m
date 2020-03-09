//
//  diningRoom.m
//  HouseHelp
//
//  Created by macuser on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "DiningroomView.h"

@implementation DiningroomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        flag = YES;
        tipOfTheDayLabel = [[UILabel alloc] init];
        tipOfTheDayLabel.text = @"Tip of the Day";
        tipOfTheDayLabel.textColor = [UIColor blackColor];
        tipOfTheDayLabel.backgroundColor = [UIColor clearColor];
        tipOfTheDayLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        [tipOfTheDayLabel sizeToFit];
        tipOfTheDayLabel.alpha = 1.0;
        
        tipArray = [[DatabaseHandler getSharedInstance]getTips:@"2"];
        NSLog(@"%d",[tipArray count]);
        int random = arc4random()%[tipArray count];
        TipsHandler* drh = [[TipsHandler alloc] init];
        drh = [tipArray objectAtIndex:random];
        
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = drh.tip_name;
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        //[tipLabel setLineBreakMode:NSLineBreakByWordWrapping];
        tipLabel.numberOfLines = 0;
        [tipLabel sizeToFit];
        
        backGroundImage = [UIImage imageNamed:@"woodtexture.jpg"];
        backGroundImageView = [[UIImageView alloc] initWithImage:backGroundImage];
        backGroundImageView.alpha = 0.85;
        iconImage = [UIImage imageNamed:@"dining.png"];
        iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.alpha = 0.4;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:backGroundImageView];
        [self addSubview:iconImageView];
        [self addSubview:tipOfTheDayLabel];
        [self addSubview:tipLabel];
        [self addSubview:randomizeButton];
    }
    return self;
}

- (void)layoutSubviews{
    x = self.bounds.size.width / 2 - self.bounds.size.width * SPLASH_WIDTH / 2;
    y = self.bounds.size.height / 2 - self.bounds.size.height * SPLASH_HEIGHT / 2;
    w = self.bounds.size.width * SPLASH_WIDTH;
    h = self.bounds.size.height * SPLASH_HEIGHT;
    rx = self.bounds.size.width / 2 - self.bounds.size.height * SPLASH_WIDTH / 2;
    ry = self.bounds.size.height / 2 - self.bounds.size.width * SPLASH_HEIGHT / 2;
    rw = self.bounds.size.height * SPLASH_WIDTH;
    rh = self.bounds.size.width * SPLASH_HEIGHT;
    head_center_x = self.bounds.size.width / 2;
    backGroundImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height
                                           );
    if(self.bounds.size.height > self.bounds.size.width){
        head_image_height = self.bounds.size.height * HDICON_HEIGHT;
        head_image_width = self.bounds.size.width * HDICON_WIDTH;
        tabbar_image_height = self.bounds.size.height * TBICON_HEIGHT;
        tabbar_image_width = self.bounds.size.width * TBICON_WIDTH;
        header_size = self.bounds.size.height * LABEL_HEADER;
        textfield_size = self.bounds.size.height * LABEL_TEXTFIELD;
        title_size = self.bounds.size.height * LABEL_TITLE;
    }
    else{
        head_image_height = self.bounds.size.width * HDICON_HEIGHT;
        head_image_width = self.bounds.size.height * HDICON_WIDTH;
        tabbar_image_height = self.bounds.size.width * TBICON_HEIGHT;
        tabbar_image_width = self.bounds.size.height * TBICON_WIDTH;
        header_size = self.bounds.size.width * LABEL_HEADER;
        textfield_size = self.bounds.size.width * LABEL_TEXTFIELD;
        title_size = self.bounds.size.width * LABEL_TITLE;
    }
    CGSize maxSize = CGSizeMake(self.bounds.size.width - SPACE_X * 4, CGFLOAT_MAX);
    CGSize requiredSize = [tipLabel sizeThatFits:maxSize];
    
    tipLabel.frame = CGRectMake(head_center_x - requiredSize.width / 2,
                                SPACE_Y + tipOfTheDayLabel.bounds.size.height,
                                requiredSize.width,
                                requiredSize.height);
    
    tipOfTheDayLabel.frame = CGRectMake(head_center_x - tipOfTheDayLabel.bounds.size.width / 2,0,tipOfTheDayLabel.bounds.size.width,tipOfTheDayLabel.bounds.size.height);
    
    
    randomizeButton.frame = CGRectMake(head_center_x - (randomizeButton.self.bounds.size.width/2), requiredSize.height+SPACE_Y + tipOfTheDayLabel.bounds.size.height,randomizeButton.self.bounds.size.width,randomizeButton.self.bounds.size.height);
    
    [self drawMiddleIcon];
}
- (void)drawMiddleIcon{
    if(self.bounds.size.height > self.bounds.size.width){
        iconImageView.frame = CGRectMake(x, y, w, h);
        
    }
    else{
        iconImageView.frame = CGRectMake(rx, ry, rw, rh);
        
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    int random = arc4random()%[tipArray count];
    TipsHandler* drh = [[TipsHandler alloc] init];
    drh = [tipArray objectAtIndex:random];
    tipLabel.text = drh.tip_name;
    
}



@end
