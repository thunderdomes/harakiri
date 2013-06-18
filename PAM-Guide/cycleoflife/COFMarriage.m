//
//  COFKendaraan.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "COFMarriage.h"

@interface COFMarriage ()

@end

@implementation COFMarriage
@synthesize nowdate,tanggal,tanggaldipilih,endDate;

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
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd/MM/YYYY"];
//    
//    NSDate *currentDate = [NSDate date];
//    nowdate = [formatter stringFromDate:currentDate];
    
    UIImage *minImage = [UIImage imageNamed:@"pam-ipad-investor-slider1-296.png"];
    UIImage *maxImage = [UIImage imageNamed:@"pam-ipad-investor-slider-296.png"];
    
    
    minImage=[minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    maxImage=[maxImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    
    // Setup the FX slider
    [sliderTingkatInflasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [sliderTingkatInflasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    
    [sliderDP setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [sliderDP setMaximumTrackImage:maxImage forState:UIControlStateNormal];

    

    
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
            labeSliderlDP.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
            
    }
    
    ((UISlider*)sender).value = [slidevalue intValue];
}


-(IBAction)changeSeg{
	if(Segment.selectedSegmentIndex == 0){
        NSLog(@"1");
	}
	if(Segment.selectedSegmentIndex == 1){
        NSLog(@"2");
	}
    if(Segment.selectedSegmentIndex == 2) {
        NSLog(@"3");
    }
    if(Segment.selectedSegmentIndex == 3) {
        NSLog(@"4");
    }
    
}

- (IBAction)pickDate:(id)sender{
    
    //    UINavigationController *navigation = [[UINavigationController alloc] init];
    //	CalendarViewController *controller = [[CalendarViewController alloc] init];
    //	[navigation pushViewController:controller animated:NO];
    //	[controller setCalendarViewControllerDelegate:self];
    //
    //    [self.view addSubview:navigation.view];
    
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //[self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"12/09/2012"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"05/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(500,130, 280, 300);
    [self.view addSubview:calendar];
    
    //self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //[self.view addSubview:self.dateLabel];
    
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
    
    //self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    tanggal = [self.dateFormatter stringFromDate:date];
    NSLog(@"Date:%@",tanggal);
    tanggaldipilih.text = tanggal;
    
    
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //endDate = [dateFormatter dateFromString:tanggal];
    endDate = date;
    [self.calendar removeFromSuperview];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return [date laterDate:self.minimumDate] == date;
}

- (IBAction)back:(id)sender{
    [self.view removeFromSuperview];
}

- (IBAction)hitung:(id)sender{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    
    //NSDate *currentDate = [NSDate date];

    NSDate *startDate = [NSDate date];
    
    //endDate = ...;
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    float months = [comps month]+1;
    NSLog(@"Beda Bulan:%f",months);
    
    float slidetingkatinvestasiplussatu = 1 + [sliderTingkatInflasi value] /100;
    float dp = [sliderDP value] /100;
    
    float inflasi = pow(slidetingkatinvestasiplussatu,0.083333);
    float inflasiPerBulan = inflasi-1;
    NSLog (@"inflasi per bulan = %f",inflasiPerBulan);
    
    float satuPlusInflasiPerBulan = (1+inflasiPerBulan);
    float infestasipowmonths = pow(satuPlusInflasiPerBulan,months);
    NSString *hargaKendaraan = teksHargaKendaraan.text;
    CGFloat strHargaKendaraan = (CGFloat)[hargaKendaraan floatValue];
    float jumlahDanaDP = infestasipowmonths*strHargaKendaraan*dp;
    

    float tempreturnBulananSaham = pow(1.2,0.083333);
    float returnBulananSaham = tempreturnBulananSaham -1;
    float tempreturnCampuran = pow(1.15,0.083333);
    float returnBulananCampuran = tempreturnCampuran -1;
    float tempreturnPendapatanTetap = pow(1.1,0.083333);
    float returnPendapatanTetap = tempreturnPendapatanTetap -1;
    float tempreturnPasarUang = pow(1.05,0.083333);
    float returnPasarUang = tempreturnPasarUang -1;
    
    float returnBulananSahamPlusSatu = returnBulananSaham+1;
    float returnBulananCampuranPlusSatu = returnBulananCampuran+1;
    float returnPendapatanTetapPlusSatu = returnPendapatanTetap+1;
    float returnPasarUangPlusSatu = returnPasarUang+1;
    
    float investasiSekarangSaham = jumlahDanaDP/pow(returnBulananSahamPlusSatu,months);
    
    float investasiPerBulan = investasiSekarangSaham/12;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:jumlahDanaDP]];
    
    labelDanaDP.text = numberAsString;
    
    NSString *numberAsString2 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiSekarangSaham]];
    labelInvestasiSekarang.text = numberAsString2;
    
    NSString *numberAsString3 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiPerBulan]];
    labelInvestasiPerBulan.text = numberAsString3;
    


}

- (IBAction)back{
    [self.view removeFromSuperview];
    
}
@end
