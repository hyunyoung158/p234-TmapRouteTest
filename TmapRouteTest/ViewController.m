//
//  ViewController.m
//  TmapRouteTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#import "TMapView.h"

#define APP_KEY @"693b0d6b-de1f-3499-8283-ace081027e4f"
#define TOOLBAR_HEIGHT 80
@interface ViewController ()

@property (strong, nonatomic) TMapView *mapView;
@property (strong, nonatomic) TMapMarkerItem *startMarker, *endMarker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *transportType;
@end

@implementation ViewController


- (IBAction)transportTypeChanged:(id)sender {
    [self showPath];
}

//시작 지점과 종료 지점 사이의 경로를 검색한다.
- (void)showPath {
    TMapPathData *path = [[TMapPathData alloc] init];
    TMapPolyLine *line = [path findPathDataWithType:(int)self.transportType.selectedSegmentIndex startPoint:[self.startMarker getTMapPoint] endPoint:[self.endMarker getTMapPoint]];
    
    if (nil != line) {
        [self.mapView showFullPath:@[line]];
        
        //경로 안내선에 마커가 가리는 것을 방지
        [self.mapView bringMarkerToFront:self.startMarker];
        [self.mapView bringMarkerToFront:self.endMarker];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showPath];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, TOOLBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HEIGHT);
    self.mapView = [[TMapView alloc] initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    
    [self.view addSubview:self.mapView];
    
    //시작 지점 마커
    self.startMarker = [[TMapMarkerItem alloc] init];
    [self.startMarker setIcon:[UIImage imageNamed:@"image1.png"]];
    TMapPoint *startPoint = [self.mapView convertPointToGpsX:50 andY:50];
    [self.startMarker setTMapPoint:startPoint];
    [self.mapView addCustomObject:self.startMarker ID:@"START"];
    
    //종료 지점 마커
    self.endMarker = [[TMapMarkerItem alloc] init];
    [self.endMarker setIcon:[UIImage imageNamed:@"image2.png"]];
    TMapPoint *endPoint = [self.mapView convertPointToGpsX:300 andY:300];
    [self.endMarker setTMapPoint:endPoint];
    [self.mapView addCustomObject:self.endMarker ID:@"END"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
