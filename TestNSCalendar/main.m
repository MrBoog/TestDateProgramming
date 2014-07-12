//
//  main.m
//  TestNSCalendar
//
//  Created by LH'sMacbook on 7/12/14.
//  Copyright (c) 2014 liuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

void testDate()
{
    NSDate *now = [NSDate date];
    NSTimeInterval secondsInWeek = 7 * 24 * 60 * 60;
    NSDate *lastWeek = [NSDate dateWithTimeInterval:-secondsInWeek
                                          sinceDate:now];
    NSDate *nextWeek = [NSDate dateWithTimeInterval:secondsInWeek
                                          sinceDate:now];
    NSLog(@"Last Week: %@", lastWeek);
    NSLog(@"Right Now: %@", now);
    NSLog(@"Next Week: %@", nextWeek);
    
    
    //Compare:
    NSComparisonResult result = [now compare:nextWeek];
    if (result == NSOrderedAscending) {
        NSLog(@"now < nextWeek");
    } else if (result == NSOrderedSame) {
        NSLog(@"now == nextWeek");
    } else if (result == NSOrderedDescending) {
        NSLog(@"now > nextWeek");
    }
    
    //返回两个日期中较早的，或者较晚的。
    NSDate *earlierDate = [now earlierDate:lastWeek];
    NSDate *laterDate = [now laterDate:lastWeek];
    if ([now isEqualToDate:now])
    {
        NSLog(@" equal ");
    }
    NSLog(@"%@ is earlier than %@", earlierDate, laterDate);
}

void testComponent()
{
    NSDateComponents *november4th2012 = [[NSDateComponents alloc] init];
    [november4th2012 setYear:2012];
    [november4th2012 setMonth:11];
    [november4th2012 setDay:4];
    NSLog(@"%@", november4th2012);
    
}

void testCalendar()
{
    /*
     NSGregorianCalendar	NSBuddhistCalendar
     NSChineseCalendar	NSHebrewCalendar
     NSIslamicCalendar	NSIslamicCivilCalendar
     NSJapaneseCalendar	NSRepublicOfChinaCalendar
     NSPersianCalendar	NSIndianCalendar
     NSISO8601Calendar
     */
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSCalendar *buddhist = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSBuddhistCalendar];
    
    //currentCalendar: reflects the user’s device settings.
    NSCalendar *preferred = [NSCalendar currentCalendar];
    
    
    NSLog(@"%@", gregorian.calendarIdentifier);
    NSLog(@"%@", buddhist.calendarIdentifier);
    NSLog(@"%@", preferred.calendarIdentifier);
}

void fromDatesToComponents();
void fromComponentsToDates();
void calendricalCalculations();
void testDateFormatter();
void testDifferentLocale();
void testDifferentTimeZone();

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        testDate();
        testComponent();
        testCalendar();
        
        
        fromDatesToComponents();
        fromComponentsToDates();
        
        
        calendricalCalculations();
        
        
        testDateFormatter();
        testDifferentLocale();
        testDifferentTimeZone();
    }
    return 0;
}

void fromDatesToComponents()
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:units fromDate:now];
    
    NSLog(@"Day: %ld", [components day]);
    NSLog(@"Month: %ld", [components month]);
    NSLog(@"Year: %ld", [components year]);
}

void fromComponentsToDates()
{
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:2012];
    [components setMonth:11];
    [components setDay:4];
    
    NSDate *november4th2012 = [calendar dateFromComponents:components];
    
    NSLog(@"%0.0f seconds between Jan 1st, 2001 and Nov 4th, 2012",
          [november4th2012 timeIntervalSinceReferenceDate]);
}

void calendricalCalculations()
{
    //e.g. add a month from now:
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Instead of representing a date, the below components represent a duration.
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    [components setDay:32];
    
    //options:0, 如果传入14个月，会自动变为一年两个月。
    NSDate *oneMonthFromNow = [calendar dateByAddingComponents:components
                                                        toDate:now
                                                       options:0];
    NSLog(@"%@", oneMonthFromNow);
    
    
    
    
    //e.g.:  计算两个日子之前相差多少周（天）
    NSDate *start = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    NSDate *end = [NSDate date];
    
    NSCalendar *calendar2 = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSWeekCalendarUnit;
//    NSCalendarUnit units = NSDayCalendarUnit;
    NSDateComponents *components2 = [calendar2 components:units
                                               fromDate:start
                                                 toDate:end
                                                options:0];
    NSLog(@"It has been %ld weeks since January 1st, 2001",
          [components2 week]);
//    NSLog(@"It has been %ld days since January 1st, 2001",
//          [components2 day]);
}

void testDateFormatter()
{
    //Localized Styles:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *now = [NSDate date];
    NSString *prettyDate = [formatter stringFromDate:now];
    NSLog(@"%@", prettyDate);
    
    
    
    //Custom:
    // Formatter configuration
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter2 setLocale:posix];
    [formatter2 setDateFormat:@"M.d.y"];
    // Date to string
    NSDate *now2 = [NSDate date];
    NSString *prettyDate2 = [formatter2 stringFromDate:now2];
    NSLog(@"%@", prettyDate2);
    // And String to date  with same formatter.
    NSString *dateString = @"11.4.2012";
    NSDate *november4th2012 = [formatter2 dateFromString:dateString];
    NSLog(@"%@", november4th2012);
}

void testDifferentLocale()
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // locale: ar_EG
    NSLocale *egyptianArabic = [[NSLocale alloc] initWithLocaleIdentifier:@"ar_EG"];
    [formatter setLocale:egyptianArabic];
    [formatter setDateFormat:@"M.d.y"];
    
    NSDate *now = [NSDate date];
    NSString *prettyDate = [formatter stringFromDate:now];
    NSLog(@"%@", prettyDate);
    
    // locale: en_US_POSIX
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"M.d.y"];
    
    NSString *prettyDate2 = [formatter stringFromDate:now];
    NSLog(@"%@", prettyDate2);
    
    //返回所有支持的 Identifier，很长一段:
//    NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    
    
    // 如果不想限制显示的样子 并可以接受各种不同的显示情况 就可以用用户的当前设置 and Note that this is the default used by NSCalendar and NSDateFormatter. so 不写就是默认的
//    NSLocale *preferredLocale = [NSLocale currentLocale];
    
}

void testDifferentTimeZone()
{
    NSTimeZone *centralStandardTime = [NSTimeZone timeZoneWithAbbreviation:@"CST"];
    NSTimeZone *cairoTime = [NSTimeZone timeZoneWithName:@"Africa/Cairo"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"M.d.y h:mm a"];
    NSString *dateString = @"11.4.2012 8:09 PM";
    
    [formatter setTimeZone:centralStandardTime];
    NSDate *eightPMInChicago = [formatter dateFromString:dateString];
    NSLog(@"%@", eightPMInChicago);      // 2012-11-05 02:09:00 +0000
    
    [formatter setTimeZone:cairoTime];
    NSDate *eightPMInCairo = [formatter dateFromString:dateString];
    NSLog(@"%@", eightPMInCairo);        // 2012-11-04 18:09:00 +0000
    
    //Complete lists of time zone names and abbreviations
//    NSLog(@"%@", [NSTimeZone knownTimeZoneNames]);
//    NSLog(@"%@", [NSTimeZone abbreviationDictionary]);
    
    //同 locale 一样，直接获取用户的时区。
//    NSTimeZone *preferredTimeZone = [NSTimeZone localTimeZone];
    
}