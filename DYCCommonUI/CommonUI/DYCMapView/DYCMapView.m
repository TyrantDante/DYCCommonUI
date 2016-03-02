//
//  DYCMapView.m
//  DYCDemo
//
//  Created by NaXing on 15/12/3.
//  Copyright © 2015年 NX_JEH. All rights reserved.
//

#import "DYCMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <CoreLocation/CLLocation.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapCommonObj.h>
@interface DYCMapView()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) AMapSearchAPI *searchAPI;
@property (nonatomic,strong) UIImageView *annotation;
@property (nonatomic,strong) AMapReGeocodeSearchResponse *response;

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation DYCMapView
- (instancetype)initWithFrame:(CGRect)frame ApiKey:(NSString *)apiKey{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initMapView:apiKey];
        [self initSearch:apiKey];
        [self initTableView];
        [self initAnnotation];
        [self initLocation];
        [self startLocation];
    }
    return self;
}

- (void)initMapView:(NSString *)apiKey{
    
    [MAMapServices sharedServices].apiKey = apiKey;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.6 - 0.5)];
    _mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
    _mapView.delegate = self;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.showsUserLocation = NO;
    [_mapView setZoomLevel:18 animated:YES];
    [self addSubview:_mapView];
}

- (void)initSearch:(NSString *)apiKey{
    
    [AMapSearchServices sharedServices].apiKey = apiKey;
    
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = self;
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.6, self.frame.size.width, self.frame.size.height * 0.4) style:UITableViewStylePlain];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.6, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (void)initAnnotation{
    _annotation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_icon.png"]];
    _annotation.frame = CGRectMake(0, 0, 19.5, 27);
//    _annotation.center = _mapView.center;
    _annotation.center = CGPointMake(_mapView.center.x, _mapView.center.y - 13.5);

    [self addSubview:_annotation];
}

- (void)initLocation{
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    [location setImage:[UIImage imageNamed:@"导航icon.png"] forState:UIControlStateNormal];
    location.frame = CGRectMake(_mapView.frame.size.width - 34.4, _mapView.frame.size.height - 42.8, 29.4, 37.8);
    [location addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:location];
}

- (void)startLocation{
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)stopLocation{
    
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.showsUserLocation = NO;
}

- (void)clearMapView{
    
    _mapView.showsUserLocation = NO;
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeOverlays:_mapView.overlays];
    _mapView.delegate = nil;
}

- (void)clearSearch{
    
    _searchAPI.delegate = nil;
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated;{
    [UIView animateWithDuration:.3f animations:^{
        _annotation.frame = CGRectMake(_annotation.frame.origin.x, _annotation.frame.origin.y - 5, _annotation.frame.size.width, _annotation.frame.size.height);
    }];
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    CLLocationCoordinate2D center = mapView.centerCoordinate;
    NSLog(@"center is %f , %f",center.latitude,center.longitude);
    mapView.userTrackingMode = MAUserTrackingModeNone;
    [UIView animateWithDuration:.3f animations:^{
        _annotation.frame = CGRectMake(_annotation.frame.origin.x, _annotation.frame.origin.y + 5, _annotation.frame.size.width, _annotation.frame.size.height);
    }];
    [self searchReGeocodeWithCoordinate:center];
}


- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate{
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    _mapView.showsUserLocation = NO;
    [_searchAPI AMapReGoecodeSearch:regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    NSLog(@"response is %@",response);
    _response = response;
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_response) {
        return _response.regeocode.pois.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    AMapPOI *geoCode = _response.regeocode.pois[indexPath.row];
    cell.textLabel.text = geoCode.name;
    if (geoCode.address.length) {
        cell.detailTextLabel.text = geoCode.address;
    }
    else
    {
        cell.detailTextLabel.text = @"    ";
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AMapPOI *geoCode = _response.regeocode.pois[indexPath.row];
    AMapGeoPoint *currentLocation = geoCode.location;
    
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = currentLocation.latitude;
    centerCoordinate.longitude = currentLocation.longitude;
    
    _mapView.centerCoordinate = centerCoordinate;
    
    [_mapViewDelegate mapView:self didSelectRow:indexPath.row aMapPoi:geoCode];
}
@end
