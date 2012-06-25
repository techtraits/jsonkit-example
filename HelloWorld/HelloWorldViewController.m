//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by Usman Ismail on 11-06-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelloWorldViewController.h"
#import "JSONKit.h"

@implementation HelloWorldViewController
@synthesize button;
@synthesize label;
@synthesize myView;


- (NSData*) getSimpleJSON {
    NSString* jsonString = @"{ \
        \"person\": \"Usman\" \
    }";
    return  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData*) getNestedJSON {
    NSString* jsonString = @"{                      \
        \"person\": {                               \
            \"name\": \"Usman\",                    \
            \"job\": \"Software Engineer\"   \
        }                                           \
    }";
   return  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData*) getJSONList {
    NSString* jsonString = @"                                       \
    {                                                               \
        \"directory\": [                                            \
                      {                                             \
                          \"person\": {                            \
                              \"name\": \"Usman\",                  \
                              \"job\": \"Software Engineer\"        \
                          }                                         \
                      },                                            \
                      {                                             \
                          \"person\": {                            \
                              \"name\": \"Someone else\",           \
                              \"job\": \"Some other profession\"    \
                          }                                         \
                      }                                             \
                ]                                                   \
    }                                                               \
    ";
   return  [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)loadView
{
	// create and configure the view
	CGRect cgRct = CGRectMake(0.0, 0.0, 480, 320); //define size and position of view
	myView = [[UIView alloc] initWithFrame:cgRct]; //initialize the view   
	myView.autoresizesSubviews = YES;              //allow it to tweak size of elements in view
	self.view = myView;       
    
	// create a UIButton (UIButtonTypeRoundedRect) and play arround with settings
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];   
	button.frame = CGRectMake(100, 100, 100, 50); // size and position of button
	[button setTitle:@"Add" forState:UIControlStateNormal];
	button.backgroundColor = [UIColor clearColor];
	button.adjustsImageWhenHighlighted = YES;    
    
	//Add action handler and set current class as target
	[button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
	//Display Button
	[self.view addSubview:button];
    
	//create a label
	cgRct = CGRectMake(100, 170, 100, 50); //define size and position of label
	label = [[UILabel alloc] initWithFrame:cgRct];
	label.text = @"Hello World";
    
	//Display Label
	[self.view addSubview:label];
}

-(void)action:(id)sender
{
    JSONDecoder* decoder = [[JSONDecoder alloc] init];
    NSDictionary *simpleDictionary = [decoder objectWithData:[self getSimpleJSON]];
    NSLog(@"Person: %@",[simpleDictionary objectForKey:@"person"]);
    
    NSDictionary *nestedDictionary  = [decoder objectWithData:[self getNestedJSON]];
    NSDictionary *personDictionay =  [nestedDictionary objectForKey:@"person"];
    
    NSLog(@"Name: %@",[personDictionay objectForKey:@"name"]);
    NSLog(@"Job: %@",[personDictionay objectForKey:@"job"]);
    
    NSDictionary* listDictionary = [decoder objectWithData:[self getJSONList]];
    NSArray* people =[listDictionary objectForKey:@"directory"];


    for (NSDictionary *person in people) {    
        NSDictionary *personDetails = [person objectForKey:@"person"];
        NSLog(@"Name: %@",[personDetails objectForKey:@"name"]);
        NSLog(@"Job: %@",[personDetails objectForKey:@"job"]);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
