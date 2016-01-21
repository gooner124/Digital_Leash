//
//  ViewController.h
//  Child App - Digital Leash
//
//  Created by Matthew Paravati on 11/23/15.
//  Copyright © 2015 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property CLLocationManager* locationManager;
@property CLLocation *currentLocation;
@property NSURLConnection *theConnection;
@property NSString *userID;
@property NSString *latitude;
@property NSString *longitude;
@property NSDictionary *userDetailsDictionary;
@property NSMutableData *responseData;

- (IBAction)enterButtonClicked:(id)sender;

@end

