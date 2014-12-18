//
//  ViewController.m
//  PicScrollView
//
//  Created by binzai on 14/12/18.
//  Copyright (c) 2014年 binzai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picScrollView = [[picScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 1.8)];
    self.picScrollView.delegate = self;
    self.picScrollView.picDelegate = self;
    [self.view addSubview:self.picScrollView];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.picScrollView.frame.size.width - 50, self.picScrollView.frame.size.height - 15, 1, 1)];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.picScrollView.picArrayCount;
    self.pageControl.currentPage = 0;
    self.picScrollView.pagingEnabled = YES;
    self.picScrollView.showsHorizontalScrollIndicator = NO;
    [self.picScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startTimerRun {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
}

#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始拖动scrollview的时候 停止计时器控制的跳转
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGRect r = [ UIScreen mainScreen ].bounds;
    _currentPageIndex = self.picScrollView.contentOffset.x / r.size.width;
    if (_currentPageIndex == 0) {
        [scrollView setContentOffset:CGPointMake(self.picScrollView.picArrayCount*r.size.width, 0)];
        self.pageControl.currentPage = self.picScrollView.picArrayCount - 1;
    }
    else if (_currentPageIndex == self.picScrollView.picArrayCount+1) {
        
        [scrollView setContentOffset:CGPointMake(r.size.width, 0)];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = _currentPageIndex - 1;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
}

-(void)scrollTimer{
    
    CGFloat pageWidth = self.picScrollView.frame.size.width;
    int currentPage = self.picScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.picScrollView.picArrayCount - 1;
    }
    else if (currentPage == self.picScrollView.picArrayCount + 1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage - 1;
    }
    NSUInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.picScrollView.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    [self.picScrollView scrollRectToVisible:rect animated:YES];
    currPageNumber++;
    if (currPageNumber == self.picScrollView.picArrayCount) {
        self.pageControl.currentPage = 0;
        [self.picScrollView setContentOffset:CGPointMake(0, 0)];
        currPageNumber = 0;
    }
    self.pageControl.currentPage = currPageNumber;
}

// scroll 的某个图片被点击后打开相应的文章内容阅读页面
#pragma mark PicListTopScrollViewDelegate
-(void)imgDidTaped:(UIImageView *)imgView andPicScrollView:(picScrollView *)sv andPicIndex:(int)index
{
    NSLog(@"index: %i",index);
    [_timer invalidate];
    _timer = nil;
    
}

@end
