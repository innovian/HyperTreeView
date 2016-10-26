//
//  exampleViewController.m
//  HyperTreeView
//
//  Created by H.Vakilian on 10/26/2016.
//  Copyright (c) 2016 H.Vakilian. All rights reserved.
//

#import "exampleViewController.h"
#import "helper.h"
#import "UIView+SDCAutoLayout.h"
#import "MySampleView.h"
#import "HyperTreeView.h"


@interface exampleViewController ()
{
	HyperTreeView* treeView;
}

@end

@implementation exampleViewController

-(void)HyperTreeViewDidTouchItemAtPath:(NSString *)path withObject:(nullable id)object options:(NSDictionary*)options
{
	if ([options[@"firstTime"] boolValue])
	{
		NSDictionary* dic = object;
		
		NSString* urlPath = [NSString stringWithFormat:@"featurettes/%@", dic[@"id"]];
		NSURLSessionTask* task = [helper serverGetWithPath:urlPath completion:^(long response_code, id obj) {
			
			dispatch_async(dispatch_get_main_queue(), ^{
				if (response_code == 200)
				{
					NSMutableArray* items = [NSMutableArray new];
					
					for (NSDictionary* itemOnServer in obj)
					{
						[items addObject:@{@"title": itemOnServer[@"name"], @"type": @"normal", @"object": itemOnServer, @"insets": [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)], @"textColor": [UIColor whiteColor], @"font": [UIFont fontWithName:@"HelveticaNeue-Italic" size:15]}];
					}
					
					[treeView loadItemsForPath:path items:items options:HyperTreeViewOptionDoNotExpand];
					[treeView expandNodeAtPath:path];
				}
			});
			
		}];
		
		[task resume];
	}
	else
	{
		if (![options[@"isExpanded"] boolValue])
			[treeView expandNodeAtPath:path];
		else
			[treeView collapseNodeAtPath:path];
	}
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		UIView* myHeader = [UIView new];
		myHeader.backgroundColor = [UIColor yellowColor];
		[myHeader.heightAnchor constraintEqualToConstant:300].active = true;
		UILabel* lbl = [UILabel new];
		lbl.translatesAutoresizingMaskIntoConstraints = NO;
		lbl.text = @"HELLO";
		lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:60];
		[myHeader addSubview:lbl];
		[lbl sdc_centerInSuperview];
		
		//		[treeView setHeaderView:myHeader animated:YES];
	});
	
	treeView = [HyperTreeView new];
	treeView.treeDelegate = self;
	treeView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:treeView];
	
	
	treeView.defaultHeaderBackgroundColor = [UIColor blackColor];
	
	[treeView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
	treeView.automaticallyCollapseNodes = false;
	
	//   [self.view addConstraint:[NSLayoutConstraint constraintWithItem:treeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
	//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:treeView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
	//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:treeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
	//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:treeView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
	
	
	//	NSURLSessionTask* task = [helper serverGetWithPath:@"featurettes" completion:^(long response_code, id obj) {
	//		dispatch_async(dispatch_get_main_queue(), ^{
	//			if (response_code == 200)
	//			{
	//				NSArray* theMainCats = obj;
	//
	//				NSMutableArray* items = [NSMutableArray new];
	//
	//				for (NSDictionary* itemOnServer in theMainCats)
	//				{
	//					[items addObject:@{@"title": itemOnServer[@"name"],
	//									   @"type": @"normal",
	//									   @"id": itemOnServer[@"name"],
	//									   @"object": itemOnServer,
	//									   @"insets": [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)],
	//									   @"headerBackgroundColor": [UIColor yellowColor],
	//									   @"contentBackgroundColor": [UIColor blueColor]}];
	//				}
	//
	//				UIView* customView = [UIView new];
	//				customView.backgroundColor = [UIColor greenColor];
	//				customView.translatesAutoresizingMaskIntoConstraints = NO;
	//				//[customView.heightAnchor constraintEqualToConstant:100].active = true;
	//				NSLayoutConstraint* someCon = [customView sdc_pinHeight:100];
	//
	//				UIImageView* imageView = [UIImageView new];
	//				imageView.contentMode = UIViewContentModeScaleAspectFill;
	//				imageView.clipsToBounds = YES;
	//				imageView.translatesAutoresizingMaskIntoConstraints = NO;
	//				[customView addSubview:imageView];
	//				imageView.image = [UIImage imageNamed:@"sample.jpg"];
	//				[imageView sdc_alignEdgesWithSuperview:UIRectEdgeAll];
	//
	//				UILabel* label = [UILabel new];
	//				label.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:14];
	//				label.textColor = [UIColor whiteColor];
	//				label.translatesAutoresizingMaskIntoConstraints = NO;
	//				[customView addSubview:label];
	//				[label sdc_alignEdgesWithSuperview:UIRectEdgeLeft | UIRectEdgeBottom insets:UIEdgeInsetsMake(0, 5, -5, 0)];
	//
	//
	////                [customView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:customView attribute:NSLayoutRelationLeft multiplier:1.0 constant:5]];
	//
	//				label.text = @"Our New Products...";
	//				label.layer.shadowOpacity = 1;
	//				label.layer.shadowColor = [UIColor blackColor].CGColor;
	//				label.layer.shadowRadius = 3;
	//
	//
	//				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	//					someCon.constant = 200;
	//					//						[customView.heightAnchor constraintEqualToConstant:200];
	//					//						[self.view setNeedsLayout];
	//
	//					[UIView animateWithDuration:.3 animations:^{
	//						[treeView layoutIfNeeded];
	//					}];
	//				});
	//				items[1] = @{@"view": customView, @"type": @"customView", @"object": theMainCats[1]};
	//
	//
	//				[treeView loadItemsForPath:@"root" items:items options:0];
	//
	//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	//                    UIView* myfooter = [UIView new];
	//                    [myfooter.heightAnchor constraintEqualToConstant:100].active = true;
	//                    myfooter.backgroundColor = [UIColor blueColor];
	//                    myfooter.translatesAutoresizingMaskIntoConstraints = NO;
	//                    [treeView setFooterView:myfooter animated:YES];
	//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	//                        [treeView setFooterView:nil animated:YES];
	//                    });
	//
	//                });
	//			}
	//		});
	//
	//	}];
	//
	//	[task resume];
	
	[self loadRootItems];
	
}

-(BOOL)prefersStatusBarHidden
{
	return YES;
}

-(void)loadRootItems
{
	NSMutableArray* items = [NSMutableArray new];
	
	MySampleView* makeUpView = [MySampleView new];
	makeUpView.translatesAutoresizingMaskIntoConstraints = NO;
	[makeUpView sdc_pinHeight:150];
	makeUpView.imageView.image = [UIImage imageNamed:@"1.jpg"];
	makeUpView.label.text = @"MAKE UP";
	UIColor* makeupColor = [UIColor colorWithRed:0.987 green:0.936 blue:0.333 alpha:1];
	makeUpView.hairLine.backgroundColor = makeupColor;
	[items addObject:@{@"view": makeUpView, @"type": @"customView", @"object": @{@"name": @"makeup"}, @"contentBackgroundColor": makeupColor}];
	
	MySampleView* skinCareView = [MySampleView new];
	skinCareView.translatesAutoresizingMaskIntoConstraints = NO;
	[skinCareView sdc_pinHeight:150];
	skinCareView.imageView.image = [UIImage imageNamed:@"2.jpg"];
	skinCareView.label.text = @"SKIN CARE";
	UIColor* skinCareColor = [UIColor colorWithRed:0.942 green:0.902 blue:0.893 alpha:1];
	skinCareView.hairLine.backgroundColor = skinCareColor;
	[items addObject:@{@"view": skinCareView, @"type": @"customView", @"object": @{@"name": @"skinCare"}, @"contentBackgroundColor": skinCareColor}];
	
	MySampleView* shadowView = [MySampleView new];
	shadowView.translatesAutoresizingMaskIntoConstraints = NO;
	[shadowView sdc_pinHeight:150];
	shadowView.imageView.image = [UIImage imageNamed:@"3.jpg"];
	shadowView.label.text = @"SHADOW";
	UIColor* shadowColor =[UIColor colorWithRed:0.693 green:0.233 blue:0.443 alpha:1];
	shadowView.hairLine.backgroundColor = shadowColor;
	[items addObject:@{@"view": shadowView, @"type": @"customView", @"object": @{@"name": @"shadow"}, @"contentBackgroundColor": shadowColor}];
	
	MySampleView* powderView = [MySampleView new];
	powderView.translatesAutoresizingMaskIntoConstraints = NO;
	[powderView sdc_pinHeight:150];
	powderView.imageView.image = [UIImage imageNamed:@"4.jpg"];
	powderView.label.text = @"POWDER";
	UIColor* powderColor = [UIColor colorWithRed:0.923 green:0.704 blue:0.503 alpha:1];
	powderView.hairLine.backgroundColor = powderColor;
	[items addObject:@{@"view": powderView, @"type": @"customView", @"object": @{@"name": @"powder"}, @"contentBackgroundColor": powderColor}];
	
	MySampleView* concealerView = [MySampleView new];
	concealerView.translatesAutoresizingMaskIntoConstraints = NO;
	[concealerView sdc_pinHeight:150];
	concealerView.imageView.image = [UIImage imageNamed:@"5.jpg"];
	concealerView.label.text = @"CONCEALER";
	UIColor* concealerColor = [UIColor colorWithRed:0.452 green:0.191 blue:0.117 alpha:1];
	concealerView.hairLine.backgroundColor = concealerColor;
	[items addObject:@{@"view": concealerView, @"type": @"customView", @"object": @{@"name": @"concealer"}, @"contentBackgroundColor": concealerColor}];
	
	MySampleView* eyesView = [MySampleView new];
	eyesView.translatesAutoresizingMaskIntoConstraints = NO;
	[eyesView sdc_pinHeight:150];
	eyesView.imageView.image = [UIImage imageNamed:@"6.jpg"];
	eyesView.label.text = @"EYES";
	UIColor* eyesColor = [UIColor colorWithRed:0.269 green:0.660 blue:0.827 alpha:1];
	eyesView.hairLine.backgroundColor = eyesColor;
	[items addObject:@{@"view": eyesView, @"type": @"customView", @"object": @{@"name": @"eyes"}, @"contentBackgroundColor": eyesColor}];
	
	MySampleView* lipsView = [MySampleView new];
	lipsView.translatesAutoresizingMaskIntoConstraints = NO;
	[lipsView sdc_pinHeight:150];
	lipsView.imageView.image = [UIImage imageNamed:@"7.jpg"];
	lipsView.label.text = @"LIPS";
	UIColor* lipsColor = [UIColor colorWithRed:0.987 green:0.122 blue:0.613 alpha:1];
	lipsView.hairLine.backgroundColor = lipsColor;
	[items addObject:@{@"view": lipsView, @"type": @"customView", @"object": @{@"name": @"lips"}, @"contentBackgroundColor": lipsColor}];
	
	MySampleView* browView = [MySampleView new];
	browView.translatesAutoresizingMaskIntoConstraints = NO;
	[browView sdc_pinHeight:150];
	browView.imageView.image = [UIImage imageNamed:@"8.jpg"];
	browView.label.text = @"BROW";
	UIColor* browColor = [UIColor colorWithRed:0.886 green:0.741 blue:0.690 alpha:1];
	browView.hairLine.backgroundColor = browColor;
	[items addObject:@{@"view": browView, @"type": @"customView", @"object": @{@"name": @"brow"}, @"contentBackgroundColor": browColor}];
	
	[treeView loadItemsForPath:@"root" items:items options:0];
}

//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		someCon.constant = 300;
//
//		[UIView animateWithDuration:.3 animations:^{
//			[treeView layoutIfNeeded];
//		}];
//	});

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
