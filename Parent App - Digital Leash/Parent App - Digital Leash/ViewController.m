//
//  ViewController.m
//  Parent App - Digital Leash
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setZoneButtonClicked:(id)sender {
    self.userID = self.userIDTextField.text;
    self.radius = self.radiusTextField.text;
    self.latitude = self.latitudeTextField.text;
    self.longitude = self.longitudeTextField.text;
    
    //initialize dictionary with input from the user
    self.userDetailsDictionary = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"latitude":self.latitude,@"longitude":self.longitude,@"radius":self.radius}, @"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
    NSError *error;
    //convert dictionary into json
    self.jsonData = [NSJSONSerialization dataWithJSONObject:self.userDetailsDictionary options:0 error:&error];
    
    //Initialize url that is going to be fetched
    NSURL *url = [NSURL URLWithString:@"https://protected-wildwood-8664.herokuapp.com/users"];
    
    //Initialize a request from url
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //Set http method
    [postRequest setHTTPMethod:@"POST"];
    
    //Set body request, set content type, set content length
    [postRequest setHTTPBody:self.jsonData];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [postRequest setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[self.jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    //Initialize a connection
    self.theConnection = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
}

- (IBAction)zoneStatusButtonClicked:(id)sender {
    self.userID = self.reenterUserIDTextField.text;
    
    //Initialize url that is going to be fetched
    NSString *myURL = @"https://protected-wildwood-8664.herokuapp.com/users/";
    myURL = [myURL stringByAppendingString:self.userID];
    myURL = [myURL stringByAppendingString:@".json"];
    NSURL *url = [NSURL URLWithString:myURL];
    
    //Initialize a request from url
    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //Set http method
    [getRequest setHTTPMethod:@"GET"];
    //set the url for the request
    [getRequest setURL:url];
    
    //Initialize a connection
    self.theConnection = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:url];
    NSError *error;
    
    //Convert json to nsdictionary
    self.userDetailsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"%@", self.userDetailsDictionary);
    
    if (self.userDetailsDictionary[@"is_in_zone"]  == [NSNull null]) {
        UIAlertController *theAlert = [UIAlertController alertControllerWithTitle:@"Zone status" message:@"Status unknown" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [theAlert addAction:defaultAction];
        [self presentViewController:theAlert animated:YES completion:nil];
    }else{
        BOOL isInZone = [self.userDetailsDictionary[@"is_in_zone"] intValue];
        
        if (isInZone) {
            UIAlertController *theAlert = [UIAlertController alertControllerWithTitle:@"Zone status" message:@"Child is in the zone" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [theAlert addAction:defaultAction];
            [self presentViewController:theAlert animated:YES completion:nil];
        }
        if (!isInZone) {
            UIAlertController *theAlert = [UIAlertController alertControllerWithTitle:@"Zone status" message:@"Child is NOT in the zone" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [theAlert addAction:defaultAction];
            [self presentViewController:theAlert animated:YES completion:nil];
        }
    }
}


#pragma mark NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data {
    // Append the new data to the property declared
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    
    NSLog(@"\n\n Loading Finished!");
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason
    
    NSLog(@"Connection failed! Error: %@", error);
}
@end
