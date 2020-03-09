//
//  KitchenBuddyView.m
//  HouseHelp
//
//  Created by Breakstuff on 9/24/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "KitchenBuddyView.h"

@implementation KitchenBuddyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        recipeProceduresArray = [[NSMutableArray alloc] init];
        recipesArray = [[NSMutableArray alloc] init];
        kitchenTipsImage = [UIImage imageNamed:@"recipeicon.png"];
        kitchenTipsImageView = [[UIImageView alloc] initWithImage:kitchenTipsImage];
        searchIngredientsTextField = [[UITextField alloc] init];
        recipeTableView = [[UITableView alloc] init];
        [searchIngredientsTextField setBorderStyle:UITextBorderStyleLine];
        whatToCookLabel = [[UILabel alloc] init];
        whatToCookLabel.text = @"What To Cook?";
        whatToCookLabel.textColor = [UIColor blackColor];

        searchIngredientsTextField.delegate = self;
        searchIngredientsTextField.placeholder = @"Enter ingredients here...";

        [DatabaseHandler getSharedInstance];
        recipesArray = [[DatabaseHandler getSharedInstance]getAllRecipes];
        [self registerForKeyboardNotifications];
        [self addSubview:kitchenTipsImageView];
        [self addSubview:whatToCookLabel];
        [self addSubview:searchIngredientsTextField];
        [self addSubview:recipeTableView];
    }
    return self;
}

- (void)layoutSubviews{

    head_center_x = self.bounds.size.width / 2;
    if(self.bounds.size.height > self.bounds.size.width){
        head_image_height = self.bounds.size.height * HDICON_HEIGHT;
        head_image_width = self.bounds.size.width * HDICON_WIDTH;
        header_size = self.bounds.size.height * LABEL_HEADER;
        textfield_size = self.bounds.size.height * LABEL_TEXTFIELD;
    }
    else{
        head_image_height = self.bounds.size.width * HDICON_HEIGHT;
        head_image_width = self.bounds.size.height * HDICON_WIDTH;
        header_size = self.bounds.size.width * LABEL_HEADER;
        textfield_size = self.bounds.size.width * LABEL_TEXTFIELD;
    }

    whatToCookLabel.font = [UIFont fontWithName:@"Helvetica" size:header_size];
    searchIngredientsTextField.font = [UIFont fontWithName:@"Helvetica" size:textfield_size];
    [whatToCookLabel sizeToFit];
    [searchIngredientsTextField sizeToFit];
    [self drawHeader];
    [self drawTextField];
    //[self drawTail];
    [self drawRecipeTableView];
    [self animateHeader];
    recipeTableView.dataSource = self;
    recipeTableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return([recipesArray count]);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* recipesTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    DistinctRecipesHandler* drh = [[DistinctRecipesHandler alloc]init];
    drh = [recipesArray objectAtIndex:indexPath.row];
    recipesTableViewCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:textfield_size];
    [recipesTableViewCell sizeToFit];
    recipesTableViewCell.textLabel.text = drh.recipes;
    return(recipesTableViewCell);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DistinctRecipesHandler* drh = [[DistinctRecipesHandler alloc]init];
    drh = [recipesArray objectAtIndex:indexPath.row];
    [_delegate didTouchRecipe:drh.recipes];
}
- (void)animateHeader{
    [UIView animateWithDuration:1.0 animations:^{
        kitchenTipsImageView.frame = CGRectMake(head_center_x - head_image_width / 2  - whatToCookLabel.bounds.size.width / 2 - SPACE_X , SPACE_Y, head_image_width, head_image_height);
    }];
}
- (void)drawHeader{
    whatToCookLabel.frame = CGRectMake(head_center_x + SPACE_X + head_image_width / 2 - whatToCookLabel.bounds.size.width / 2,
                                       SPACE_Y,
                                       whatToCookLabel.bounds.size.width,
                                       whatToCookLabel.bounds.size.height);
    kitchenTipsImageView.frame = CGRectMake(head_center_x - head_image_width / 2  - whatToCookLabel.bounds.size.width / 2 - SPACE_X , SPACE_Y, head_image_width, head_image_height);
}
- (void)drawRecipeTableView{
    recipeTableView.frame = CGRectMake(TABLE_VIEW_SPACER / 2,
                                       kitchenTipsImageView.bounds.size.height + SPACE_Y * 2 + searchIngredientsTextField.bounds.size.height,
                                       self.bounds.size.width - TABLE_VIEW_SPACER * 2,
                                       self.bounds.size.height - kitchenTipsImageView.bounds.size.height - (SPACE_Y * 2) - searchIngredientsTextField.bounds.size.height - _tabbarsize.height);
    recipeTableView.separatorColor = [UIColor brownColor];
}

- (void)drawTextField{
    searchIngredientsTextField.frame = CGRectMake(SPACE_X,
                                                  kitchenTipsImageView.bounds.size.height + SPACE_Y * 2,
                                                  self.bounds.size.width - SPACE_Y * 2,
                                                  searchIngredientsTextField.bounds.size.height);
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //NSDictionary* info = [aNotification userInfo];
    //CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self setNeedsLayout];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchIngredientsTextField resignFirstResponder];
    /*recipeProceduresArray = [[DatabaseHandler getSharedInstance]getRecipeProcedure:searchIngredientsTextField.text];
    for(RecipeHandler* rh in recipeProceduresArray){
        NSLog(@"DEBUG>>%@",[rh getRecipeName]);
    }*/
    recipesArray = [[DatabaseHandler getSharedInstance]getRecipes:searchIngredientsTextField.text];
    /*for(DistinctRecipesHandler* drh in recipeProceduresArray){
        NSLog(@">>>%@",drh.recipes);
    }*/
    [recipeTableView reloadData];
    return YES;
}
@end
