//
//  GarageView.m
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "GarageView.h"

@implementation GarageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        flag = YES;
        tipOfTheDayLabel = [[UILabel alloc] init];
        tipOfTheDayLabel.text = @"Tip of the Day";
        tipOfTheDayLabel.textColor = [UIColor blackColor];
        
        tipOfTheDayLabel.alpha = 1.0;
        testScrollView = [[UIScrollView alloc] init];
        testScrollView.backgroundColor = [UIColor clearColor];
        testScrollView.showsVerticalScrollIndicator = YES;
        testScrollView.showsHorizontalScrollIndicator = YES;
        testScrollView.scrollEnabled = YES;
        tipArray = [[DatabaseHandler getSharedInstance]getTips:@"5"];
        int random = arc4random()%[tipArray count];
        TipsHandler* th = [[TipsHandler alloc] init];
        th = [tipArray objectAtIndex:random];
        tipLabel = [[UILabel alloc] init];
        tipLabel.text = @"Garage";
        tipLabel.textColor = [UIColor blackColor];
        
        tipDescription = [[UILabel alloc] init];
        tipDescription.text = th.tip_name;
        tipDescription.textColor = [UIColor blackColor];
        tipDescription.font = [UIFont fontWithName:@"Helvetica" size:18];
        [tipDescription sizeToFit];
        //self.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:0.8];
        glossaryIconImage = [UIImage imageNamed:@"glossary.png"];
        glossaryIconImageView = [[UIImageView alloc] initWithImage:glossaryIconImage];
        glossaryIconImageView.userInteractionEnabled = YES;
        backGroundImage = [UIImage imageNamed:@"woodtexture.jpg"];
        backGroundImageView = [[UIImageView alloc] initWithImage:backGroundImage];
        backGroundImageView.alpha = 0.85;
        iconImage = [UIImage imageNamed:@"garage.png"];
        iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.alpha = 0.4;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundImageView];
        [self addSubview:iconImageView];
        //[self addSubview:glossaryIconImageView];
        [self addSubview:tipOfTheDayLabel];
        //[self addSubview:tipLabel];
        [self addSubview:tipDescription];

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
    tipOfTheDayLabel.font = [UIFont fontWithName:@"Helvetica" size:header_size];
    [tipOfTheDayLabel sizeToFit];
    tipLabel.font = [UIFont fontWithName:@"Helvetica" size:title_size];
    [tipLabel sizeToFit];
    tipOfTheDayLabel.frame = CGRectMake(head_center_x - tipOfTheDayLabel.bounds.size.width / 2,0,tipOfTheDayLabel.bounds.size.width,tipOfTheDayLabel.bounds.size.height);
    [self drawHeader];
    [self drawRecipeDesc];
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
    TipsHandler* th = [[TipsHandler alloc] init];
    th = [tipArray objectAtIndex:random];
    tipDescription.text = th.tip_name;
    [self layoutSubviews];
}
- (void)drawScrollView{
    testScrollView.frame = CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height - _tabbarsize.height );
    testScrollView.contentSize = CGSizeMake(self.bounds.size.width,self.bounds.size.height);
}
- (void)drawHeader{
    [tipLabel sizeToFit];
    tipLabel.frame = CGRectMake(head_center_x - tipLabel.bounds.size.width / 2,
                                   SPACE_Y + tipOfTheDayLabel.bounds.size.height,
                                   tipLabel.bounds.size.width,
                                   tipLabel.bounds.size.height);
    //kitchenTipsImageView.frame = CGRectMake(head_center_x - head_image_width / 2  - whatToCookLabel.bounds.size.width / 2 - SPACE_X , SPACE_Y, head_image_width, head_image_height);
}
- (void)drawRecipeDesc{
    [tipDescription setPreferredMaxLayoutWidth:self.bounds.size.width];
    [tipDescription setNumberOfLines:0];
    CGSize maxSize = CGSizeMake(self.bounds.size.width - SPACE_X * 4,CGFLOAT_MAX);
    CGSize requiredSize = [tipDescription sizeThatFits:maxSize];
    
    tipDescription.frame = CGRectMake(SPACE_X , SPACE_Y + tipOfTheDayLabel.bounds.size.height, requiredSize.width, requiredSize.height);
}

- (void)drawIconImage{
    addIconImageView.frame = CGRectMake(0,
                                        self.bounds.size.height - tabbar_image_height - _tabbarsize.height,
                                        tabbar_image_width,
                                        tabbar_image_height);
    glossaryIconImageView.frame = CGRectMake(tabbar_image_width,
                                             self.bounds.size.height - tabbar_image_height - _tabbarsize.height,
                                             tabbar_image_width,
                                             tabbar_image_height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
