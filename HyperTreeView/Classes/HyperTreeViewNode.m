//
//  HyperTreeViewNode.m
//  HyperTreeView
//
//  Created by Hamidreza Vakilian on 10/24/16.
//  Copyright © 2016 Innovian. All rights reserved.
//

#import "HyperTreeViewNode.h"

typedef enum : NSUInteger {
	HyperTreeViewNodeTypeNormal = 0,
	HyperTreeViewNodeTypeCustomView,
} HyperTreeViewNodeType;

@interface HyperTreeViewNode ()
{
    BOOL initialized;
    UIView* motherView;
    UIActivityIndicatorView* activity;
    NSLayoutConstraint* contentViewHeightCon;
    NSMutableArray* children;
    NSLayoutConstraint* motherViewHeightCon;
	BOOL firstTime;
}

@property (nonatomic) HyperTreeViewNodeType type;
@property (retain, nonatomic) UIView* customView;

@end

@implementation HyperTreeViewNode

-(instancetype)init
{
    self = [super init];
    if (self)
    {
//       [self initialize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initialize];
		
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self initialize];
    }
    return self;
}

-(instancetype)initForNormal
{
	self = [super init];
	if (self)
	{
		_type = HyperTreeViewNodeTypeNormal;
		[self initialize];
	}
	return self;
}


-(instancetype)initWithCustomView:(UIView*)view
{
	self = [super init];
	if (self)
	{
		_type = HyperTreeViewNodeTypeCustomView;
		_customView = view;
		[self initialize];
	}
	return self;
}

-(void)initialize
{
    if (!initialized)
    {
		firstTime = YES;
		
		if (_type == HyperTreeViewNodeTypeNormal)
		{
        _header = [UIView new];
        _header.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_header];
        
//        [_header sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_header attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_header attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_header attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
            
        
        _label = [UILabel new];
        _label.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
        _label.textColor = [UIColor darkGrayColor];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [_header addSubview:_label];
        
//        [_label sdc_alignEdgesWithSuperview:UIRectEdgeAll insets:UIEdgeInsetsMake(5, 5, -5, -5)];
        [_header addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeTop multiplier:1.0 constant:5]];
        [_header addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5]];
        [_header addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5]];
        [_header addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-5]];
        


            
        
        

        
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.translatesAutoresizingMaskIntoConstraints = NO;
        [_header addSubview:activity];
            
//        [activity sdc_alignEdgesWithSuperview:UIRectEdgeRight insets:UIEdgeInsetsMake(0, 0, 0, -3)];
        [_header addConstraint:[NSLayoutConstraint constraintWithItem:activity attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-3]];
            
//        [activity sdc_verticallyCenterInSuperview];
            [_header addConstraint:[NSLayoutConstraint constraintWithItem:activity attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            
            
            
        activity.hidesWhenStopped = YES;
        activity.transform = CGAffineTransformMakeScale(.6, .6);
        
        motherView = [UIView new];
        motherView.clipsToBounds = YES;
        motherView.translatesAutoresizingMaskIntoConstraints = NO;
//		motherView.backgroundColor = [UIColor yellowColor];
        [self addSubview:motherView];
            
//        [motherView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
//        [motherView sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_header];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            
//        motherViewHeightCon = [motherView sdc_setMaximumHeight:0];
            motherViewHeightCon = [NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
            [self addConstraint:motherViewHeightCon];
            
//        motherViewHeightCon.priority = 600;
		
        _contentView = [UIView new];
//        contentView.clipsToBounds = YES;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [motherView addSubview:_contentView];
        
//        [_contentView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom];
            [motherView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [motherView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            [motherView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
        
//        NSLayoutConstraint* contentViewBottomCon = [_contentView sdc_alignEdge:UIRectEdgeBottom withEdge:UIRectEdgeBottom ofView:motherView];
           NSLayoutConstraint* contentViewBottomCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            [motherView addConstraint: contentViewBottomCon];
            
        contentViewBottomCon.priority = 1;
//        [contentView sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:labelHolder];
//        contentViewHeightCon = [contentView sdc_setMaximumHeight:10000];
//        contentView.backgroundColor = [UIColor yellowColor];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTap:)];
        [_header addGestureRecognizer:tap];
			
		}
		else if (_type == HyperTreeViewNodeTypeCustomView)
		{
			_header = [UIView new];
			_header.translatesAutoresizingMaskIntoConstraints = NO;
			[self addSubview:_header];
			
			_customView.translatesAutoresizingMaskIntoConstraints = NO;
			[_header addSubview:_customView];
            
//			[_customView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
            [_header addConstraint:[NSLayoutConstraint constraintWithItem:_customView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [_header addConstraint:[NSLayoutConstraint constraintWithItem:_customView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            [_header addConstraint:[NSLayoutConstraint constraintWithItem:_customView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [_header addConstraint:[NSLayoutConstraint constraintWithItem:_customView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
			
//			[_header sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:_header attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:_header attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:_header attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
			
			motherView = [UIView new];
			motherView.clipsToBounds = YES;
			motherView.translatesAutoresizingMaskIntoConstraints = NO;
			[self addSubview:motherView];
            
//			[motherView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeTop];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];

            
//			[motherView sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:_header];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_header attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            
            
//			motherViewHeightCon = [motherView sdc_setMaximumHeight:0];
            motherViewHeightCon = [NSLayoutConstraint constraintWithItem:motherView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
            [self addConstraint:motherViewHeightCon];
            
            
            
            
//			        motherViewHeightCon.priority = 600;
			
			_contentView = [UIView new];
			//        contentView.clipsToBounds = YES;
			_contentView.translatesAutoresizingMaskIntoConstraints = NO;
			[motherView addSubview:_contentView];
			
//			[_contentView sdc_alignEdgesWithSuperview:UIRectEdgeAll ^ UIRectEdgeBottom];
            [motherView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [motherView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            [motherView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:motherView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
            
            
            
//			NSLayoutConstraint* contentViewBottomCon = [_contentView sdc_alignEdge:UIRectEdgeBottom withEdge:UIRectEdgeBottom ofView:motherView];
            NSLayoutConstraint* contentViewBottomCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:motherView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            [motherView addConstraint:contentViewBottomCon];
    
            
			contentViewBottomCon.priority = 1;
			
			UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTap:)];
			[_header addGestureRecognizer:tap];
		}
		
//		motherView.backgroundColor = [UIColor greenColor];
////		_contentView.backgroundColor = [UIColor redColor];
		
//	header.backgroundColor = [UIColor groupTableViewBackgroundColor];
		
        children = [NSMutableArray new];
        initialized = true;
    }
}

-(void)selfTap:(UITapGestureRecognizer*)tapGest
{
	[_delegate HyperTreeViewDidTouchNode:self isFirstTime:firstTime];
	
	firstTime = NO;

}

-(void)collapseContentView
{
    motherViewHeightCon.constant = 0;

	[UIView animateWithDuration:.3 animations:^{
		//		[self.superview layoutIfNeeded];
		[superview2Layout.superview layoutIfNeeded];
		[motherView layoutIfNeeded];
	}];

    _isExpanded = false;
}

static UIView* superview2Layout;

+(void)setSuperView2Layout:(UIView*)view
{
	superview2Layout = view;
}

-(void)expandContentView
{
    motherViewHeightCon.constant = 10000;
	
	[_contentView layoutIfNeeded];
	[UIView animateWithDuration:.3 animations:^{
		[superview2Layout layoutIfNeeded];
		[motherView layoutIfNeeded];
	} completion:^(BOOL finished) {
		[_delegate HyperTreeViewNodeDidExpand:self];
	}];
	
    _isExpanded = true;
}

-(void)collapse:(BOOL)collapseDescendants
{
	if (collapseDescendants)
	{
		for (NSDictionary* aTreeNode in [_treeNode[@"items"] allValues])
		{
			HyperTreeViewNode* aNode = aTreeNode[@"node"];
			[aNode collapse:true];
		}
	}
	
    [self collapseContentView];
}

@end
