//
//  CalendarMonthViewController.m
//  Basin
//
//  Created by Lucien Constable on 3/20/13.
//
//

#import "CalendarMonthViewController.h"
#import "NSDate+TKCategory.h"
#import "EventViewController.h"

@implementation CalendarMonthViewController

@synthesize markTable;

@synthesize calendar;
@synthesize selectedEventString;
@synthesize selectedDate;
@synthesize dateArray;
@synthesize markArray;
@synthesize markDictionary;

- (void)viewWillAppear:(BOOL)animated
{
    
    // add calendar
    calendar = 	[[TKCalendarMonthView alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;

    // Ensure this is the last "addSubview" because the calendar must be the top most view layer
	[self.view addSubview:calendar];
        
    [self.calendar selectDate:[NSDate date]];
    
    markTable.frame = CGRectMake(markTable.frame.origin.x, CGRectGetMaxY(calendar.frame), markTable.frame.size.width, markTable.frame.size.height);
    
    [self.markTable reloadData];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // just hard coding days into this array -
    // for actual app, load from web and use hours/minutes to populate a DayView Calendar
    self.dateArray = [[NSMutableArray alloc] init];
    dateArray = [NSArray arrayWithObjects:
                 @"2013-03-01", @"2013-03-09",
                 @"2013-03-22", @"2013-03-22",
                 @"2013-04-11", @"2013-01-12",
                 @"2013-04-15", @"2013-04-28",
                 @"2013-05-04", @"2013-05-16",
                 @"2013-05-18", @"2013-05-19",
                 @"2013-05-23", @"2013-05-24",
                 @"2013-05-25", @"2013-06-01",
                 @"2013-06-12", @"2013-06-21",
                 @"2013-07-01", @"2013-07-11",
                 @"2013-07-14", @"2013-08-01",
                 @"2013-09-01", @"2013-10-01",
                 @"2013-11-01", @"2013-12-01",
                 nil];
    
    selectedEventString = [[NSString alloc] init];
    selectedDate = [[NSDate alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

- (void)viewDidUnload {
    [self setMarkTable:nil];
    [super viewDidUnload];
}

#pragma mark Button Methods
- (IBAction)plusPressed:(id)sender
{
}

- (IBAction)actionPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Sync with Google", @"Sync with iCal", @"Sync with Outlook", @"Email .ics file",
                                  nil];

    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}



#pragma mark TKCalendarMonthViewDelegate

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
    self.selectedDate = d;
    [self.markTable reloadData];
}

- (void) calendarMonthView:(TKCalendarMonthView*)monthView monthDidChange:(NSDate*)month animated:(BOOL)animated
{
    [self.calendar selectDate:month];
    markTable.frame = CGRectMake(markTable.frame.origin.x, CGRectGetMaxY(calendar.frame), markTable.frame.size.width, markTable.frame.size.height);

    [self.markTable reloadData];
}

#pragma mark TKCalendarMonthViewDataSource

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {

	// markArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// markDictionary: has items that are associated with date keys (for tableview)
    
    self.markArray = [[NSMutableArray alloc] init];
    self.markDictionary = [[NSMutableDictionary alloc] init];
    
    
		
	NSDate *d = startDate;
	while(YES){
		
        NSString *dayString = [[d description] substringToIndex:10];
		if ([dateArray containsObject:dayString]) {
            [self.markArray addObject:@YES];
            [self.markDictionary setObject:@[@"Special Sale", @"Special Event"] forKey:d];
        } else {
            [self.markArray addObject:@NO];
        }
		
		NSDateComponents *info = [d dateComponentsWithTimeZone:self.calendar.timeZone];
		info.day++;
		d = [NSDate dateWithDateComponents:info];
		if([d compare:lastDate]==NSOrderedDescending) break;
	}
        
    return markArray;
    
// leaving this solution to daylight savings time
//	// When testing initially you will have to update the dates in this array so they are visible at the
//	// time frame you are testing the code.
//	NSArray *data = [NSArray arrayWithObjects:
//					 @"2011-03-01 00:00:00 +0000", @"2013-03-09 00:00:00 +0000", @"2013-03-22 00:00:00 +0000",
//					 @"2013-03-22 00:00:00 +0000", @"2013-04-11 00:00:00 +0000", @"2013-01-12 00:00:00 +0000",
//					 @"2013-04-15 00:00:00 +0000", @"2013-04-28 00:00:00 +0000", @"2013-05-04 00:00:00 +0000",
//					 @"2013-05-16 00:00:00 +0000", @"2013-05-18 00:00:00 +0000", @"2013-05-19 00:00:00 +0000",
//					 @"2013-05-23 00:00:00 +0000", @"2013-05-24 00:00:00 +0000", @"2013-05-25 00:00:00 +0000",
//					 @"2013-06-01 00:00:00 +0000", @"2013-06-12 00:00:00 +0000", @"2013-06-21 00:00:00 +0000",
//					 @"2013-07-01 00:00:00 +0000", @"2013-07-11 00:00:00 +0000", @"2013-07-14 00:00:00 +0000",
//					 @"2013-08-01 00:00:00 +0000", @"2013-09-01 00:00:00 +0000", @"2013-10-01 00:00:00 +0000",
//					 @"2013-11-01 00:00:00 +0000", @"2013-12-01 00:00:00 +0000", nil];
//	
//    
//	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
//	NSMutableArray *marks = [NSMutableArray array];
//	
//	// Initialise calendar to current type and set the timezone to never have daylight saving
//	NSCalendar *cal = [NSCalendar currentCalendar];
//	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//	
//	// Construct DateComponents based on startDate so the iterating date can be created.
//	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed
//	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first
//	// iterating date then times would go up and down based on daylight savings.
//	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
//                                              NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
//                                    fromDate:startDate];
//	NSDate *d = [cal dateFromComponents:comp];
//	
//	// Init offset components to increment days in the loop by one each time
//	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//	[offsetComponents setDay:1];
//	
//    
//	// for each date between start date and end date check if they exist in the data array
//	while (YES) {
//		// Is the date beyond the last date? If so, exit the loop.
//		// NSOrderedDescending = the left value is greater than the right
//		if ([d compare:lastDate] == NSOrderedDescending) {
//			break;
//		}
//		
//		// If the date is in the data array, add it to the marks array, else don't
//		if ([data containsObject:[d description]]) {
//			[marks addObject:[NSNumber numberWithBool:YES]];
//		} else {
//			[marks addObject:[NSNumber numberWithBool:NO]];
//		}
//		
//		// Increment day using offset components (ie, 1 day in this instance)
//		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
//        
//	}
//  
//	return [NSArray arrayWithArray:marks];
}

#pragma mark UITableView Delegate & DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *ar = self.markDictionary[[self.calendar dateSelected]];
	
    if(ar == nil)
        return 0;
    
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"markCell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	NSArray *ar = self.markDictionary[[self.calendar dateSelected]];
	cell.textLabel.text = ar[indexPath.row];
	
    return cell;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

#pragma mark Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // prepare information for web view (return policy)
    if ([segue.identifier isEqualToString:@"calendarToEvent"]) {

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M/dd/yyyy"];
        
        NSIndexPath *indexPath = [markTable indexPathForSelectedRow];
        UITableViewCell *cell = [markTable cellForRowAtIndexPath:indexPath];

        
        EventViewController *destViewController  = segue.destinationViewController;
        
        destViewController.eventString = cell.textLabel.text;        
        destViewController.dateString = [formatter stringFromDate:selectedDate];
    }
}


@end
