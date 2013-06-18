//
//  NasabahView.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "NasabahView.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CekSaldo.h"
#import "CekTransaction.h"
#import "FundFactSheet.h"
#import "SimulasiBerkala.h"
#import "UnduhForm.h"
#import "TopUp.h"
#import "AutoDebet.h"
#import "NAVCell.h"
#import "COFCoverMenu.h"

@interface NasabahView ()

@end

@implementation NasabahView
@synthesize username,password,cif,tanggalLahir,alamat,telepon,email,expiredKTP,kodeAgent,namaAgent,noKontakAgent,emailAgent,cabangAgent,alamat2,telepon2,subv,sessionID,customerName,vertical;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closefader)
                                                     name:@"closefader"
                                                   object:nil];
        
       // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    }
    return self;
}

-(void)closefader {
    
    //[self dismissViewControllerAnimated:NO completion:nil];
    fader.hidden = YES;
}


- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{   
    [super addObserver:observer forKeyPath:@"vcRadioButtonItemFromGroupSelected" options:options context:context];
    [observers setValue:observer forKey:keyPath];
}

- (void)removeObserver:(NSObject*)observer forKeyPath:(NSString*)keyPath
{
    [super removeObserver:observer forKeyPath:@"vcRadioButtonItemFromGroupSelected"];
    [observers removeObjectForKey:keyPath];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI/2);
    [vertical setTransform:rotate];

    fader.hidden = YES;
    NSString *user,*pass;
    user= [NSString stringWithFormat:@"%@", username];
    pass = [NSString stringWithFormat:@"%@", password];
    //NSLog(@"Trying to sign in with user:%@ pass:%@",user,pass);
    
    
    _navfeed = [[NAVFeed alloc] initFromURLWithString:@"http://www.panin-am.co.id:800/json.aspx"
                                           completion:^(JSONModel *model, JSONModelError *err) {
                                               
                                               //hide the loader view
                                               [HUD hideUIBlockingIndicator];
                                               
                                               //json fetched
                                               //NSLog(@"NAV: %@", _navfeed.products);
                                               [self.navTable reloadData];
                                               
                                           }];

    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonLoginUser.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:user forKey:@"userName"];
    [request setPostValue:pass forKey:@"password"];
    
    [request setPostValue:@"submit" forKey:@"ctl00$MainContent$btnLogin"];
    
    
    NSString *eventValidation = @"wEWBwKd0eiaDwKvyZbqDgKMrfvLAgKOsPfSCQKRnIq9DwKw7JaFDQLqr4SbBoxruwSkUAtkZniSVbZNvoucEF8SeQll/Drp+mTBf6yH";
    [request setPostValue:eventValidation forKey:@"__EVENTVALIDATION"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods

//table news

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
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
    
    if (tableView.tag ==1) {
//        
//        static NSString *CellIdentifier = @"Cell";
//        NewsJSON *news = _feed.listNews[indexPath.row];
//        
//        NewsCell *cell = (NewsCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        //forIndexPath:indexPath];
//        
//        if (cell==nil) {
//            
//            NSArray *topLevelObjects;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
//                //topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
//            }else{
//                topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
//            }
//            for (id currentObject in topLevelObjects) {
//                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
//                    cell = (NewsCell *) currentObject;
//                    break;
//                }
//            }
//        }
//        
//        
//        
//        UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 16.0 ];
//        cell.textLabel.font  = myFont;
//        //cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",
//        //news.title, news.shortDesc
//        //];
//        cell.title.text = news.title;
//        cell.shortDesc.text = news.shortDesc;
//        cell.modifDate.text = [news.modifiedDate substringToIndex:6];
//        cell.modifMonth.text = [news.modifiedDate substringFromIndex:6];
//        //cell.modifYear.text = [news.modifiedDate substringWithRange:NSMakeRange(6, 4)];
//        NSLog(@"%@",cell.modifYear.text);
//        //fvalue = [self.dayLabel.text substringToIndex:2];
//        
//        
//        return cell;
        
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
        //cell.NABValue.text = nav.NABValue;
        //cell.oneD.text = nav.OneD;
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

- (CGFloat)tableView:(UITableView *)tabelView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return self.navTable.frame.size.height / 6;
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag ==1) {
        //
        NewsJSON *news = _feed.listNews[indexPath.row];
        
        
        NSString *str = [news.newsLink stringByReplacingOccurrencesOfString:@"&#47"
                                                                 withString:@"/"];
        NSLog(@"str:%@",str);
        
        
        NSString *newAddress = [[NSString alloc]initWithFormat:@"http://www.readability.com/m?url=%@",str];
        
//        SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:newAddress];
//        [self presentModalViewController:browser animated:YES];
//        NSLog(@"link: %@",newAddress);
    }
}



- (IBAction)checkSaldo:(id)sender{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];

    fader.hidden = NO;
    CekSaldo *cekSaldo = [[CekSaldo alloc]initWithNibName:@"CekSaldo" bundle:nil];
    self.subv = cekSaldo;

    cekSaldo.sessionID = sessionID;
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
}

- (IBAction)checkTransaction:(id)sender{
  // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    fader.hidden = NO;
    
    CekTransaction *cekTransaction = [[CekTransaction alloc]initWithNibName:@"CekTransaction" bundle:nil];
    self.subv = cekTransaction;
    
    cekTransaction.sessionID = sessionID;
    //subv.view.center = self.view.center;
    CGRect r = [subv.view frame];

    r.origin.x = 45;
    r.origin.y = 45;
    [subv.view setFrame:r];


    [self.view addSubview:subv.view];
    
}

- (IBAction)fundFactSheet:(id)sender{
   //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
      fader.hidden = NO;
    
    FundFactSheet *fundfact = [[FundFactSheet alloc]initWithNibName:@"FundFactSheet" bundle:nil];
    self.subv = fundfact;
    
    fundfact.sessionID = sessionID;
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
}

- (IBAction)unduhForm:(id)sender{
  //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    
    fader.hidden = NO;
    
    UnduhForm *unduh = [[UnduhForm alloc]initWithNibName:@"UnduhForm" bundle:nil];
    self.subv = unduh;
    
    unduh.sessionID = sessionID;
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
}


- (IBAction)simulasiBerkala:(id)sender{
   //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    
    SimulasiBerkala *simulasiBerkala = [[SimulasiBerkala alloc]initWithNibName:@"SimulasiBerkala" bundle:nil];
    self.subv = simulasiBerkala;
    
    simulasiBerkala.sessionID = sessionID;
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
}

- (IBAction)topUP:(id)sender{
    
    
    TopUp *topUP = [[TopUp alloc]initWithNibName:@"TopUp" bundle:nil];
    self.subv = topUP;
    
    topUP.sessionID = sessionID;
    topUP.namaNasabah = customerName.text;
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
}

- (IBAction)autoDebet:(id)sender{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    fader.hidden = NO;
    
    AutoDebet *autoDebet = [[AutoDebet alloc]initWithNibName:@"AutoDebet" bundle:nil];
    self.subv = autoDebet;
    
    autoDebet.sessionID = sessionID;
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
    
}




- (void)requestFinished:(ASIFormDataRequest *)request
{
   
    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    NSData *responseData = [request responseData];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSString *jsonCIF = [[json valueForKeyPath:@"CustomerDetail.customerNo"]stringValue];
    NSLog(@"CIF:%@",jsonCIF);
    cif.text =  jsonCIF;
    
    NSString *tglLahir = [json valueForKeyPath:@"CustomerDetail.birthdate"];
    tanggalLahir.text = tglLahir;
    NSLog(@"tgl lahir:%@",tglLahir);
    
    NSString *name = [json valueForKeyPath:@"CustomerDetail.customerName"];
    customerName.text = name;

    
    NSString *jsonAlamat1 = [json valueForKeyPath:@"CustomerDetail.Address1"];
    alamat.text = jsonAlamat1;
    
    NSString *jsonAlamat2 = [json valueForKeyPath:@"CustomerDetail.Address2"];
    alamat2.text = jsonAlamat2;
    
    NSString *jsonTelp1 = [json valueForKeyPath:@"CustomerDetail.PhoneNo1"];
    telepon.text = jsonTelp1;
    NSString *jsonTelp2 = [json valueForKeyPath:@"CustomerDetail.PhoneNo2"];
    telepon2.text = jsonTelp2;
    
    
    NSString *jsonEmail = [json valueForKeyPath:@"CustomerDetail.email"];
    email.text = jsonEmail;
    NSString *jsonExpiredKTP = [json valueForKeyPath:@"CustomerDetail.IDExpireDate"];
    expiredKTP.text = jsonExpiredKTP;
    
    
    NSString *jsonKode = [json valueForKeyPath:@"CustomerDetail.MarketingNo"];
    kodeAgent.text = jsonKode;
    NSString *jsonNamaAgent = [json valueForKeyPath:@"CustomerDetail.MarketingName"];
    namaAgent.text = jsonNamaAgent;
    NSString *jsonKontakAgent = [json valueForKeyPath:@"CustomerDetail.MarketingPhone"];
    noKontakAgent.text = jsonKontakAgent;
    NSString *jsonEmailAgent = [json valueForKeyPath:@"CustomerDetail.MarketingEmail"];
    emailAgent.text = jsonEmailAgent;
    NSString *jsonCabang = [json valueForKeyPath:@"CustomerDetail.MarketingBranch"];
    cabangAgent.text = jsonCabang;
    
    NSString *jsonSessionID = [json valueForKeyPath:@"CustomerDetail.SessionID"];
    sessionID = [[NSString alloc]initWithFormat:@"%@",jsonSessionID];
    NSLog(@"%@",sessionID);

    
    //NSLog(@"headers: %@", [request responseHeaders]);
    //NSLog(@"headers1: %@", [[request requestHeaders]description]);
    
    
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


- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}

- (IBAction)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
    
}

-(void) dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
}

@end
