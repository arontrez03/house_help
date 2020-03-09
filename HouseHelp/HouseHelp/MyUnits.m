//
//  MyUnits.m
//  AppVantage
//
//  Created by macuser on 10/1/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import "MyUnits.h"

@implementation MyUnits

- (id)initWithFrame:(CGRect)frame myText:(NSString*) myStr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //MEASUREMENT CONVERTER
        _myLabel = [[UILabel alloc] init];
        [_myLabel setUserInteractionEnabled: YES];
        _myLabel.backgroundColor = [UIColor whiteColor];
        _myLabel.text = myStr;
        [self addSubview:_myLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    // Drawing code
    int parentHeight = self.bounds.size.height;
    int parentWidth = self.bounds.size.width;
    
    myFontSize = parentHeight *.5;
    
    [_myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:myFontSize]];
    [_myLabel sizeToFit];
    int myLabelWidth = _myLabel.bounds.size.width;
    int myLabelHeight = _myLabel.bounds.size.height;
    
    _myLabel.frame  = CGRectMake((int)((parentWidth-myLabelWidth)/2),(int)((parentHeight-myLabelHeight)/2),myLabelWidth,myLabelHeight);
    
}


@end
