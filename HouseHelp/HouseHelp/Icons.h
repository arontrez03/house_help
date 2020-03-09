//
//  Icons.h
//  AppVantage
//
//  Created by macuser on 10/4/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Icons : UIView
{
    UIImageView* myLogoView;
    int parentHeight;
    int parentWidth;
    int myButtonWidth;
    int myButtonHeight;
    int myLabelWidth;
    int myLabelHeight;
    int myFontSize;
    int initType;
    
}
@property UIButton* myButton;
@property UILabel* myLabel;
- (id)initWithButton:(CGRect)frame myImage:(NSString*) myImageStr myTxt:(NSString*)myTxtStr;
- (id)initWithLabel:(CGRect)frame myImage:(NSString*) myImageStr myTxt:(NSString*)myTxtStr;
@end
