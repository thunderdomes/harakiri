//
//  ViewController.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/14/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "ViewController.h"
#import "KalkulatorKebutuhanInvestasi.h"
#import "KalkulatorInvestasiBerkala.h"
#import "KalkulatorHasilInvestasi.h"
#import "KalkulatorHasilInvestasiBerkala.h"
#import "NasabahView.h"
#import "COFKendaraan.h"
#import "COF_PostDegree.h"
#import "COFMarriage.h"
#import "COFHoliday.h"
#import "COF_Entrepreneur.h"
#import "SimulasiBerkala.h"
#import "NewsCell.h"
#import "NAVCell.h"
#import "SVWebViewController.h"
#import "COFContainer.h"
#import "LoginMitra.h"
#import "COFCoverMenu.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "SidebarViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize subv,vertical,leftSidebarViewController,rightSidebarView,leftSelectedIndexPath;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closefader)
                                                     name:@"closefader"
                                                   object:nil];

      //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
        
    }
    return self;
}



-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    return (interfaceOrientation != UIInterfaceOrientationPortrait);
}


-(void)viewDidAppear:(BOOL)animated
{
    
    //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Loading Data"];
    
    
    //fetch the feed
    _feed = [[NewsFeed alloc] initFromURLWithString:@"http://www.panin-am.co.id:800/jsonviewnews.aspx"
                                         completion:^(JSONModel *model, JSONModelError *err) {
                                             
                                             //hide the loader view
                                             [HUD hideUIBlockingIndicator];
                                             
                                             //json fetched
                                             //NSLog(@"news: %@", _feed.listNews);
                                             [self.myTable reloadData];
                                             
                                         }]; 
    
    
    _navfeed = [[NAVFeed alloc] initFromURLWithString:@"http://www.panin-am.co.id:800/json.aspx"
                                         completion:^(JSONModel *model, JSONModelError *err) {
                                             
                                             //hide the loader view
                                             [HUD hideUIBlockingIndicator];
                                             
                                             //json fetched
                                             NSLog(@"NAV: %@", _navfeed.products);
                                             [self.navTable reloadData];
                                             
                                         }];
    

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
     fader.hidden = YES;
    
    chaptermenu.hidden = YES;
    chaptermenu.alpha = 0;
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2);
    [vertical setTransform:rotate];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
          //
            
        }
        if(result.height == 568)
        {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(revealLeftSidebar:)];
        }
    
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"] 
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(revealRightSidebar:)];;
    
    self.navigationItem.revealSidebarDelegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openKalkulatorApp:(id)sender
{
   switch ([(UIButton*)sender tag]) {
        case 1:
           self.subv = [[KalkulatorKebutuhanInvestasi alloc] initWithNibName:@"KalkulatorKebutuhanInvestasi" bundle:nil] ;
           break;
        case 2:
           self.subv = [[KalkulatorInvestasiBerkala alloc] initWithNibName:@"KalkulatorInvestasiBerkala" bundle:nil] ;
           break;
       case 3:
           self. subv = [[KalkulatorHasilInvestasi alloc] initWithNibName:@"KalkulatorHasilInvestasi" bundle:nil];
       case 4:
           self. subv = [[KalkulatorHasilInvestasiBerkala alloc] initWithNibName:@"KalkulatorHasilInvestasiBerkala" bundle:nil];
           

   }
    //subv.view.center = self.view.center;
    CGRect r = [subv.view frame];
    r.origin.x = 180;
    r.origin.y = 150;
    [subv.view setFrame:r];
    fader.hidden = NO;
    [self.view addSubview:subv.view];


}


- (IBAction)openLogin:(id)sender{
    
    self.subv = [[Login alloc]initWithNibName:@"Login" bundle:nil];
//    CGRect r = [subv.view frame];
//    r.origin.x = 300;
//    r.origin.y = 200;
//    [subv.view setFrame:r];
    

    fader.hidden = NO;
    //self.view.frame = self.view.bounds;
    CGSize size = self.view.frame.size;
    [subv.view setCenter:CGPointMake(size.width/2, size.height/2)];
     //subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    

   
}


- (IBAction)openLoginMitra:(id)sender{
    
    self.subv = [[LoginMitra alloc]initWithNibName:@"LoginMitra" bundle:nil];
    //    CGRect r = [subv.view frame];
    //    r.origin.x = 300;
    //    r.origin.y = 200;
    //    [subv.view setFrame:r];
    
    
    fader.hidden = NO;
    //self.view.frame = self.view.bounds;
    CGSize size = self.view.frame.size;
    [subv.view setCenter:CGPointMake(size.width/2, size.height/2)];
    //subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
    
    
}


-(IBAction)showmenu:(id)sender
{
    if(chaptermenu.alpha == 0){
        chaptermenu.hidden = NO;
        [UIView animateWithDuration:0.7 animations:^{ chaptermenu.alpha = 1;} completion:nil ];
    }else if(chaptermenu.alpha == 1){
        [UIView animateWithDuration:0.7 animations:^{ chaptermenu.alpha = 0;} completion:^(BOOL finished){chaptermenu.hidden = YES;
            chaptermenu.alpha = 0;} ];
        
    }
}


-(void)closefader {
    
    //[self dismissViewControllerAnimated:NO completion:nil];
    fader.hidden = YES;
}

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (void)revealRightSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateRight];
}

#pragma mark JTRevealSidebarDelegate

// This is an examle to configure your sidebar view through a custom UIViewController
- (UIView *)viewForLeftSidebar {
    // Use applicationViewFrame to get the correctly calculated view's frame
    // for use as a reference to our sidebar's view
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableViewController *controller = self.leftSidebarViewController;
    if ( ! controller) {
        self.leftSidebarViewController = [[SidebarViewController alloc] init];
        self.leftSidebarViewController.sidebarDelegate = self;
        controller = self.leftSidebarViewController;
        controller.title = @"Menu";
    }
    controller.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

// This is an examle to configure your sidebar view without a UIViewController
- (UIView *)viewForRightSidebar {
    // Use applicationViewFrame to get the correctly calculated view's frame
    // for use as a reference to our sidebar's view
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableView *view = self.rightSidebarView;
    if ( ! view) {
        view = self.rightSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
        view.dataSource = self;
        view.delegate   = self;
    }
    view.frame = CGRectMake(self.navigationController.view.frame.size.width - 270, viewFrame.origin.y, 270, viewFrame.size.height);
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    return view;
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    // Example to disable userInteraction on content view while sidebar is revealing
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}


#pragma mark - table methods

//table news

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((tableView.tag == 1) || (tableView.tag == 11))
    {
   // return _feed.listNews.count;
        NSLog(@"baris:%d",_feed.listNews.count);
        return 8;
    }
    
    else return  _navfeed.products.count;
     NSLog(@"baris 2: %d",_feed.listNews.count);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *lastCellIdentifier = @"LastCell";
    UITableViewCell *lastCell = [tableView dequeueReusableCellWithIdentifier:lastCellIdentifier];
   
    if (tableView.tag ==11) {
        
        static NSString *CellIdentifier = @"Cell";
        

        
        
        NewsJSON *news = _feed.listNews[indexPath.row];
        
        NewsCell *cell = (NewsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //forIndexPath:indexPath];
        
        if (cell==nil) {
            
            
            NSArray *topLevelObjects;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell_iPhone" owner:nil options:nil];
            }else{
                topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
            }
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (NewsCell *) currentObject;
                    break;
                }
            }
        }
        
        
        
        UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 12 ];
        cell.textLabel.font  = myFont;
        //cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",
        //news.title, news.shortDesc
        //];
        cell.title.text = news.title;
        cell.shortDesc.text = news.shortDesc;
        cell.modifDate.text = [news.modifiedDate substringToIndex:6];
        cell.modifMonth.text = [news.modifiedDate substringFromIndex:6];
        //cell.modifYear.text = [news.modifiedDate substringWithRange:NSMakeRange(6, 4)];
        NSLog(@"%@",cell.modifYear.text);
        //fvalue = [self.dayLabel.text substringToIndex:2];
        
        
        return cell;
        
    }
    if (tableView.tag ==1) {
        
    static NSString *CellIdentifier = @"Cell";
    NewsJSON *news = _feed.listNews[indexPath.row];
    
    NewsCell *cell = (NewsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //forIndexPath:indexPath];
        
    if (cell==nil) {
        
        NSArray *topLevelObjects;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
        }else{
            topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
        }
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (NewsCell *) currentObject;
                break;
            }
        }
    }

        
    
    UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 16.0 ];
    cell.textLabel.font  = myFont;
    //cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",
                           //news.title, news.shortDesc
                           //];
        cell.title.text = news.title;
        cell.shortDesc.text = news.shortDesc;
        cell.modifDate.text = [news.modifiedDate substringToIndex:6];
        cell.modifMonth.text = [news.modifiedDate substringFromIndex:6];
        //cell.modifYear.text = [news.modifiedDate substringWithRange:NSMakeRange(6, 4)];
        NSLog(@"%@",cell.modifYear.text);
        //fvalue = [self.dayLabel.text substringToIndex:2];

        
    return cell;
        
    }
    
    else if (tableView.tag==2){
        static NSString *CellIdentifier = @"NAVCell";
        NAVJSON *nav = _navfeed.products[indexPath.row];
        
        NAVCell *cell = (NAVCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //forIndexPath:indexPath];
        
        if (cell==nil) {
            
            NSArray *topLevelObjects;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                //topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
            }else{
                topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NAVCell" owner:nil options:nil];
            }
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    cell = (NAVCell *) currentObject;
                    break;
                }
            }
        }
        
        UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 16.0 ];
        cell.textLabel.font  = myFont;
        //cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",
                              // nav.ProductName, nav.NABValue
                               //];
    
        cell.productName.text = nav.ProductName;
        
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pam-ipad-home-sidebardown-263x261.png"]];
        [tempImageView setFrame:tableView.frame];
        
        tableView.backgroundView = tempImageView;
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setGroupingSeparator:@","];
        [numberFormatter setGroupingSize:3];
        [numberFormatter setUsesGroupingSeparator:YES];
        [numberFormatter setDecimalSeparator:@"."];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:2];
        NSNumber *number = [numberFormatter numberFromString:nav.NABValue];
        NSString *theString = [numberFormatter stringFromNumber:number];
        NSString *newStringValue = [theString
                                    stringByReplacingOccurrencesOfString:@"," withString:@"x"];
        newStringValue = [newStringValue
                          stringByReplacingOccurrencesOfString:@"." withString:@","];
        newStringValue = [newStringValue
                          stringByReplacingOccurrencesOfString:@"x" withString:@"."];
        cell.NABValue.text = newStringValue;//nav.NABValue;
        
        NSString *newValue = [NSString stringWithFormat:@"%0.2f%%", [nav.OneD floatValue]];
        cell.oneD.text = newValue;//nav.OneD;
        
        if([cell.oneD.text hasPrefix:@"-"]) {
            cell.backIndex.image = [UIImage imageNamed:@"pam-ipad-down-13x11.png"];
        } else {
            cell.backIndex.image = [UIImage imageNamed:@"pam-ipad-up-13x11.png"];
        }

        
        NSString *temprate = nav.Star;
        UIImage *star3 = [UIImage imageNamed: @"pam-star3-68x11"];
        UIImage *star5 = [UIImage imageNamed: @"pam-star5-68x11"];
        if ([temprate isEqualToString:@"3"]) cell.rating.image = star3;
        if ([temprate isEqualToString:@"5"]) cell.rating.image = star5;
        
        return cell;

        
       }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tablelView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if ((tablelView.tag == 1) || (tablelView.tag == 11))
   {
       return self.myTable.frame.size.height / 6;
   }
    else return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ((tableView.tag == 1) || (tableView.tag == 11)) {
        //
        NewsJSON *news = _feed.listNews[indexPath.row];
    
        
        NSString *str = [news.newsLink stringByReplacingOccurrencesOfString:@"&#47"
                                             withString:@"/"];
        NSLog(@"str:%@",str);
      
        
        NSString *newAddress = [[NSString alloc]initWithFormat:@"http://www.readability.com/m?url=%@",str];
        
        SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:newAddress];
        [self presentModalViewController:browser animated:YES];
          NSLog(@"link: %@",newAddress);
    }
}




- (IBAction)gotoNasabahView:(id)sender{
     

    NasabahView *nasabah = [[NasabahView alloc]initWithNibName:@"NasabahView" bundle:nil];
    self.subv = nasabah;
    //    CGRect r = [subv.view frame];
    //    r.origin.x = 0;
    //    r.origin.y = 0;
    //    [subv.view setFrame:r];
 
    nasabah.username = usernametosend.text;
    nasabah.password = passwordtosend.text;
   
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
    
}


- (void)requestFinished:(ASIFormDataRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    
    NSData *responseData = [request responseData];
    
   // NSLog(@"headers: %@", [request responseHeaders]);
   // NSLog(@"headers1: %@", [[request requestHeaders]description]);
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}



#pragma mark SidebarViewControllerDelegate

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController setRevealedState:JTRevealedStateNo];
    
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    self.title = (NSString *)object;
    self.leftSidebarViewController  = sidebarViewController;
    self.leftSelectedIndexPath      = indexPath;
    //self.label.text = [NSString stringWithFormat:@"Selected %@ from LeftSidebarViewController", (NSString *)object];
    sidebarViewController.sidebarDelegate = self;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:self] animated:NO];
    
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController {
    return self.leftSelectedIndexPath;
}





-(IBAction)openCOF:(id)sender{
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
            
        {
            /*
            switch ([(UIButton*)sender tag]) {
                case 1:
                    self.subv = [[COFKendaraan alloc] initWithNibName:@"Chapter_4_1_1_iphone4" bundle:nil] ;
                    break;
                case 2:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_2_iphone4" bundle:nil] ;
                    break;
                case 3:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_3_iphone4" bundle:nil];
                    break;
                case 4:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_4_iphone4" bundle:nil];
                    break;
                case 5:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_5_iphone4" bundle:nil];
                    break;
                case 6:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_6_iphone4" bundle:nil];
                    break;
                case 7:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_7_iphone4" bundle:nil];
                    break;
                default:
                    self.subv = nil;
                    break;
            }
            */
            
        }
        if(result.height == 568)
        {
            /*
            switch ([(UIButton*)sender tag]) {
                case 1:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_1_iphone5" bundle:nil] ;
                    break;
                case 2:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_2_iphone5" bundle:nil] ;
                    break;
                case 3:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_3_iphone5" bundle:nil];
                    break;
                case 4:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_4_iphone5" bundle:nil];
                    break;
                case 5:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_5_iphone5" bundle:nil];
                    break;
                case 6:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_6_iphone5" bundle:nil];
                    break;
                case 7:
                    self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_7_iphone5" bundle:nil];
                    break;
                default:
                    self.subv = nil;
                    break;
            }
            */
        }
    }
    
    else {
        self.subv = [[COFCoverMenu alloc]initWithNibName:@"COFCoverMenu" bundle:nil];
    }
    
//        switch ([(UIButton*)sender tag]){
//            case 1:
//                self.subv = [[COFContainer alloc] initWithNibName:@"COFContainer" bundle:nil] ;
//                break;
//            case 2:
//                self.subv = [[COFPostDegree alloc] initWithNibName:@"COFPostDegree" bundle:nil] ;
//                break;
//            case 3:
//                self.subv = [[COFMarriage alloc] initWithNibName:@"COFMarriage" bundle:nil] ;
//                break;
//            case 4:
//                self.subv = [[COFHoliday alloc] initWithNibName:@"COFHoliday" bundle:nil] ;
//                break;
//            case 5:
//                self.subv = [[COFEntrepreneur alloc] initWithNibName:@"COFEntrepreneur" bundle:nil] ;
//                break;
//            /*case 6:
//                self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_6_ipad" bundle:nil] ;
//                break;
//            case 7:
//                self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_7_ipad" bundle:nil] ;
//                break;
//                */
//            case 10:
//                self.subv = [[SimulasiBerkala alloc] initWithNibName:@"SimulasiBerkala" bundle:nil] ;
//                break;
//            default:
//                self.subv = nil;
//                break;
//        }
//    }
    //fader.hidden = NO;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"photoshow" object:self];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"hidepager" object:self]; remove by request
    //[self presentPopupViewController:subv animationType:MJPopupViewAnimationFade];
//    subv.view.center = self.view.center;
//    [self.view addSubview:subv.view];
    
//    CGFloat parentWidth = self.view.bounds.size.width;
//    CGRect frame = CGRectMake(floor((parentWidth - 1024)/2),
//                              0,
//                              1024,
//                              768);
//    subv.view.frame = frame;

    [self.view addSubview:subv.view];

    
}



@end
