//
//  MySampleView.m
//  HyperTreeView
//
//  Created by hAmidReza on 10/26/16.
//  Copyright © 2016 innovian. All rights reserved.
//

#import "MySampleView.h"
#import "UIView+SDCAutoLayout.h"

@interface MySampleView ()
{
	BOOL initialized;
}

@end

@implementation MySampleView

-(instancetype)init
{
	self = [super init];
	if (self)
		[self initialize];
	return self;
}

-(void)initialize
{
	if (!initialized)
	{
	_imageView = [UIImageView new];
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
	_imageView.clipsToBounds = YES;
	_imageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:_imageView];
	[_imageView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ NSLayoutAttributeBottom];
        NSLayoutConstraint* imageViewHeightCon = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50];
        [self addConstraint:imageViewHeightCon];
        
	_label = [UILabel new];
	_label.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:14];
	_label.textColor = [UIColor whiteColor];
	_label.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:_label];
	[_label sdc_alignEdgesWithSuperview:UIRectEdgeLeft | UIRectEdgeBottom insets:UIEdgeInsetsMake(0, 10, -5, 0)];
		
		_hairLine = [UIView new];
		_hairLine.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_hairLine];
		[_hairLine sdc_pinWidth:5];
		[_hairLine sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeRight];
		
		initialized = YES;
	}
}

@end
