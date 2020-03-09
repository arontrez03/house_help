//
//  RecipesView.m
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "RecipesView.h"

@implementation RecipesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithRecipe:(NSString*) recipeName{
    self = [super init];
    if(self){
        previousImage = [UIImage imageNamed:@"previous.png"];
        previousImageView = [[UIImageView alloc]initWithImage:previousImage];
        previousImageView.alpha = 0.5;
        recipeLabel = [[UILabel alloc] init];
        recipeLabel.text = recipeName;
        recipeLabel.textColor = [UIColor blackColor];
        recipeLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        [recipeLabel sizeToFit];
        
        ingredientsLabel = [[UILabel alloc] init];
        ingredientsLabel.text = @"Ingredients:";
        ingredientsLabel.textColor = [UIColor blackColor];
        ingredientsLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        [ingredientsLabel sizeToFit];
        recipeIngredientArray = [[NSMutableArray alloc] init];
        recipeProceduresArray = [[NSMutableArray alloc] init];
        recipeIngredientArray = [[DatabaseHandler getSharedInstance]getRecipeIngredients:recipeName];
        recipeProceduresArray = [[DatabaseHandler getSharedInstance]getRecipeProcedures:recipeName];
        ingredientsProcedureScrollView = [[UIScrollView alloc] init];
        ingredientsProcedureScrollView.backgroundColor = [UIColor clearColor];
        ingredientsProcedureScrollView.showsVerticalScrollIndicator = YES;
        ingredientsProcedureScrollView.showsHorizontalScrollIndicator = YES;
        ingredientsProcedureScrollView.scrollEnabled = YES;
        
        ingredientsLabel.frame = CGRectMake(SPACE_X, 0, ingredientsLabel.bounds.size.width, ingredientsLabel.bounds.size.height);
        [ingredientsProcedureScrollView addSubview:ingredientsLabel];
        for(int i = 0; i < [recipeIngredientArray count];i++){
            RecipeHandler* rh = [[RecipeHandler alloc] init];
            rh = [recipeIngredientArray objectAtIndex:i];
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:@"Helvetica" size:12];
            label.text = [NSString stringWithFormat:@"%@ %@ %@",[rh getIngredientValue], [rh getIngredientMeasurement], [rh getIngredientName]];
            [label sizeToFit];
            label.frame = CGRectMake(SPACE_X * 2,label.bounds.size.height * (i + 1) + ingredientsLabel.bounds.size.height, label.bounds.size.width, label.bounds.size.height);
            scroll_view_size += label.bounds.size.height;

            [ingredientsProcedureScrollView addSubview:label];
        }
        proceduresLabel = [[UILabel alloc] init];
        proceduresLabel.text = @"Procedures:";
        proceduresLabel.textColor = [UIColor blackColor];
        proceduresLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        [proceduresLabel sizeToFit];
        scroll_view_size += proceduresLabel.bounds.size.height;
        proceduresLabel.frame = CGRectMake(SPACE_X, scroll_view_size + ingredientsLabel.bounds.size.height , proceduresLabel.bounds.size.width, proceduresLabel.bounds.size.height);
        [ingredientsProcedureScrollView addSubview:proceduresLabel];
        for(int i = 0; i < [recipeProceduresArray count]; i++){
            ProceduresHandler* ph = [[ProceduresHandler alloc] init];
            ph = [recipeProceduresArray objectAtIndex:i];
            //UILabel* label = [[UILabel alloc] init];
            UILabel* textView = [[UILabel alloc] init];
            
            textView.text = [NSString stringWithFormat:@"%@. %@",[ph getSequence], [ph getRecipeProcedure]];
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont fontWithName:@"Helvetica" size:12];
            //textView.editable = NO;
            [textView setPreferredMaxLayoutWidth:self.bounds.size.width];
            [textView setNumberOfLines:0];
            CGSize maxSize = CGSizeMake(280,CGFLOAT_MAX);
            CGSize requiredSize = [textView sizeThatFits:maxSize];

            textView.frame = CGRectMake(SPACE_X * 2, scroll_view_size + ingredientsLabel.bounds.size.height + proceduresLabel.bounds.size.height + scroll_view_size_proc, requiredSize.width, requiredSize.height);
            scroll_view_size_proc += requiredSize.height;

            [ingredientsProcedureScrollView addSubview:textView];
        }

        [self enableViewsInteraction];
        [self addSubview:previousImageView];
        [self addSubview:recipeLabel];
        [self addSubview:ingredientsProcedureScrollView];
    }
    return(self);
}

- (void)layoutSubviews{
    head_center_x = self.bounds.size.width / 2;
    if(self.bounds.size.height > self.bounds.size.width){
        head_image_height = self.bounds.size.height * HDICON_HEIGHT;
        head_image_width = self.bounds.size.width * HDICON_WIDTH;
        tabbar_image_height = self.bounds.size.height * TBICON_HEIGHT;
        tabbar_image_width = self.bounds.size.width * TBICON_WIDTH;
    }
    else{
        head_image_height = self.bounds.size.width * HDICON_HEIGHT;
        head_image_width = self.bounds.size.height * HDICON_WIDTH;
        tabbar_image_height = self.bounds.size.width * TBICON_HEIGHT;
        tabbar_image_width = self.bounds.size.height * TBICON_WIDTH;
    }

    [self drawHeader];
    [self drawTail];
    [self drawScrollView];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    if([touch view] == previousImageView){
        [_delegate didTouchGoBack];
    }
}
- (void)drawHeader{
    [recipeLabel sizeToFit];
    recipeLabel.frame = CGRectMake(head_center_x - recipeLabel.bounds.size.width / 2,
                                       SPACE_Y,
                                       recipeLabel.bounds.size.width,
                                       recipeLabel.bounds.size.height);
    //kitchenTipsImageView.frame = CGRectMake(head_center_x - head_image_width / 2  - whatToCookLabel.bounds.size.width / 2 - SPACE_X , SPACE_Y, head_image_width, head_image_height);
}
- (void)drawTail{
    previousImageView.frame = CGRectMake(0,
                                         self.bounds.size.height - tabbar_image_height,
                                         tabbar_image_width,
                                         tabbar_image_height);
}
- (void)drawScrollView{
    ingredientsProcedureScrollView.frame = CGRectMake(0,recipeLabel.bounds.size.height + SPACE_Y,self.bounds.size.width,self.bounds.size.height - tabbar_image_height - recipeLabel.bounds.size.height - SPACE_Y);
    ingredientsProcedureScrollView.contentSize = CGSizeMake(self.bounds.size.width,scroll_view_size + scroll_view_size_proc + ingredientsLabel.bounds.size.height + proceduresLabel.bounds.size.height);
}
- (void)enableViewsInteraction{
    previousImageView.userInteractionEnabled = YES;
}
@end
