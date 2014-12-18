//
//  picScrollView.h
//  PicScrollView
//
//  Created by binzai on 14/12/18.
//  Copyright (c) 2014年 binzai. All rights reserved.
//

#ifndef _PICSCROLLVIEW_H_

#define _PICSCROLLVIEW_H_

#import <UIKit/UIKit.h>

@class picScrollView;
@protocol  PicScrollViewDelegate

@optional
- (void)imgDidTaped:(UIImageView *)imgView andPicScrollView:(picScrollView *)sv andPicIndex:(int)index;

@end

@interface picScrollView : UIScrollView

@property(nonatomic,strong) NSMutableArray *picArray;
@property(nonatomic,assign) NSUInteger picArrayCount;
@property(nonatomic) float  labelHeight;
@property(nonatomic,assign) id <PicScrollViewDelegate>picDelegate;

-(void)set:(float)originX withPic: (NSString *)imageUrl;

@end

#endif  // _PICSCROLLVIEW_H_