//
//  KalkulatorKebutuhanInvestasi.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/17/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "SimulasiBerkala.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NIDropDown.h"
#import "AppDelegate.h"

@interface SimulasiBerkala ()

@end

@implementation SimulasiBerkala
@synthesize tanggal,tanggalFrom,tanggalTo,strTanggalFrom,strTanggalTo,tanggalNAB,strTanggalNAB,teksTanggalInvestasiBerkala,sessionID,teksJumlahInvestasi,dropdown;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *minImage = [UIImage imageNamed:@"pam-ipad-investor-slider1-296.png"];
    UIImage *maxImage = [UIImage imageNamed:@"pam-ipad-investor-slider-296.png"];
    
    
    minImage=[minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    maxImage=[maxImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    
    // Setup the FX slider
//    [sliderTingkatInflasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [sliderTingkatInflasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
//    
//    [sliderReturnInvestasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [sliderReturnInvestasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderchange:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    switch ([(UISlider*)sender tag]) {
        case 1:
            labelTingkatInflasi.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
        case 2:
            labelReturnInvestasi.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
            
    }
    
    ((UISlider*)sender).value = [slidevalue intValue];
}

- (IBAction)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
    
}

- (IBAction)hitung:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    fvalue  = appDelegate.fvalueGlobalString;

    
    NSString *tanggalInvestasi;
    
   NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonSimulasiInvestasiBerkala.aspx"]];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    tanggalInvestasi = teksTanggalInvestasiBerkala.text;
    
   // [request setPostValue:sessionID forKey:@"sessionid"];
    NSLog(@"session id:%@",sessionID);
    [request setPostValue:fvalue forKey:@"fundCode"];
    [request setPostValue:tanggalInvestasi forKey:@"dateOfMonth"];
    [request setPostValue:strTanggalFrom forKey:@"startDate"];
    [request setPostValue:strTanggalTo forKey:@"endDate"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];

    
}

- (void)requestFinished:(ASIFormDataRequest *)request
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    fvaluestring = appDelegate.fvalueString;
    
    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    
    NSData *responseData = [request responseData];
    
    
    
    //NSLog(@"headers: %@", [request responseHeaders]);
    //NSLog(@"headers1: %@", [[request requestHeaders]description]);
    
    
   
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          
                          error:&error];
    
    NSArray *transaksi = [json objectForKey:@"ListDailyNAV"]; //2
    
    
    NSString *investasi = teksJumlahInvestasi.text;
    
    CGFloat strInvestasi = (CGFloat)[investasi floatValue];
 
    float akumulasiUnit = 0;
    
    float strAkumulasiInvestasi = strInvestasi*transaksi.count;
    
    NSLog(@"akum investasi:%f",strAkumulasiInvestasi);

    
     for (int i=0;i<transaksi.count;i++){
        
        
        NSDictionary *tempDict = [transaksi objectAtIndex:i];
        
        NSString *nab = [tempDict objectForKey:@"NABValue"];
        
        NSString *investasi = teksJumlahInvestasi.text;
        
        CGFloat strNAB = (CGFloat)[nab floatValue];
        CGFloat strInvestasi = (CGFloat)[investasi floatValue];
         strInvestasi ++;
         
             
         NSLog (@"akumulasi nab:%f",strNAB);

        float totalUnit = strInvestasi/strNAB;
         NSLog (@"total unit:%f",totalUnit);
         
         akumulasiUnit = totalUnit+akumulasiUnit;
         NSLog (@"akumulasi unit:%f",akumulasiUnit);
         
         float hasilInvestasi = strNAB*akumulasiUnit;
         NSLog(@"hasil investasi %f",hasilInvestasi);
         
         float keuntungan = hasilInvestasi-strAkumulasiInvestasi;
         
         NSNumberFormatter *decnumberFormatter = [[NSNumberFormatter alloc] init];
         [decnumberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
         [decnumberFormatter setMaximumFractionDigits:0];
         [decnumberFormatter setMinimumFractionDigits:0];
         [decnumberFormatter setAlwaysShowsDecimalSeparator:NO];
         [decnumberFormatter setCurrencySymbol:@""];
         

         
         NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
         [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
         [numberFormatter setMaximumFractionDigits:0];
         
         NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:strAkumulasiInvestasi]];
         NSString *numberAsString2 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:hasilInvestasi]];
         NSString *numberAsString3 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:keuntungan]];
         
         _labelNominalInvestasi.text = [decnumberFormatter stringFromNumber:[NSNumber numberWithFloat:[investasi floatValue]]];
         NSString *teks = appDelegate.fvalueString;
         _labelTipeReksaDana.text = teks;
         NSLog(@"teks:%@",appDelegate.fvalueString);
         _labelPeriode.text = [NSString stringWithFormat:@"%@ - %@",strTanggalFrom,strTanggalTo];
         _labelTotalInvestasi.text = numberAsString;

         _labelNilaiPasarInvestasi.text = numberAsString2;
         _labelKeuntungan.text = numberAsString3;
         
     }
        
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //NSLog(@"error");
    NSError *error = [request error];
    NSLog(@"error:%@",error.description);
    
}


- (IBAction)pilihTipe:(id)sender
{
    listReksaDana = [[NSArray alloc] initWithObjects:@"Panin Dana Maksima", @"Panin Dana Prima", @"Panin Dana Syariah Saham", @"Panin Dana Bersama Plus", @"Panin Dana Bersama", @"Panin Dana Unggulan", @"Panin Dana Syariah Berimbang", @"Panin Dana USD", @"Panin Dana Prioritas", @"Panin Dana Utama Plus 2", @"Panin Gebyar Indonesia II", @"Panin Dana Likuid",nil];
    
    NSArray * arrImage = [[NSArray alloc] init];
    // arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :listReksaDana :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

    
//    tipeReksaDanaPicker = [[AFPickerView alloc] initWithFrame:CGRectMake(600, 170, 200, 197.0)];
//    tipeReksaDanaPicker.dataSource = self;
//    tipeReksaDanaPicker.delegate = self;
//    tipeReksaDanaPicker.rowFont = [UIFont boldSystemFontOfSize:16.0];
//    tipeReksaDanaPicker.rowIndent = 10.0;
//    [tipeReksaDanaPicker reloadData];
//    [self.view addSubview:tipeReksaDanaPicker];
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}


#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (pickerView == tipeReksaDanaPicker)
    {
        return [listReksaDana count];
    }
    //else return [periodeData count];
    return 0;
}



- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == tipeReksaDanaPicker)
        return [listReksaDana objectAtIndex:row];
   // else return [periodeData objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%i", row + 1];
    NSLog(@"%i:",row+1);
}




#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView == tipeReksaDanaPicker) {
        self.tipeLabel.text = [listReksaDana objectAtIndex:row];
        if ([self.tipeLabel.text isEqual: @"Panin Dana Maksima"]) fvalue = @"1";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Prima"]) fvalue = @"19";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Syariah Saham"]) fvalue = @"47";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Bersama Plus"]) fvalue = @"44";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Bersama"]) fvalue = @"";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Unggulan"]) fvalue = @"10";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Syariah Berimbang"]) fvalue = @"48";
        if ([self.tipeLabel.text isEqual: @"Panin Dana USD"]) fvalue = @"";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Prioritas"]) fvalue = @"49";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Utama Plus 2"]) fvalue = @"15";
        if ([self.tipeLabel.text isEqual: @"Panin Gebyar Indonesia II"]) fvalue = @"23";
        if ([self.tipeLabel.text isEqual: @"Panin Dana Likuid"]) fvalue = @"46";
    
        
        
        NSLog(@"fvalue:%@",fvalue);
        tipeReksaDana = self.tipeLabel.text;
    }
}

- (IBAction)pickDate:(id)sender{
    
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate =  self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    //[self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"2002-01-01"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"2013-01-05"],
                           [self.dateFormatter dateFromString:@"2013-01-06"],
                           [self.dateFormatter dateFromString:@"2013-01-06"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    switch ([(UIButton*)sender tag]) {
        case 1:  calendar.tag = 1;
            break;
        case 2: calendar.tag = 2;
            break;
        case 3: calendar.tag = 3;
            break;
    }
    
    calendar.frame = CGRectMake(450,230, 280, 300);
    [self.view addSubview:calendar];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
}



- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    
    // NSLog(@"sender :%d",sender.tag);
    //self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    tanggal = [self.dateFormatter stringFromDate:date];
    NSLog(@"Date:%@",tanggal);

   
    if(calendar.tag == 1) {
        
       tanggalFrom.text = tanggal;
        strTanggalFrom = tanggal;
        NSLog(@"strtanggal:%@",strTanggalFrom);
    }
    if(calendar.tag == 2) {
        
    tanggalTo.text = tanggal;
        strTanggalTo = tanggal;
    } else{
        tanggalNAB.text = tanggal;
    }
    
    
    [calendar removeFromSuperview];
}



- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return [date laterDate:self.minimumDate] == date;
}




@end
