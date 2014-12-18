//
//  picScrollView.m
//  PicScrollView
//
//  Created by binzai on 14/12/18.
//  Copyright (c) 2014年 binzai. All rights reserved.
//

#import "picScrollView.h"

@implementation picScrollView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.picArrayCount = [self.picArray count];
        self.labelHeight = 50;
        NSMutableArray *picArray = [[NSMutableArray alloc]initWithArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil]];
        self.picArray = picArray;
        self.picArrayCount = [self.picArray count];
        [self baseInit];
    }
    return self;
}

-(void)removeSubviews
{
    for (UIView *subView in [self subviews]) {
        [subView removeFromSuperview];
    }
}

-(void)baseInit
{
    [self removeSubviews];
    float originX = 0;
    float width = self.frame.size.width;
    [self set:originX withPic:self.picArray[self.picArrayCount - 1]];
    originX += width;
    for(NSString *imageUrl in self.picArray) {
        [self set:originX withPic:imageUrl];
        originX += width;
    }
    [self set:originX withPic:self.picArray[0]];
    [self setContentSize:CGSizeMake(width * (self.picArrayCount + 2), self.frame.size.height)];
}

-(void)set:(float)originX withPic: (NSString *)imageUrl {
    UIImageView *scrollView = [[UIImageView alloc]initWithFrame:CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    scrollView.image = [UIImage imageNamed:imageUrl];
    [self addSubview:scrollView];
}

// delegate
-(void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    UIImageView *imgView = (UIImageView *)sender.view;
    int currentPage = self.contentOffset.x / self.frame.size.width - 1;
    if (self.picDelegate) {
        [self.picDelegate imgDidTaped:imgView andPicScrollView:self andPicIndex:currentPage];
    }
}

@end
