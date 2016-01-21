//
//  ViewController.m
//  Child App - Digital Leash
//
//  Created by Matthew Paravati on 11/23/15.
//  Copyright © 2015 TurnToTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = [locations lastObject];
    
    self.latitude = [NSString stringWithFormat:@"%f", self.currentLocation.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", self.currentLocation.coordinate.longitude];
    self.userID = [self.userIDTextField text];
    
    self.userDetailsDictionary =@{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"current_lat":self.latitude,@"current_longitude":self.longitude}, @"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
    NSError *error;
    NSData *jsonDataChild = [NSJSONSerialization dataWithJSONObject:self.userDetailsDictionary options:0 error:&error];
    
    //Initialize url that is going to be fetched
    NSString *myURL = @"https://protected-wildwood-8664.herokuapp.com/users/";
    myURL = [myURL stringByAppendingString:self.userID];
    NSURL *url = [NSURL URLWithString:myURL];
    
    //Initialize a request from url
    NSMutableURLRequest *patchRequest = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //Set http method
    [patchRequest setHTTPMethod:@"PATCH"];
    
    //Set body request, set content type, set content length
    [patchRequest setHTTPBody:jsonDataChild];
    [patchRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [patchRequest setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[jsonDataChild length]] forHTTPHeaderField:@"Content-Length"];
    
    //Initialize a connection
    self.theConnection = [[NSURLConnection alloc] initWithRequest:patchRequest delegate:self];
}

#pragma mark NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data {
    // Append the new data to the property declared
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    
  
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason
    
    NSLog(@"Connection failed! Error: %@", error);
    
}



#pragma mark My Custom Methods

- (IBAction)enterButtonClicked:(id)sender {
    self.latitude = [NSString stringWithFormat:@"%f", self.currentLocation.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", self.currentLocation.coordinate.longitude];
    self.userID = [self.userIDTextField text];
    
    self.userDetailsDictionary =@{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"current_lat":self.latitude,@"current_longitude":self.longitude}, @"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
}


@end
