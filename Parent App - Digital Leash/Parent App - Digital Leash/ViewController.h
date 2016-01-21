//
//  ViewController.h
//  Parent App - Digital Leash
//
//  Created by Matthew Paravati on 11/23/15.
//  Copyright © 2015 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController  <NSURLConnectionDelegate, NSURLConnectionDataDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
@property (weak, nonatomic) IBOutlet UITextField *reenterUserIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *setZoneButton;
@property (weak, nonatomic) IBOutlet UIButton *zoneStatusButton;
@property (weak, nonatomic) IBOutlet UILabel *zoneStatusLabel;


@property CLLocationManager* locationManager;
@property CLLocation *currentLocation;
@property NSURLConnection *theConnection;
@property NSString *userID;
@property NSString *radius;
@property NSString *latitude;
@property NSString *longitude;
@property NSDictionary *userDetailsDictionary;
@property NSData *jsonData;
@property NSMutableData *responseData;

//Button events
- (IBAction)setZoneButtonClicked:(id)sender;
- (IBAction)zoneStatusButtonClicked:(id)sender;
@end

