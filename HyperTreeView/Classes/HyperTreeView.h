//
//  HyperTreeView.h
//  HyperTreeView
//
//  Created by Hamidreza Vakilian on 10/24/16.
//  Copyright © 2016 Innovian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 */
typedef NS_OPTIONS(NSUInteger, HyperTreeViewOption) {
	HyperTreeViewOptionNone				= 0,
	HyperTreeViewOptionDoNotExpand		= 1 << 0,
};

/**
 *
 */
@protocol HyperTreeViewDelegate <NSObject>
//-(NSUInteger)numberOfItemsAtPath:(nonnull NSString*)path;
-(void)HyperTreeViewDidTouchItemAtPath:(nonnull NSString*)path withObject:(nullable id)object options:(nullable NSDictionary*)options;
@end

@interface HyperTreeView : UIScrollView

@property (weak, nonatomic, nullable) id<HyperTreeViewDelegate> treeDelegate;
@property (retain, nonatomic, nullable) UIView* headerView;
@property (retain, nonatomic, nullable) UIView* footerView;
@property (retain, nonatomic, nonnull) UIColor* defaultHeaderBackgroundColor;
@property (retain, nonatomic, nonnull) UIColor* defaultContentBackgroundColor;
@property (retain, nonatomic, nonnull) UIColor* defaultTextColor;

/**
 *When you don't want to expand a cell automatically, you should set this parameter equals to false.
 */
@property (nonatomic) BOOL automaticallyCollapseNodes;

/**
 *When you want to expand a cell Immediately after loading it, you must set this parameter equals to true.
 */
@property (nonatomic) BOOL alsoCollapseDescendantNodes;

/**
 *
 *@param path   path is the address for the cell which has been asked to load.
 *@param items  is an array of informations of nodes.
 *@param optinos
 */
-(void)loadItemsForPath:(nonnull NSString*)path items:(nullable NSArray*)items options:(HyperTreeViewOption)options;

/**
 *Putting up the headerView.
 *@param headerView     If headerView equals to null, the height of headerView. is equal to zero
 *@param animated       If animated equals to false, advent of headerView doesn't have any animation.
 */
-(void)setHeaderView:( nullable UIView * )headerView animated:(BOOL)animated;

/**
 *Expanding the node.
 *@param path       path is the address of the node which has been asked to expand.
 */
-(void)expandNodeAtPath:(nonnull NSString*)path;

/**
 *closing the node.
 *@param path       path is the address of the cell which has been asked to close.
 */
-(void)collapseNodeAtPath:(nonnull NSString*)path;

/**
 *Putting up the footerView.
 *@param footerView     If headerView equals to null, the height of headerView. is equal to zero
 *@param animated       If animated equals to false, advent of headerView doesn't have any animation.
 */
-(void)setFooterView:(UIView * _Nullable)footerView animated:(BOOL)animated;

@end
