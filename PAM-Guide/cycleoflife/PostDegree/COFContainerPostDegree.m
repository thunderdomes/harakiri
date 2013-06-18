//
//  COFContainerHoliday.m
//  PAM-Guide
//
//  Created by Panin Sekuritas 2 on 5/30/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "COFContainerPostDegree.h"
#import "MBProgressHUD.h"
#import "COF_PostDegree.h"

@interface COFContainerPostDegree ()

@end

@implementation COFContainerPostDegree

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                VIEW_WIDTH = 320;
                VIEW_HEIGHT = 480;
                PAGE_COUNT = 3;
                
            }
            if(result.height == 568)
            {
                // iPhone 5
                VIEW_WIDTH = 320;
                VIEW_HEIGHT = 568;
                PAGE_COUNT = 3;
                
            }
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            VIEW_WIDTH = 1024;
            VIEW_HEIGHT = 768;
            PAGE_COUNT = 7;
        }
    }
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    currpage = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrolltopagenotification:)
                                                 name:@"scrolltopage"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(back:)
                                                 name:@"backbuttonpressed"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backchapter:)
                                                 name:@"backbuttonpressedchapter"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(noScrollForPopUP)
                                                 name:@"photoshow"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backtoswipe)
                                                 name:@"removephotoshow"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hidingpager)
                                                 name:@"hidepager"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showingpager)
                                                 name:@"showpager"
                                               object:nil];
    
    
    return self;
    
}

- (void)scrolltopagenotification:(NSNotification *)note {
    
    NSDictionary *theData = [note userInfo];
    if (theData != nil) {
        NSNumber *n = [theData objectForKey:@"page"];
        [self scrolltopage:[n intValue]];
    }
}

- (IBAction)backchapter:(id)sender {
    
    [self scrolltopage:0];
}

- (void)hidingpager
{
    pager.hidden = YES;
    
}

- (void)showingpager
{
    pager.hidden = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    pager.numberOfPages = PAGE_COUNT;
    [self.pageViewController setViewControllers:[NSArray arrayWithObject:[self configurePage:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    
    pager.currentPage = 0;
    self.pageViewController.view.frame = CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height);
    
    [scroller addSubview:self.pageViewController.view];
    
    
    for (UIGestureRecognizer *gR in _pageViewController.view.gestureRecognizers) {
        if ([gR isKindOfClass:[UITapGestureRecognizer class]])
        {
            gR.enabled = NO;
        }
        else if ([gR isKindOfClass:[UISwipeGestureRecognizer class]])
        {
            // gR.delegate = self;
        }
        //gR.enabled = NO;
    }
    
    
    pager.currentPage = 0;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
{
    
    NSUInteger index = vc.view.tag;
    NSLog(@"currpage : %d",currpage);
    //int before = (index-1);//==-1?(PAGE_COUNT-1):(index-1);
    int before = (index-1)==-1?(PAGE_COUNT-1):(index-1);
    
    currpage = before;
    
    //isBack = YES;
    if (before == (PAGE_COUNT - 1)) {
        return nil;
    } else {
        return [self configurePage:before];
    }
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
{
    NSUInteger index = vc.view.tag;
    NSLog(@"hal : %d",index);
    int after = (index+1);//==PAGE_COUNT?0:(index+1);
    currpage = after;
    //pager.currentPage = index+1;
    
    //return [self configurePage:after];
    
    if(after<PAGE_COUNT){
        currpage = after;
        pager.currentPage = index+1;
        
        
        
        return [self configurePage:after];
    }
    
    if(![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Configure for text only and offset down
        //hud.mode = MBProgressHUDModeText;
        hud.labelText = @"End of chapter";
        //hud.margin = 10.f;
        //hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }
    return nil;
    
    
    
}



- (void)pageViewController:(UIPageViewController *)pvc didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // If the page did not turn
    if (!completed)
    {
        NSLog(@"not completed");
        pager.currentPage = -1;
    }else{
        pager.currentPage = currpage;
    }
    
    
    // This is where you would know the page number changed and handle it appropriately
    // [self sendPageChangeNotification:YES];
}


- (UIViewController*)configurePage:(NSUInteger)index
{
    
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
            
        {
            switch (index+1) {
                case 1:
                    //   self.Form = [[Chapter_4 alloc] initWithNibName:@"Chapter_4_iphone4" bundle:nil] ;
                    break;
                case 2:
                    //  self.Form = [[Chapter_4_1 alloc] initWithNibName:@"Chapter_4_1_iphone4" bundle:nil] ;
                    break;
                case 3:
                    //self.Form = [[Chapter_4_2 alloc] initWithNibName:@"Chapter_4_2_iphone4" bundle:nil];
                    break;
                    
                default:
                    self.Form = nil;
                    break;
            }
            
        }
        
        if(result.height == 568)
        {
            switch (index+1) {
                case 1:
                    //   self.Form = [[Chapter_4 alloc] initWithNibName:@"Chapter_4_iphone5" bundle:nil] ;
                    break;
                case 2:
                    // self.Form = [[Chapter_4_1 alloc] initWithNibName:@"Chapter_4_1_iphone5" bundle:nil] ;
                    break;
                case 3:
                    //self.Form = [[Chapter_4_2 alloc] initWithNibName:@"Chapter_4_2_iphone5" bundle:nil];
                    break;
                    
                default:
                    self.Form = nil;
                    break;
            }
            
        }
    }
    else
    {
        
        NSLog(@"ipad current page: %d",(index+1));
        switch (index+1) {
            case 1:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree" bundle:nil] ;
                break;
            case 2:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree2" bundle:nil] ;
                break;
            case 3:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree3" bundle:nil];
                break;
            case 4:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree4" bundle:nil];
                break;
            case 5:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree5" bundle:nil];
                break;
            case 6:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree6" bundle:nil];
                break;
            case 7:
                self.Form = [[COF_PostDegree alloc] initWithNibName:@"COF_PostDegree7" bundle:nil];
                break;
           
            default:
                self.Form = nil;
                break;
        }
    }
    
    self.Form.view.frame = CGRectMake( VIEW_WIDTH * index, 0, VIEW_WIDTH, VIEW_HEIGHT);
    self.Form.view.tag = index;
    
    return self.Form;
}

#pragma scrollview delegate

-(IBAction)back:(id)sender
{
    [self.view removeFromSuperview];
    
}


-(void)scrolltopage:(int) pagenumber
{
    [self.pageViewController setViewControllers:@[[self configurePage:pagenumber]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:NULL];
    pager.currentPage = pagenumber;
    
}

- (void)noScrollForPopUP {
    
    for (UIGestureRecognizer *gR in _pageViewController.view.gestureRecognizers) {
        
        if ([gR isKindOfClass:[UITapGestureRecognizer class]])
        {
            gR.enabled = NO;
            
        }
        else if ([gR isKindOfClass:[UISwipeGestureRecognizer class]])
        {
            gR.delegate = self;
        }
        
        gR.enabled = NO;
    }
    
}


-(void)backtoswipe {
    
    for (UIGestureRecognizer *gR in _pageViewController.view.gestureRecognizers) {
        
        if ([gR isKindOfClass:[UITapGestureRecognizer class]])
        {
            gR.enabled = NO;
            
        }
        else if ([gR isKindOfClass:[UISwipeGestureRecognizer class]])
        {
            gR.delegate = self;
        }
        
        gR.enabled = YES;
    }
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([touch.view isKindOfClass:[UISlider class]]) {
//        // prevent recognizing touches on the slider
//        return NO;
//    }
//    return NO;
//}





@end
