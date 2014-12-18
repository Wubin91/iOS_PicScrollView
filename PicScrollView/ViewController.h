//
//  ViewController.h
//  PicScrollView
//
//  Created by binzai on 14/12/18.
//  Copyright (c) 2014年 binzai. All rights reserved.
//

#ifndef _VIEWCONTROLLER_H_

#define _VIEWCONTROLLER_H_

#import <UIKit/UIKit.h>
#import "picScrollView.h"

@interface ViewController : UIViewController<UIScrollViewDelegate, PicScrollViewDelegate>

@property(nonatomic,strong) picScrollView *picScrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) int currentPageIndex;

@end

#endif // _VIEWCONTROLLER_H_
