//
//  HyperTreeViewNode.h
//  HyperTreeView
//
//  Created by Hamidreza Vakilian on 10/24/16.
//  Copyright © 2016 Innovian. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HyperTreeViewNode;

/**
 *
 */
@protocol HyperTreeViewNodeDelegate <NSObject>

-(void)HyperTreeViewDidTouchNode:(HyperTreeViewNode*)node isFirstTime:(BOOL)firstTime;
-(void)HyperTreeViewNodeDidExpand:(HyperTreeViewNode*)node;

@end

@interface HyperTreeViewNode : UIView


@property (retain, nonatomic) UILabel* label;

/**
 *
 */
@property (retain, nonatomic) id object;
@property (weak, nonatomic) HyperTreeViewNode* parent;

/**
 *
 */
@property (weak, nonatomic) NSDictionary* treeNode;
@property (retain, nonatomic) NSString* identifier;
@property (readonly) BOOL isExpanded;
@property (retain, nonatomic) UIView* contentView;
@property (retain, nonatomic) UIView* header;

/**
 *
 */
@property (weak, nonatomic) id <HyperTreeViewNodeDelegate> delegate;




///------------------------------------------------
/// Configuring Row for the TreeView
///------------------------------------------------


/**
 *
 */
+(void)setSuperView2Layout:(UIView*)view;

/**
 *
 */
-(instancetype)initWithCustomView:(UIView*)view;

/**
 *
 */
-(instancetype)initForNormal;

/**
 *
 */
-(void)expandContentView;

/**
 *
 */
-(void)collapse:(BOOL)collapseDescendants;
@end
