//
//  KitchenView.m
//  HouseHelp
//
//  Created by Breakstuff on 9/22/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "KitchenView.h"

@implementation KitchenView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        flag = YES;
        recipeOfTheDayLabel = [[UILabel alloc] init];
        recipeOfTheDayLabel.text = @"Recipe of the Day";
        recipeOfTheDayLabel.textColor = [UIColor blackColor];

        recipeOfTheDayLabel.alpha = 1.0;
        testScrollView = [[UIScrollView alloc] init];
        testScrollView.backgroundColor = [UIColor clearColor];
        testScrollView.showsVerticalScrollIndicator = YES;
        testScrollView.showsHorizontalScrollIndicator = YES;
        testScrollView.scrollEnabled = YES;
        recipeArray = [[DatabaseHandler getSharedInstance]getRecipes];
        int random = arc4random()%[recipeArray count];
        DistinctRecipesHandler* drh = [[DistinctRecipesHandler alloc] init];
        drh = [recipeArray objectAtIndex:random];
        recipeLabel = [[UILabel alloc] init];
        recipeLabel.text = drh.recipes;
        recipeLabel.textColor = [UIColor blackColor];

        recipeDescription = [[UILabel alloc] init];
        recipeDescription.text = drh.recipe_description;
        recipeDescription.textColor = [UIColor blackColor];
        recipeDescription.font = [UIFont fontWithName:@"Helvetica" size:15];
        [recipeDescription sizeToFit];
        //self.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:0.8];
        addIconImage = [UIImage imageNamed:@"addicon.png"];
        addIconImageView = [[UIImageView alloc] initWithImage:addIconImage];
        addIconImageView.userInteractionEnabled = YES;
        glossaryIconImage = [UIImage imageNamed:@"glossary.png"];
        glossaryIconImageView = [[UIImageView alloc] initWithImage:glossaryIconImage];
        glossaryIconImageView.userInteractionEnabled = YES;
        backGroundImage = [UIImage imageNamed:@"woodtexture.jpg"];
        backGroundImageView = [[UIImageView alloc] initWithImage:backGroundImage];
        backGroundImageView.alpha = 0.85;
        iconImage = [UIImage imageNamed:@"kitchen.png"];
        iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.alpha = 0.4;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundImageView];
        [self addSubview:iconImageView];
        [self addSubview:testScrollView];
        [self addSubview:addIconImageView];
        //[self addSubview:glossaryIconImageView];
        [testScrollView addSubview:recipeOfTheDayLabel];
        [testScrollView addSubview:recipeLabel];
        [testScrollView addSubview:recipeDescription];
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
    recipeOfTheDayLabel.font = [UIFont fontWithName:@"Helvetica" size:header_size];
    [recipeOfTheDayLabel sizeToFit];
    recipeLabel.font = [UIFont fontWithName:@"Helvetica" size:title_size];
    [recipeLabel sizeToFit];
    recipeOfTheDayLabel.frame = CGRectMake(head_center_x - recipeOfTheDayLabel.bounds.size.width / 2,0,recipeOfTheDayLabel.bounds.size.width,recipeOfTheDayLabel.bounds.size.height);
    [self drawScrollView];
    [self drawIconImage];
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
    
    UITouch *touch = [touches anyObject];
    if([touch view] == addIconImageView)
    {
        [_delegate didTouchAddRecipe];
    }
}
- (void)drawScrollView{
    testScrollView.frame = CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height - _tabbarsize.height );
    testScrollView.contentSize = CGSizeMake(self.bounds.size.width,self.bounds.size.height);
}
- (void)drawHeader{
    [recipeLabel sizeToFit];
    recipeLabel.frame = CGRectMake(head_center_x - recipeLabel.bounds.size.width / 2,
                                   SPACE_Y + recipeOfTheDayLabel.bounds.size.height,
                                   recipeLabel.bounds.size.width,
                                   recipeLabel.bounds.size.height);
    //kitchenTipsImageView.frame = CGRectMake(head_center_x - head_image_width / 2  - whatToCookLabel.bounds.size.width / 2 - SPACE_X , SPACE_Y, head_image_width, head_image_height);
}
- (void)drawRecipeDesc{
    [recipeDescription setPreferredMaxLayoutWidth:self.bounds.size.width];
    [recipeDescription setNumberOfLines:0];
    CGSize maxSize = CGSizeMake(self.bounds.size.width - SPACE_X * 4,CGFLOAT_MAX);
    CGSize requiredSize = [recipeDescription sizeThatFits:maxSize];
    
    recipeDescription.frame = CGRectMake(SPACE_X , SPACE_Y * 3 + recipeLabel.bounds.size.height + recipeOfTheDayLabel.bounds.size.height, requiredSize.width, requiredSize.height);
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
- (void)trigSuccess:(NSString *)recipeName{
    alertSuccess = [[UIAlertView alloc] initWithTitle:@":)" message:[NSString stringWithFormat:@"You have successfully created recipe %@",recipeName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alertSuccess.delegate = self;
    [alertSuccess setTag:1];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        
    }
}*/
@end
