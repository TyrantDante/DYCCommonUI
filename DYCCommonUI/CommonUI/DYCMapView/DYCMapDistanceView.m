//
//  DYCMapDistanceView.m
//  DYCDemo
//
//  Created by NaXing on 15/12/4.
//  Copyright © 2015年 NX_JEH. All rights reserved.
//

#import "DYCMapDistanceView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <CoreLocation/CLLocation.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapCommonObj.h>
#import "math.h"
#import "DYCDistenseView.h"
#define DEFAULT_RADIUS 3
@interface DYCMapDistanceView()<MAMapViewDelegate,AMapSearchDelegate,UITextFieldDelegate>

@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) AMapSearchAPI *searchAPI;

@property (nonatomic,strong) UIImageView *annotation;

@property (nonatomic,strong) MACircle *circleOverLay;
@property (nonatomic,assign) CLLocationCoordinate2D centerCoordinate;

@property (nonatomic,weak) UIView *detailView;
@property (nonatomic,strong) DYCDistenseView *distanceView;
@property (nonatomic,assign) CGFloat distance;
@end
@implementation DYCMapDistanceView

- (instancetype)initWithFrame:(CGRect)frame ApiKey:(NSString *)apiKey
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initMapView:apiKey];
        [self initSearch:apiKey];
        [self initDetailView];
        [self initOverLay];
        [self initLocation];
        [self initAnnotation];
        [self startLocation];
    }
    return self;
}

- (void)initMapView:(NSString *)apiKey{
    
    [MAMapServices sharedServices].apiKey = apiKey;
    
    _mapView                    = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 200 -0.5)];
    _mapView.visibleMapRect     = MAMapRectMake(220880104, 101476980, 272496, 466656);
    _mapView.delegate           = self;
    _mapView.userTrackingMode   = MAUserTrackingModeNone;
    _mapView.showsUserLocation  = NO;
    _mapView.showsScale         = YES;
    [_mapView setZoomLevel:13 animated:YES];
    [self addSubview:_mapView];
}

- (void)initSearch:(NSString *)apiKey{
    
    [AMapSearchServices sharedServices].apiKey = apiKey;
    
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = self;
}
- (void)cityChanged:(AMapAddressComponent *)component{
    NSString *subStr = [NSString stringWithFormat:@"%@ %@",component.province,component.city];
    NSString *totalStr = [NSString stringWithFormat:@"你的位置:%@",subStr];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                           NSForegroundColorAttributeName: [UIColor blackColor],};
    NSDictionary *dict2 = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                            NSForegroundColorAttributeName: [UIColor lightGrayColor],};
    [attr setAttributes:dict range:[totalStr rangeOfString:@"你的位置:"]];
    [attr setAttributes:dict2 range:[totalStr rangeOfString:subStr]];
    UILabel *location = [self viewWithTag:90099];
    location.attributedText = attr;
}

- (void)initDetailView{
    UIView *detailView      = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 200, self.frame.size.width, 200)];
    _detailView.backgroundColor = [UIColor yellowColor];
    UIImageView *line       = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 200, self.frame.size.width, 0.5)];
    line.backgroundColor    = [UIColor lightGrayColor];
    [self addSubview:line];
    [self addSubview:detailView];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.frame.size.width - 120, 16)];
    locationLabel.tag = 90099;
    [detailView addSubview:locationLabel];
    
    UILabel *addressLabel       = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.frame.size.width -20, 15)];
    addressLabel.adjustsFontSizeToFitWidth = YES;
    addressLabel.textAlignment  = NSTextAlignmentLeft;
    addressLabel.textColor      = [UIColor blackColor];
    addressLabel.tag = 1001;
    UIImageView *labelLine      = [[UIImageView alloc] initWithFrame:CGRectMake(0, 14.5, self.frame.size.width - 20, 0.5)];
    labelLine.backgroundColor   = [UIColor lightGrayColor];
    [addressLabel addSubview:labelLine];
    [detailView addSubview:addressLabel];
    
//    UITextField *radiusText     = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.frame.size.width - 20, 15)];
//    UILabel *radiusLeftLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
//    radiusLeftLabel.font            = [UIFont systemFontOfSize:12];
//    radiusLeftLabel.text            = @"上课半径:";
//    radiusLeftLabel.textColor       = [UIColor lightGrayColor];
//    
//    radiusText.leftView             = radiusLeftLabel;
//    radiusText.leftViewMode         = UITextFieldViewModeAlways;
//    UILabel *radiusRightLabel       = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 90, 0, 80, 15)];
//    radiusRightLabel.text           = @"KM(千米)";
//    radiusRightLabel.textColor      = [UIColor lightGrayColor];
//    radiusRightLabel.font           = [UIFont systemFontOfSize:12];
//    radiusText.rightView            = radiusRightLabel;
//    radiusText.rightViewMode        = UITextFieldViewModeAlways;
//    radiusText.delegate             = self;
//    radiusText.text = [NSString stringWithFormat:@"%d.0",DEFAULT_RADIUS];
//    radiusText.returnKeyType = UIReturnKeyDone;
//    radiusText.tag = 1002;
//    [detailView addSubview:radiusText];
    
    UIButton *distButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [distButton addTarget:self action:@selector(distButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    distButton.tag = 80099;
    distButton.frame = CGRectMake(10, 100, self.frame.size.width - 20, 44);
    distButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [detailView addSubview:distButton];
    _detailView = detailView;

    [self setDistance:3.0];
}

- (void)distButtonClicked:(UIButton *)sender{
    if (!_distanceView) {
        _distanceView = [[DYCDistenseView alloc] init];
        _distanceView.minDist = 1;
        _distanceView.maxDist = 6;
        _distanceView.frame = CGRectMake(0, self.frame.size.height - 200, self.frame.size.width, 200);
        [self addSubview:_distanceView];
    }
    [_distanceView show];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_distanceView hide];
}
- (void)setBtnDistance:(CGFloat)distance{
    NSString *strKM = @"KM (千米)";
    NSString *strDist = [NSString stringWithFormat:@"%7.1f       ",distance];
    NSString *totalStr = [NSString stringWithFormat:@"上课半径 %@ %@",strDist,strKM];
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor blackColor],};
    NSDictionary *dict2 = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                            NSForegroundColorAttributeName: [UIColor lightGrayColor],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSDictionary *dict3 = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                            NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [attrStr setAttributes:dict range:[totalStr rangeOfString:totalStr]];
    [attrStr setAttributes:dict2 range:[totalStr rangeOfString:strDist]];
    [attrStr setAttributes:dict3 range:[totalStr rangeOfString:strKM]];
    UIButton *distButton = [_detailView viewWithTag:80099];
    [distButton setAttributedTitle:attrStr forState:UIControlStateNormal];
}

- (void)initOverLay{
    _circleOverLay = [MACircle circleWithCenterCoordinate:_centerCoordinate radius:DEFAULT_RADIUS * 1000];
    [_mapView addOverlay:_circleOverLay];
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

    CGFloat radius = _circleOverLay.radius;
    if(radius > 0){
        CGFloat logResult   = ceil(log2f(radius/1000)) + 0.3;
        [_mapView setZoomLevel:13 - logResult animated:YES];
    }
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

- (NSMutableAttributedString *)attributeStringBystring:(NSString *)str{
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange contentRange = {0, [attributeString length]};
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    return attributeString;
}

- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    [mapView removeOverlay:_circleOverLay];
    [UIView animateWithDuration:.3f animations:^{
        _annotation.frame = CGRectMake(_annotation.frame.origin.x, _annotation.frame.origin.y - 5, _annotation.frame.size.width, _annotation.frame.size.height);
    }];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D center = mapView.centerCoordinate;
    _circleOverLay = [MACircle circleWithCenterCoordinate:center radius:_circleOverLay.radius];
    [mapView addOverlay:_circleOverLay];
    [self searchReGeocodeWithCoordinate:center];
    [UIView animateWithDuration:.3f animations:^{
        _annotation.frame = CGRectMake(_annotation.frame.origin.x, _annotation.frame.origin.y + 5, _annotation.frame.size.width, _annotation.frame.size.height);
    }];
}

- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate{
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
//    _mapView.showsUserLocation = YES;
    [_searchAPI AMapReGoecodeSearch:regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    NSLog(@"response is %@",response);
    UILabel *addressLabel = (UILabel *)[_detailView viewWithTag:1001];
    
    if (response.regeocode.pois.count) {
        AMapPOI *poiInfo      = response.regeocode.pois[0];
        addressLabel.text     = poiInfo.name;
    }
    else
    {
        addressLabel.text     = response.regeocode.formattedAddress;
    }
    [self cityChanged:response.regeocode.addressComponent];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{

    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 0.5f;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        return circleRenderer;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.0];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0.0];
        pre.image = [UIImage imageNamed:@"userPosition"];
        pre.lineWidth = 3;
        
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
    }
}

- (void)mapZoomAutoScare{
    
    CGFloat inputDist       = _distance;
    if(inputDist > 0){
        CGFloat logResult   = ceil(log2f(inputDist)) + 0.3;
        [_mapView setZoomLevel:13 - logResult animated:YES];
    }
    
}

- (void)setDistance:(CGFloat)distance{
    _distance = distance;
    [self setBtnDistance:distance];
    [_mapView removeOverlay:_circleOverLay];
    _circleOverLay = [MACircle circleWithCenterCoordinate:_circleOverLay.coordinate radius: distance *DEFAULT_RADIUS * 1000.0];
    [_mapView addOverlay:_circleOverLay];
    [self mapZoomAutoScare];
}
@end
