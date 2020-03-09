//
//  AddRecipeView.m
//  HouseHelp
//
//  Created by Breakstuff on 10/3/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "AddRecipeView.h"

@implementation AddRecipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        flag = NO;
        kbsizeheight = 0;
        ingredientsArray = [[NSMutableArray alloc] init];
        proceduresArray = [[NSMutableArray alloc] init];
        alertIngredients = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to add this ingredient?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        alertIngredients.delegate = self;
        [alertIngredients setTag:1];
        alertProcedures = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to add this procedure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        alertProcedures.delegate = self;
        [alertProcedures setTag:2];
        alertInsertRecipes = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to create this recipe?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        alertInsertRecipes.delegate = self;
        [alertInsertRecipes setTag:3];
        previousImage = [UIImage imageNamed:@"previous.png"];
        previousImageView = [[UIImageView alloc]initWithImage:previousImage];
        previousImageView.alpha = 0.5;
        previousImageView.userInteractionEnabled = YES;
        addIconImage = [UIImage imageNamed:@"addicon.png"];
        addIconImageView = [[UIImageView alloc] initWithImage:addIconImage];
        addIngredientsImage = [UIImage imageNamed:@"buttongray.png"];
        addIngredientsImageView = [[UIImageView alloc] initWithImage:addIngredientsImage];
        addProcedureImage = [UIImage imageNamed:@"buttongray.png"];
        addProcedureImageView = [[UIImageView alloc] initWithImage:addProcedureImage];
        acceptImage = [UIImage imageNamed:@"checkbox.png"];
        acceptImageView = [[UIImageView alloc] initWithImage:acceptImage];
        acceptImageView.alpha = 0.5;
        acceptImageView.userInteractionEnabled = YES;
        addProcedureImageView.userInteractionEnabled = YES;
        addRecipeLabel = [[UILabel alloc] init];
        addRecipeLabel.text = @"Create Recipe";
        addRecipeLabel.textColor = [UIColor blackColor];
        addRecipeNameLabel = [[UILabel alloc] init];
        addRecipeNameLabel.text = @"Recipe Name";
        addRecipeNameLabel.textColor = [UIColor blackColor];
        addRecipeDescriptionLabel = [[UILabel alloc] init];
        addRecipeDescriptionLabel.text = @"Recipe Desc";
        addRecipeDescriptionLabel.textColor = [UIColor blackColor];
        addIngredientsLabel = [[UILabel alloc] init];
        addIngredientsLabel.text = @"Add ingredients";
        addIngredientsLabel.textColor = [UIColor blackColor];
        addIngredientName = [[UILabel alloc] init];
        addIngredientName.text = @"Name";
        addIngredientName.textColor = [UIColor blackColor];
        addIngredientMeasurement = [[UILabel alloc] init];
        addIngredientMeasurement.text = @"Measurement";
        addIngredientMeasurement.textColor = [UIColor blackColor];
        addIngredientValue = [[UILabel alloc] init];
        addIngredientValue.text = @"Value";
        addIngredientValue.textColor = [UIColor blackColor];
        addProcedureLabel = [[UILabel alloc] init];
        addProcedureLabel.text = @"Add procedures";
        addProcedureLabel.textColor = [UIColor blackColor];
        
        addRecipeNameTextField = [[UITextField alloc] init];
        [addRecipeNameTextField setBorderStyle:UITextBorderStyleLine];
        addRecipeNameTextField.placeholder = @"Recipe name here...";
        addRecipeNameTextField.delegate = self;
        addRecipeDescriptionTextField = [[UITextField alloc] init];
        [addRecipeDescriptionTextField setBorderStyle:UITextBorderStyleLine];
        addRecipeDescriptionTextField.delegate = self;
        addRecipeDescriptionTextField.placeholder = @"Recipe description...";
        addIngredientNameTextField = [[UITextField alloc] init];
        [addIngredientNameTextField setBorderStyle:UITextBorderStyleLine];
        addIngredientNameTextField.placeholder = @"Ingredient name...";
        addIngredientNameTextField.delegate = self;
        addIngredientMeasurementTextField = [[UITextField alloc] init];
        [addIngredientMeasurementTextField setBorderStyle:UITextBorderStyleLine];
        addIngredientMeasurementTextField.placeholder = @"ex (tbsp, cup, ml, etc...)";
        addIngredientMeasurementTextField.delegate = self;
        addIngredientValueTextField = [[UITextField alloc] init];
        [addIngredientValueTextField setBorderStyle:UITextBorderStyleLine];
        addIngredientValueTextField.placeholder = @"Ingredient value...";
        addIngredientValueTextField.delegate = self;
        
        addProcedureTextView = [[UITextView alloc] init];
        //To make the border look very close to a UITextField
        [addProcedureTextView.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
        [addProcedureTextView.layer setBorderWidth:1.0];
        //The rounded corner part, where you specify your view's corner radius:
        //addProcedureTextView.layer.cornerRadius = 5;
        addProcedureTextView.clipsToBounds = YES;
        addProcedureTextView.delegate = self;
        ingredientsTableView = [[UITableView alloc] init];
        proceduresTableView = [[UITableView alloc] init];
        addRecipeScrollView = [[AddRecipesScrollView alloc] init];
        addRecipeScrollView.backgroundColor = [UIColor clearColor];
        addRecipeScrollView.showsVerticalScrollIndicator = YES;
        addRecipeScrollView.showsHorizontalScrollIndicator = YES;
        addRecipeScrollView.scrollEnabled = YES;
        addRecipeScrollView.canCancelContentTouches = NO;
        
        [self addSubview:addRecipeScrollView];
        [addRecipeScrollView addSubview:addProcedureTextView];
        UITapGestureRecognizer *tapProcedure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddProcedures:)];
        [addProcedureImageView addGestureRecognizer:tapProcedure];
        [addRecipeScrollView addSubview:addProcedureImageView];
        [addRecipeScrollView addSubview:addProcedureLabel];
        [addRecipeScrollView addSubview:addIngredientNameTextField];
        [addRecipeScrollView addSubview:addIngredientMeasurementTextField];
        [addRecipeScrollView addSubview:addIngredientValueTextField];
        [addRecipeScrollView addSubview:addIngredientValue];
        [addRecipeScrollView addSubview:addIngredientMeasurement];
        [addRecipeScrollView addSubview:addIngredientName];
        [addRecipeScrollView addSubview:proceduresTableView];
        [addRecipeScrollView addSubview:ingredientsTableView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddIngredients:)];
        [addIngredientsImageView addGestureRecognizer:tap];
        [addRecipeScrollView addSubview:addIngredientsImageView];
        [addRecipeScrollView addSubview:addIngredientsLabel];
        [addRecipeScrollView addSubview:addRecipeDescriptionTextField];
        [addRecipeScrollView addSubview:addRecipeDescriptionLabel];
        [addRecipeScrollView addSubview:addRecipeNameTextField];
        [addRecipeScrollView addSubview:addRecipeNameLabel];
        [self addSubview:addRecipeLabel];
        [self addSubview:addIconImageView];
        [self addSubview:previousImageView];
        [self addSubview:acceptImageView];
    }
    return self;
}

- (void)layoutSubviews{
    head_center_x = self.bounds.size.width / 2;
    if(self.bounds.size.height > self.bounds.size.width){
        head_image_height = self.bounds.size.height * HDICON_HEIGHT;
        head_image_width = self.bounds.size.width * HDICON_WIDTH;
        tabbar_image_height = self.bounds.size.height * TBICON_HEIGHT;
        tabbar_image_width = self.bounds.size.width * TBICON_WIDTH;
        header_size = self.bounds.size.height * LABEL_HEADER;
        normal_size = self.bounds.size.height * LABEL_TEXTFIELD;
    }
    else{
        head_image_height = self.bounds.size.width * HDICON_HEIGHT;
        head_image_width = self.bounds.size.height * HDICON_WIDTH;
        tabbar_image_height = self.bounds.size.width * TBICON_HEIGHT;
        tabbar_image_width = self.bounds.size.height * TBICON_WIDTH;
        header_size = self.bounds.size.width * LABEL_HEADER;
        normal_size = self.bounds.size.width * LABEL_TEXTFIELD;
    }
    ingredientsTableView.dataSource = self;
    ingredientsTableView.delegate = self;
    proceduresTableView.dataSource = self;
    proceduresTableView.delegate = self;
    ingredientsTableView.backgroundColor = [UIColor clearColor];
    addRecipeLabel.font = [UIFont fontWithName:@"Helvetica" size:header_size];
    addRecipeNameLabel.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addRecipeDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addIngredientsLabel.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addIngredientName.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addIngredientMeasurement.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addIngredientValue.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addProcedureLabel.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addProcedureTextView.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
    addIngredientsLabel.userInteractionEnabled = YES;
    addIngredientsImageView.userInteractionEnabled = YES;
    
    [addIngredientsLabel sizeToFit];
    [addRecipeDescriptionLabel sizeToFit];
    [addRecipeLabel sizeToFit];
    [addRecipeNameLabel sizeToFit];
    [addIngredientName sizeToFit];
    [addIngredientMeasurement sizeToFit];
    [addIngredientValue sizeToFit];
    [addProcedureLabel sizeToFit];
    [addProcedureTextView sizeToFit];
    [self drawScrollView];
    [self drawTableViews];
    [self drawIngridients];
    [self drawProcedures];
    [self drawHeader];
    [self drawTail];
    [self drawRecipeName];
    [self drawRecipeDesc];
}
- (void) tapAddIngredients:(UITapGestureRecognizer*)gesture
{
    [alertIngredients show];
}
- (void) tapAddProcedures:(UITapGestureRecognizer*)gesture
{
    [addProcedureTextView resignFirstResponder];
    [alertProcedures show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if (buttonIndex == 0){
            //delete it
        }
        else if (buttonIndex == 1)
        {
            if([addIngredientNameTextField.text length] == 0){
                flag = NO;
                addIngredientName.textColor = [UIColor redColor];
            }
            else{
                flag = YES;
                addIngredientName.textColor = [UIColor blackColor];
            }
            if([addIngredientMeasurementTextField.text length] == 0){
                flag = NO;
                addIngredientMeasurement.textColor = [UIColor redColor];
            }
            else{
                flag = YES;
                addIngredientMeasurement.textColor = [UIColor blackColor];
            }
            if([addIngredientValueTextField.text length] == 0){
                flag = NO;
                addIngredientValue.textColor = [UIColor redColor];
            }
            else{
                flag = YES;
                addIngredientValue.textColor = [UIColor blackColor];
            }
            if(flag){
                //proceed with insert
                IngredientsHandler* ih = [[IngredientsHandler alloc] init];
                [ih addIngredientName:addIngredientNameTextField.text];
                [ih addIngredientMeasurement:addIngredientMeasurementTextField.text];
                [ih addIngredientValue:addIngredientValueTextField.text];
                [ingredientsArray addObject:ih];
                addIngredientValueTextField.text = nil;
                addIngredientNameTextField.text = nil;
                addIngredientMeasurementTextField.text = nil;
                [ingredientsTableView reloadData];
            }
            [self setNeedsLayout];
        }
    }
    else if(alertView.tag == 2){
        if(buttonIndex == 0){
            
        }
        else if(buttonIndex == 1){
            CGPoint point = CGPointMake(0, addRecipeLabel.bounds.size.height + SPACE_Y * 14 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height + addIngredientValue.bounds.size.height + self.bounds.size.height * TVIEW_SIZE);
            [addRecipeScrollView setContentOffset:point animated:YES];
            if([addProcedureTextView.text length] != 0){
                addProcedureLabel.textColor = [UIColor blackColor];
                [proceduresArray addObject:[NSString stringWithFormat:@"%@",addProcedureTextView.text]];
                [proceduresTableView reloadData];
                addProcedureTextView.text = nil;
            }
            else{
                addProcedureLabel.textColor = [UIColor redColor];
            }
        }
    }
    else if(alertView.tag == 3){
        if([addRecipeNameTextField.text length] == 0){
            addRecipeNameLabel.textColor = [UIColor redColor];
            flag = NO;
        }
        else{
            addRecipeNameLabel.textColor = [UIColor blackColor];
            flag = YES;
        }
        if([addRecipeDescriptionTextField.text length] == 0){
            addRecipeDescriptionLabel.textColor = [UIColor redColor];
            flag = NO;
        }
        else{
            addRecipeDescriptionLabel.textColor = [UIColor blackColor];
            flag = YES;
        }
        if([ingredientsArray count] == 0){
            flag = NO;
            addIngredientsLabel.textColor = [UIColor redColor];
        }
        else{
            flag = YES;
            addIngredientsLabel.textColor = [UIColor blackColor];
        }
        if([proceduresArray count] == 0){
            flag = NO;
            addProcedureLabel.textColor = [UIColor redColor];
        }
        else{
            flag = YES;
            addProcedureLabel.textColor = [UIColor blackColor];
        }
        if(flag){
            //database handler insert
            BOOL ret_val = NO;
            ret_val = [[DatabaseHandler getSharedInstance]insertRecipeName:addRecipeNameTextField.text recipeDescription:addRecipeDescriptionTextField.text];
            if(!ret_val){
                //NSLog(@"Taena failed to insert sa recipe");
            }
            else{
                //NSLog(@"rec name: %@ rec desc: %@",addRecipeNameTextField.text,addRecipeDescriptionTextField.text);
            }
            for (int i = 0; i < [ingredientsArray count]; i++){
                IngredientsHandler* ih = [[IngredientsHandler alloc] init];
                ih = [ingredientsArray objectAtIndex:i];
                ret_val = [[DatabaseHandler getSharedInstance]insertIngredients:addRecipeNameTextField.text ingredientName:ih.ingredient_name ingredientMeasurement:ih.ingredient_measurement ingredientValue:ih.ingredient_value];
                if(!ret_val){
                    //NSLog(@"ayaw mainsert ng ingredient bietch");
                }
                else{
                    //NSLog(@"ing name: %@ ing meas: %@ ing value: %@",ih.ingredient_name,ih.ingredient_measurement,ih.ingredient_value);
                }
            }
            for(int i = 0; i < [proceduresArray count]; i++){
                ret_val = [[DatabaseHandler getSharedInstance]insertRecipeName:addRecipeNameTextField.text procSequence:[NSString stringWithFormat:@"%d",i + 1] proceduresData:[proceduresArray objectAtIndex:i]];
                if(!ret_val){
                    //NSLog(@"Unable to insert procedure");
                }
                else{
                    //NSLog(@"%d %@",i+1,[proceduresArray objectAtIndex:i]);
                }
            }
            [_delegate didTouchInsertRecipe:addRecipeNameTextField.text];
        }
        [self setNeedsLayout];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    if([touch view] == previousImageView)
    {
        [_delegate didTouchGoBack];
    }
    else if([touch view] == acceptImageView){
        [alertInsertRecipes show];
        //check if recipe name and description is empty
        
    }
}

- (void)drawScrollView{
    addRecipeScrollView.frame = CGRectMake(0,
                                           addRecipeLabel.bounds.size.height + SPACE_Y,
                                           self.bounds.size.width,
                                           self.bounds.size.height - addRecipeLabel.bounds.size.height - tabbar_image_height - kbsizeheight);
    addRecipeScrollView.contentSize = CGSizeMake(self.bounds.size.width, 700);
}

- (void)drawTail{
    previousImageView.frame = CGRectMake(0,
                                         self.bounds.size.height - tabbar_image_height,
                                         tabbar_image_width,
                                         tabbar_image_height);
    acceptImageView.frame = CGRectMake(self.bounds.size.width - tabbar_image_width,
                                         self.bounds.size.height - tabbar_image_height,
                                         tabbar_image_width,
                                         tabbar_image_height);
}
- (void)drawHeader{
    addRecipeLabel.frame = CGRectMake(head_center_x + SPACE_X + tabbar_image_width / 2 - addRecipeLabel.bounds.size.width / 2,
                                       SPACE_Y,
                                       addRecipeLabel.bounds.size.width,
                                       addRecipeLabel.bounds.size.height);
    addIconImageView.frame = CGRectMake(head_center_x - head_image_width / 2  - addRecipeLabel.bounds.size.width / 2 - SPACE_X , SPACE_Y, tabbar_image_width, tabbar_image_height);
}
- (void)drawRecipeName{
    addRecipeNameLabel.frame = CGRectMake(SPACE_X, SPACE_Y * 2,addRecipeNameLabel.bounds.size.width, addRecipeNameLabel.bounds.size.height);
    addRecipeNameTextField.frame = CGRectMake(SPACE_X * 2 + addRecipeNameLabel.bounds.size.width, SPACE_Y * 2, self.bounds.size.width - addRecipeNameLabel.bounds.size.width - SPACE_X * 3, addRecipeNameLabel.bounds.size.height);
}
- (void)drawRecipeDesc{
    addRecipeDescriptionLabel.frame = CGRectMake(SPACE_X,
                                                 SPACE_Y * 2 + addRecipeNameLabel.bounds.size.height + SPACE_Y * 2,
                                                 addRecipeDescriptionLabel.bounds.size.width,
                                                 addRecipeDescriptionLabel.bounds.size.height);
    addRecipeDescriptionTextField.frame = CGRectMake(SPACE_X * 2 + addRecipeNameLabel.bounds.size.width,
                                                     SPACE_Y * 2 + addRecipeNameLabel.bounds.size.height + SPACE_Y * 2,
                                                     self.bounds.size.width - addRecipeNameLabel.bounds.size.width - SPACE_X * 3,
                                                     addRecipeDescriptionLabel.bounds.size.height);
}
- (void)drawIngridients{
    addIngredientsLabel.frame = CGRectMake(SPACE_X,
                                           addRecipeLabel.bounds.size.height + SPACE_Y * 7 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height,
                                           addIngredientsLabel.bounds.size.width, addIngredientsLabel.bounds.size.height);
    addIngredientsImageView.frame = CGRectMake(SPACE_X * 2 + addIngredientsLabel.bounds.size.width,
                                               addRecipeLabel.bounds.size.height + SPACE_Y * 7 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height,
                                               addIngredientsLabel.bounds.size.height,addIngredientsLabel.bounds.size.height);
    addIngredientName.frame = CGRectMake(SPACE_X,
                                        addRecipeLabel.bounds.size.height + SPACE_Y * 8 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height,
                                         addIngredientName.bounds.size.width, addIngredientName.bounds.size.height);
    addIngredientNameTextField.frame = CGRectMake(SPACE_X * 2 + addRecipeNameLabel.bounds.size.width,
                                                  addRecipeLabel.bounds.size.height + SPACE_Y * 8 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height, self.bounds.size.width - addRecipeNameLabel.bounds.size.width - SPACE_X * 3, addRecipeDescriptionLabel.bounds.size.height);
    addIngredientMeasurement.frame = CGRectMake(SPACE_X,
                                                addRecipeLabel.bounds.size.height + SPACE_Y * 9 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height, addIngredientMeasurement.bounds.size.width, addIngredientMeasurement.bounds.size.height);
    addIngredientMeasurementTextField.frame = CGRectMake(SPACE_X * 2 + addRecipeNameLabel.bounds.size.width,
                                                  addRecipeLabel.bounds.size.height + SPACE_Y * 9 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height, self.bounds.size.width - addRecipeNameLabel.bounds.size.width - SPACE_X * 3, addRecipeDescriptionLabel.bounds.size.height);
    addIngredientValue.frame = CGRectMake(SPACE_X,
                                          addRecipeLabel.bounds.size.height + SPACE_Y * 10 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height, addIngredientValue.bounds.size.width, addIngredientValue.bounds.size.height);
    addIngredientValueTextField.frame = CGRectMake(SPACE_X * 2 + addRecipeNameLabel.bounds.size.width,
                                                         addRecipeLabel.bounds.size.height + SPACE_Y * 10 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height, self.bounds.size.width - addRecipeNameLabel.bounds.size.width - SPACE_X * 3, addRecipeDescriptionLabel.bounds.size.height);
}
- (void)drawProcedures{
    addProcedureLabel.frame = CGRectMake(SPACE_X,
                                         addRecipeLabel.bounds.size.height + SPACE_Y * 14 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height + addIngredientValue.bounds.size.height + self.bounds.size.height * TVIEW_SIZE, addProcedureLabel.bounds.size.width, addProcedureLabel.bounds.size.height);
    addProcedureImageView.frame = CGRectMake(SPACE_X * 2 + addProcedureLabel.bounds.size.width,
                                             addRecipeLabel.bounds.size.height + SPACE_Y * 14 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height + addIngredientValue.bounds.size.height + self.bounds.size.height * TVIEW_SIZE,
                                             addProcedureLabel.bounds.size.height,addProcedureLabel.bounds.size.height);
    addProcedureTextView.frame = CGRectMake(SPACE_X,
                                            addRecipeLabel.bounds.size.height + SPACE_Y * 15 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height + addIngredientValue.bounds.size.height + self.bounds.size.height * TVIEW_SIZE + addProcedureLabel.bounds.size.height, self.bounds.size.width - SPACE_X * 2, addProcedureTextView.bounds.size.height);
}
- (void)drawTableViews{
    ingredientsTableView.frame = CGRectMake(SPACE_X,
                                            addRecipeLabel.bounds.size.height + SPACE_Y * 11 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height + addIngredientValue.bounds.size.height,
                                            self.bounds.size.width - SPACE_X * 2,
                                            self.bounds.size.height * TVIEW_SIZE);
    proceduresTableView.frame = CGRectMake(SPACE_X,
                                           addRecipeLabel.bounds.size.height + SPACE_Y * 16 + addRecipeNameLabel.bounds.size.height + addRecipeDescriptionLabel.bounds.size.height + addIngredientsLabel.bounds.size.height + addIngredientName.bounds.size.height + addIngredientMeasurement.bounds.size.height + addIngredientValue.bounds.size.height + self.bounds.size.height * TVIEW_SIZE + addProcedureLabel.bounds.size.height + addProcedureTextView.bounds.size.height,
                                           self.bounds.size.width - SPACE_X * 2,
                                           self.bounds.size.height * .35);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == ingredientsTableView){
        return([ingredientsArray count]);
    }
    else if(tableView == proceduresTableView){
        return([proceduresArray count]);
    }
    else{
        
    }
    return(0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* temp = [[UITableViewCell alloc] init];
    if(tableView == ingredientsTableView){
        IngredientsHandler* ih = [[IngredientsHandler alloc] init];
        UITableViewCell* ingridientsTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        ingridientsTableViewCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:normal_size];
        ih = [ingredientsArray objectAtIndex:indexPath.row];
        ingridientsTableViewCell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",ih.ingredient_value,ih.ingredient_measurement,ih.ingredient_name];
        return(ingridientsTableViewCell);
    }
    else if(tableView == proceduresTableView){
        NSString* tempString = [[NSString alloc] init];
        UITableViewCell* proceduresTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        proceduresTableViewCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:normal_size];

        proceduresTableViewCell.textLabel.numberOfLines = 0;
        tempString = [proceduresArray objectAtIndex:indexPath.row];
        CGSize maxSize = CGSizeMake(self.bounds.size.width - SPACE_X * 4,CGFLOAT_MAX);
        CGSize requiredSize = [proceduresTableViewCell sizeThatFits:maxSize];
        proceduresTableViewCell.textLabel.text = [NSString stringWithFormat:@"%@",tempString];
        [proceduresTableViewCell setFrame:CGRectMake(proceduresTableViewCell.frame.origin.x,proceduresTableViewCell.frame.origin.y,requiredSize.width,requiredSize.height)];
        return(proceduresTableViewCell);
    }
    return(temp);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if(kbSize.height > kbSize.width)
    {
        kbsizeheight = kbSize.width;
        [self setNeedsLayout];
    }
    else
    {
        kbsizeheight = kbSize.height;
        [self setNeedsLayout];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self setNeedsLayout];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return(YES);
}
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y - 4.5 * textField.frame.size.height);
    [addRecipeScrollView setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [addRecipeScrollView setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}
- (void) scrollViewAdaptToStartEditingTextView:(UITextView*)textView
{
    CGPoint point = CGPointMake(0,textView.frame.origin.y - 1.5 * textView.frame.size.height);
    [addRecipeScrollView setContentOffset:point animated:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self scrollViewAdaptToStartEditingTextView:textView];
}
-(BOOL)textView:(UITextView *)_textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self adjustFrames];
    return YES;
}


-(void) adjustFrames
{
    CGRect textFrame = addProcedureTextView.frame;
    textFrame.size.height = addProcedureTextView.contentSize.height;
    addProcedureTextView.frame = textFrame;
    [self setNeedsLayout];
}

@end
