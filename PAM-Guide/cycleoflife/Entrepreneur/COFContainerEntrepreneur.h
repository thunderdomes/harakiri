//
//  COFContainer.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/19/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"


@interface COFContainerEntrepreneur : UIViewController <UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIGestureRecognizerDelegate>
{
    
    int PAGE_COUNT;
    int VIEW_WIDTH;
    int VIEW_HEIGHT;
    
    int currpage;
    
    IBOutlet UIScrollView *scroller;
    IBOutlet UIPageControl *pager;
    UIViewController *subv;
    Form *Form;
    
    BOOL scrolled;
    BOOL exists;
    BOOL pageControlUsed;
    
    
}

@property (nonatomic, strong) Form *Form;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIButton *back;

- (UIViewController*)configurePage:(int)index;
-(IBAction)scrollto:(id)sender;
-(void)scrolltopage:(int) pagenumber;
-(IBAction)gotopage:(id)sender;






@end
