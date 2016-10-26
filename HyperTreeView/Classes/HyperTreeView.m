//
//  HyperTreeView.m
//  HyperTreeView
//
//  Created by Hamidreza Vakilian on 10/24/16.
//  Copyright © 2016 Innovian. All rights reserved.
//

#import "HyperTreeView.h"
#import "HyperTreeViewNode.h"

@interface HyperTreeView () <HyperTreeViewNodeDelegate>
{
	BOOL initialized;
	NSMutableDictionary* treeDescriptor;
	NSLayoutConstraint* rootViewMaxHeightCon;
	NSLayoutConstraint* headerHolderMaxHeightCon;
    NSLayoutConstraint* footerHolderMAxHeightCon;
}

@property (retain, nonatomic) UIView* contentView;
@property (retain, nonatomic) UIView* headerHolder;
@property (retain, nonatomic) UIView* footerHolder;
@property (retain, nonatomic) UIView* rootView;

@end

@implementation HyperTreeView

-(instancetype)init
{
	self = [super init];
	if (self)
		[self initialize];
	return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
		[self initialize];
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
		[self initialize];
	return self;
}

-(void)initialize
{
	if (!initialized)
	{
		//SETTING DEFAULTS
		_automaticallyCollapseNodes = YES;
		_alsoCollapseDescendantNodes = YES;
		
		//_contentView setup
		_contentView = [UIView new];
		_contentView.clipsToBounds = YES;
		_contentView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_contentView];
		
		NSDictionary *views = @{@"contentView": _contentView};
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|" options:0 metrics:nil views:views]];
		NSLayoutConstraint* contentViewWidthCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
		[self addConstraint:contentViewWidthCon];
		
		//
		_headerHolder = [UIView new];
		_headerHolder.translatesAutoresizingMaskIntoConstraints = NO;
        _headerHolder.clipsToBounds = YES;
		[_contentView addSubview:_headerHolder];
        
//		headerHolderMaxHeightCon = [_headerHolder sdc_setMaximumHeight:0];
        headerHolderMaxHeightCon = [NSLayoutConstraint constraintWithItem:_headerHolder attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
        [_contentView addConstraint:headerHolderMaxHeightCon];
        

		
		_footerHolder = [UIView new];
		_footerHolder.translatesAutoresizingMaskIntoConstraints = NO;
        _footerHolder.clipsToBounds = YES;
		[_contentView addSubview:_footerHolder];
        
//        footerHolderMAxHeightCon = [_footerHolder sdc_setMaximumHeight:0];
        footerHolderMAxHeightCon = [NSLayoutConstraint constraintWithItem:_footerHolder attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
        [_contentView addConstraint:footerHolderMAxHeightCon];
        
        
		//_rootView setup
		_rootView = [UIView new];
		_rootView.clipsToBounds = YES;
		_rootView.translatesAutoresizingMaskIntoConstraints = NO;
		[_contentView addSubview:_rootView];
		
		views = @{@"rootView": _rootView, @"headerHolder": _headerHolder, @"footerHolder": _footerHolder};
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[rootView]-0-|" options:0 metrics:nil views:views]];
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headerHolder]-0-|" options:0 metrics:nil views:views]];
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[footerHolder]-0-|" options:0 metrics:nil views:views]];
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headerHolder]-0-[rootView]-0-[footerHolder]-0-|" options:0 metrics:nil views:views]];
		rootViewMaxHeightCon = [NSLayoutConstraint constraintWithItem:_rootView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
		[_contentView addConstraint:rootViewMaxHeightCon];
		
		//treeDescriptor setup
		treeDescriptor = [NSMutableDictionary new];
		treeDescriptor[@"root"] = [@{@"items": [NSMutableDictionary new]} mutableCopy];
		
		[HyperTreeViewNode setSuperView2Layout:self];
		
		initialized = YES;
	}
}

-(void)_setFooterView:(UIView *)footerView
{
    if (footerView)
    {
        _footerView = footerView;
        _footerView.translatesAutoresizingMaskIntoConstraints= NO;
        [_footerHolder addSubview:_footerView];
        [_footerHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[footerView]-0-|" options:0 metrics:nil views:@{@"footerView": _footerView}]];
         [_footerHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[footerView]-0-|" options:0 metrics:nil views:@{@"footerView": _footerView}]];
        NSLayoutConstraint* footerViewTopConstraint = [NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_footerHolder attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        footerViewTopConstraint.priority= 500;
        [_footerHolder addConstraint:footerViewTopConstraint];
    }
    else
    {
        [_footerView removeFromSuperview];
        footerHolderMAxHeightCon.constant = 0;
    }
}


-(void)setFooterView:(UIView *)footerView
{
    [self _setFooterView:footerView];
    footerHolderMAxHeightCon.constant = 10000;
}

-(void)setFooterView:(UIView *)footerView animated:(BOOL)animated
{
    if (footerView) {
        [self _setFooterView:footerView];
        [_footerHolder layoutIfNeeded];
        
        footerHolderMAxHeightCon.constant = 10000;
        [UIView animateWithDuration:.3 animations:^{
            [self layoutIfNeeded];
        }];
    }
    else
    {
        footerHolderMAxHeightCon.constant = 0;
        
        [UIView animateWithDuration:.3 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self _setFooterView:footerView];
         }];
    }
}


-(void)_setHeaderView:(UIView *)headerView
{
	if (headerView)
	{
		_headerView = headerView;
		_headerView.translatesAutoresizingMaskIntoConstraints = NO;
		[_headerHolder addSubview:_headerView];
		[_headerHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headerView]-0-|" options:0 metrics:nil views:@{@"headerView": _headerView}]];
		[_headerHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headerView]" options:0 metrics:nil views:@{@"headerView": _headerView}]];
		NSLayoutConstraint* headerViewBottomContraint = [NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_headerHolder attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
		headerViewBottomContraint.priority = 500;
		[_headerHolder addConstraint:headerViewBottomContraint];
	}
	else
	{
		[_headerView removeFromSuperview];
		headerHolderMaxHeightCon.constant = 0;
	}
}

-(void)setHeaderView:(UIView *)headerView
{
	[self _setHeaderView:headerView];
	headerHolderMaxHeightCon.constant = 10000;
}

-(void)setHeaderView:(UIView *)headerView animated:(BOOL)animated
{
	if (headerView)
	{
		[self _setHeaderView:headerView];
		
		[_headerHolder layoutIfNeeded];
		
		headerHolderMaxHeightCon.constant = 10000;
        
        [UIView animateWithDuration: animated ? .3 : 0 animations:^{
			[self layoutIfNeeded];
		}];
	}
	else
	{
		headerHolderMaxHeightCon.constant = 0;
		
		[UIView animateWithDuration: animated ? .3 : 0 animations:^{
			[self layoutIfNeeded];
		} completion:^(BOOL finished) {
			[self _setHeaderView:headerView];
		}];
	}
}

-(void)expandNodeAtPath:(NSString*)path
{
	NSMutableDictionary* treeNode = [self findNodeDictionaryWithPath:path];
	HyperTreeViewNode* possibleNode;
	
	if (treeNode[@"node"])
	{
		possibleNode = treeNode[@"node"];
	}
	
	if (!possibleNode) return;
	
	[possibleNode expandContentView];
}

-(void)collapseNodeAtPath:(NSString*)path
{
	NSMutableDictionary* treeNode = [self findNodeDictionaryWithPath:path];
	HyperTreeViewNode* possibleNode;
	
	if (treeNode[@"node"])
	{
		possibleNode = treeNode[@"node"];
	}
	
	if (!possibleNode) return;
	
	[possibleNode collapse:_alsoCollapseDescendantNodes];
}


-(void)loadItemsForPath:(NSString*)path items:(nullable NSArray*)items options:(HyperTreeViewOption)options
{
	BOOL shouldNotExpand = options & HyperTreeViewOptionDoNotExpand;
	
	NSMutableDictionary* treeNode = [self findNodeDictionaryWithPath:path];
	BOOL isRoot = true;
	
	UIView* parentView = _rootView;
	HyperTreeViewNode* possibleNode;
	
	if (treeNode[@"node"])
	{
		isRoot = false;
		possibleNode = treeNode[@"node"];
		parentView = possibleNode.contentView;
	}
	
	NSMutableDictionary* itemsSubTree = treeNode[@"items"];
	if (!itemsSubTree)
	{
		itemsSubTree = [NSMutableDictionary new];
		treeNode[@"items"] = itemsSubTree;
	}
	
	int i = 0;
	UIView* upperObject;
	for (NSDictionary* anItem in items) {
		
		HyperTreeViewNode* aNode;
		
		if (!anItem[@"type"] || [anItem[@"type"] isEqualToString:@"normal"])
		{
			aNode = [[HyperTreeViewNode alloc] initForNormal];
			aNode.label.text = anItem[@"title"];
			if (anItem[@"font"])
				aNode.label.font = anItem[@"font"];
			
			UIColor* textColor = [self defaultTextColor];
			if (anItem[@"textColor"])
				textColor = anItem[@"textColor"];
			aNode.label.textColor = textColor;
		}
		else if ([anItem[@"type"] isEqualToString:@"customView"])
		{
			aNode = [[HyperTreeViewNode alloc] initWithCustomView:anItem[@"view"]];
		}
		
		UIColor* defaultHeaderBackgroundColor = [self defaultHeaderBackgroundColor];
		if (anItem[@"headerBackgroundColor"])
			defaultHeaderBackgroundColor = anItem[@"headerBackgroundColor"];
		
		UIColor* defaultContentBackgroundColor = [self defaultContentBackgroundColor];
		if (anItem[@"contentBackgroundColor"])
			defaultContentBackgroundColor = anItem[@"contentBackgroundColor"];
		
		NSString* defaultIdentifier = [NSString stringWithFormat:@"%d", i];
		if (anItem[@"id"])
			defaultIdentifier = anItem[@"id"];
		
		aNode.header.backgroundColor = defaultHeaderBackgroundColor;
		aNode.contentView.backgroundColor = defaultContentBackgroundColor;
		aNode.object = anItem[@"object"];
		aNode.parent = isRoot ? nil : possibleNode;
		aNode.identifier = defaultIdentifier;
		aNode.delegate = self;
		aNode.translatesAutoresizingMaskIntoConstraints = NO;
		[parentView addSubview:aNode];
		
		UIEdgeInsets insets = UIEdgeInsetsMake(0, isRoot ? 0 : 20, 0, 0);
		if (anItem[@"insets"])
			insets = [anItem[@"insets"] UIEdgeInsetsValue];
		
//		[aNode sdc_alignEdgesWithSuperview:UIRectEdgeLeft | UIRectEdgeRight insets:UIEdgeInsetsMake(0, insets.left, 0, insets.right)];
        [parentView addConstraint: [NSLayoutConstraint constraintWithItem:aNode attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:insets.left]];
        [parentView addConstraint: [NSLayoutConstraint constraintWithItem:aNode attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:insets.right]];
        
        

		
        if (!upperObject)
            
//			[aNode sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsMake(isRoot ? 40 : 10, 0, 0, 0)];
            [parentView addConstraint:[NSLayoutConstraint constraintWithItem:aNode attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:insets.top]];
        else
//			[aNode sdc_alignEdge:UIRectEdgeTop withEdge:UIRectEdgeBottom ofView:upperObject inset:10];
            [parentView addConstraint:[NSLayoutConstraint constraintWithItem:aNode attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:upperObject attribute:NSLayoutAttributeBottom multiplier:1.0 constant:insets.top]];
		
		itemsSubTree[defaultIdentifier] = @{@"node": aNode, @"items": [NSMutableDictionary new]};
		aNode.treeNode = itemsSubTree[defaultIdentifier];
		
		upperObject = aNode;
		
		i++;
	}
	
	NSLayoutConstraint* bottomMostItemBottomCon = [NSLayoutConstraint constraintWithItem:upperObject attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
	bottomMostItemBottomCon.priority = 999;
	[parentView addConstraint:bottomMostItemBottomCon];
	
	if (isRoot)
	{
		if (shouldNotExpand)
		{
			[parentView layoutIfNeeded];
		}
		else
		{
            rootViewMaxHeightCon.constant = 10000;
			[parentView layoutIfNeeded];
			
			[UIView animateWithDuration:.3 animations:^{
				[self layoutIfNeeded];
			}];
		}
	}
	else
	{
		if (shouldNotExpand)
		{
			[possibleNode.contentView layoutIfNeeded];
		}
		else
			[possibleNode expandContentView];
	}
}

-(NSMutableDictionary*)findNodeDictionaryWithPath:(NSString*)path
{
	NSArray* pathComponents = [path componentsSeparatedByString:@"."];
	NSMutableDictionary* lastDic;
	for (NSString* anIdent in pathComponents) {
		if (!lastDic)
			lastDic = treeDescriptor[anIdent];
		else
			lastDic = lastDic[@"items"][anIdent];
	}
	
	return lastDic;
}

-(void)HyperTreeViewDidTouchNode:(HyperTreeViewNode *)node isFirstTime:(BOOL)firstTime
{
	
	if (_automaticallyCollapseNodes && node.isExpanded)
	{
		[node collapse:_alsoCollapseDescendantNodes];
	}
	else
	{
		
		NSMutableArray* pathItems = [NSMutableArray new];
		HyperTreeViewNode* aNode = node;
		while (aNode)
		{
			[pathItems addObject:aNode.identifier];
			aNode = aNode.parent;
		}
		[pathItems addObject:@"root"];
		
		NSString* path = [[pathItems.reverseObjectEnumerator allObjects] componentsJoinedByString:@"."];
		
		[_treeDelegate HyperTreeViewDidTouchItemAtPath:path withObject:node.object options:@{@"isExpanded": @(node.isExpanded), @"firstTime": @(firstTime)}];
	}
}

-(void)HyperTreeViewNodeDidExpand:(HyperTreeViewNode *)node
{
	CGRect someRect = [node convertRect:node.bounds toView:self];
	[self scrollRectToVisible:someRect animated:YES];
}

-(UIColor *)defaultHeaderBackgroundColor
{
	if (!_defaultHeaderBackgroundColor)
	{
		_defaultHeaderBackgroundColor = [UIColor groupTableViewBackgroundColor];
	}
	
	return _defaultHeaderBackgroundColor;
}

-(UIColor *)defaultContentBackgroundColor
{
	if (!_defaultContentBackgroundColor)
	{
		_defaultContentBackgroundColor = [UIColor lightGrayColor];
	}
	return _defaultContentBackgroundColor;
}

-(UIColor *)defaultTextColor
{
	if (!_defaultContentBackgroundColor)
	{
		_defaultContentBackgroundColor = [UIColor darkGrayColor];
	}
	return _defaultContentBackgroundColor;
}

@end
