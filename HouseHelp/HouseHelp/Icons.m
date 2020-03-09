//
//  Icons.m
//  AppVantage
//
//  Created by macuser on 10/4/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import "Icons.h"

@implementation Icons


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithButton:(CGRect)frame myImage:(NSString*) myImageStr myTxt:(NSString*)myTxtStr
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *myLogo = [UIImage imageNamed:myImageStr];
        myLogoView = [[UIImageView alloc] initWithImage:myLogo];
        _myButton = [[UIButton alloc] init];
        [_myButton setTitle:myTxtStr forState:UIControlStateNormal];
        [self addSubview:myLogoView];
        [self addSubview:_myButton];
        //self.backgroundColor = [UIColor yellowColor];
        initType = 1;
        
    }
    return self;
}

- (id)initWithLabel:(CGRect)frame myImage:(NSString*) myImageStr myTxt:(NSString*)myTxtStr
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *myLogo = [UIImage imageNamed:myImageStr];
        myLogoView = [[UIImageView alloc] initWithImage:myLogo];
        _myLabel = [[UILabel alloc] init];
        _myLabel.text = myTxtStr;
        [self addSubview:myLogoView];
        [self addSubview:_myLabel];
        //self.backgroundColor = [UIColor yellowColor];
        initType = 2;
        
    }
    return self;
}
/*
 - (void)drawRect:(CGRect)rect
 {
 
 }
 */
- (void)layoutSubviews{
    
    parentHeight = self.bounds.size.height;
    parentWidth = self.bounds.size.width;
    
    
    if(parentHeight>parentWidth){
        myFontSize = parentHeight *.1;
    }else{
        myFontSize = parentWidth *.1;
    }
    
    //if button
    if(initType==1){
        //[myButton setFont:[UIFont fontWithName:@"Helvetica-Bold" size:myFontSize]];
        _myButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:myFontSize];
        [_myButton sizeToFit];
        myButtonWidth = _myButton.bounds.size.width;
        myButtonHeight = _myButton.bounds.size.height;
        myLogoView.frame = CGRectMake(0,0,parentWidth,parentHeight-myButtonHeight);
        _myButton.frame = CGRectMake((int)((parentWidth-myButtonWidth)/2),parentHeight-myButtonHeight,myButtonWidth,myButtonHeight);
    }else{
        [_myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:myFontSize]];
        [_myLabel sizeToFit];
        myLabelWidth = _myLabel.bounds.size.width;
        myLabelHeight = _myLabel.bounds.size.height;
        myLogoView.frame = CGRectMake(0,0,parentWidth,parentHeight-myLabelHeight);
        _myLabel.frame = CGRectMake((int)((parentWidth-myLabelWidth)/2),parentHeight-myLabelHeight,myLabelWidth,myLabelHeight);
        
    }
    
}




-(void) resetDrawing{
    [self setNeedsDisplay];
}

@end
