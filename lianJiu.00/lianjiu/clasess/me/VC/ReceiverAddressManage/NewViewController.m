//
//  NewViewController.m
//  TestMap
//
//  Created by 123 on 17/12/11.
//  Copyright © 2017年 123. All rights reserved.
//

#import "NewViewController.h"
#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3

@interface NewViewController ()<MAMapViewDelegate, AMapSearchDelegate, UIGestureRecognizerDelegate, AMapLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    CGPoint _point;
    __block BOOL _isLocaltion;
}
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapPOIAroundSearchRequest *request;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSString *mapCoordinate;


@end

@implementation NewViewController
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///进入地图就显示定位小蓝点
    // 开启定位
    //_mapView.showsUserLocation = YES;
    // 追踪用户位置
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.showsCompass= NO;
    //全局的大头针
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    
    [self mobilePhonePositioning];
    
    
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.mapView removeAnnotations:self.mapView.annotations];
    //坐标转换
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:_point toCoordinateFromView:_mapView];
    
    _pointAnnotation.coordinate = touchMapCoordinate;
    //_pointAnnotation.title = @"设置名字";
    
    [_mapView addAnnotation:_pointAnnotation];
    
    [self setLocationWithLatitude:touchMapCoordinate.latitude AndLongitude:touchMapCoordinate.longitude];
    
}
#pragma mark - 允许多手势响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//自定义大头针我这里只是把大头针变成一张自定义的图片
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"poi_2.png"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, 0);
        return annotationView;
    }
    return nil;
}

- (void)setLocationWithLatitude:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude{
    
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
    _mapCoordinate = [NSString stringWithFormat:@"%@,%@",latitudeStr,longitudeStr];
    //NSLog(@"%@",_mapCoordinate);
    //反编码 经纬度---->位置信息
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"反编码失败:%@",error);
            //            [self.view makeToast:@"该网点经纬度信息有误，请重新标注！"];
        }else{
            //NSLog(@"反编码成功:%@",placemarks);
            CLPlacemark *placemark=[placemarks lastObject];
            //NSLog(@"%@",placemark.addressDictionary[@"FormattedAddressLines"]);
            NSDictionary *addressDic=placemark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            //NSLog(@"%@,%@,%@,%@",state,city,subLocality,street);
            NSString *strLocation;
            if (street.length == 0 || street == NULL || [street isEqualToString:@"(null)"]) {
                strLocation= [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];
            }else{
                strLocation= [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            }
            
            //            self.addressTextView.text = strLocation;
        }
    }];
}
*/
/*
 * 手机定位你当前的位置，并获得你位置的信息
 */
/*
- (void)mobilePhonePositioning{
    
    [AMapServices sharedServices].apiKey =@"cb07d3ae7eb951c00c19648323c2d7b5";
    
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //   定位超时时间，最低2s，此处设置为10s
    _locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    _locationManager.reGeocodeTimeout = 10;
    
    // 显示进度圈
    //    [self showHUDWithStatus:@"正在定位您的位置..."];
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        // 隐藏进度圈
        //        [self dismissHUDIgnoreShowCount];
        
        if (error)
        {
            //NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            //            [self.view makeToast:@"抱歉，未能定位到你的位置!"];
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //NSLog(@"location:%@", location);
        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        _mapCoordinate = [NSString stringWithFormat:@"%@,%@",latitude,longitude];
        _pointAnnotation.coordinate = location.coordinate;
        _point = [_mapView convertCoordinate:location.coordinate toPointToView:_mapView];
        if (regeocode)
        {
            //NSLog(@"reGeocode:%@", regeocode);
            //            self.addressTextView.text = regeocode.formattedAddress;
        }
    }];
}
*/

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)setupTableViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height  / 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}


#pragma mark - Action Handle

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}

- (void)locAction
{
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak NewViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //根据定位信息，添加annotation
        weakSelf.pointAnnotation = [[MAPointAnnotation alloc] init];
        [weakSelf.pointAnnotation setCoordinate:location.coordinate];
        weakSelf.pointAnnotation.coordinate = location.coordinate;
        _point = self.mapView.center;
        
        [weakSelf addAnnotationToMapView:weakSelf.pointAnnotation];
    };
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
    _isLocaltion = YES;
}

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2)];
        [self.mapView setDelegate:self];
        
        [self.view addSubview:self.mapView];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initMapView];
    
    [self initCompleteBlock];
    
    [self configLocationManager];
    
    [self locAction];
    
    [self initSearchs];
    
    [self setupTableViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)dealloc
{
    
    self.completionBlock = nil;
}

- (AMapPOIAroundSearchRequest *)request {
    if (_request == nil) {
        // 构造AMapPOIAroundSearchRequest对象 设置周边请求参数
        _request = [[AMapPOIAroundSearchRequest alloc] init];
        //这个去掉的时候能正常使用(默认搜索类型)，应该是搜索不到附近有这些东西
        //_request.types = @"风景名胜｜商务住宅｜政府机构及社会团体｜交通设施服务｜公司企业｜道路附属设施｜地名地址信息";
        
        _request.sortrule = 0;
        _request.requireExtension = YES;
    }
    _request.location = [AMapGeoPoint locationWithLatitude:_pointAnnotation.coordinate.latitude longitude:_pointAnnotation.coordinate.longitude];
    return _request;
}

- (AMapSearchAPI *)search {
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}
- (void)initSearchs{
    if (_currentLocation == nil || _search == nil) {
        return;
    }
    [self.search AMapPOIAroundSearch:self.request];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0) {
        return;
    }
    _dataArr = [NSMutableArray arrayWithArray:response.pois];
    [_tableView reloadData];
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"poi_2.png"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, 0);
        return annotationView;
    }
    
    return nil;
}
- (void)mapViewRegionChanged:(MAMapView *)mapView {
    if(_isLocaltion) {
        [self.mapView removeAnnotation:_pointAnnotation];
        //坐标转换
        CLLocationCoordinate2D touchMapCoordinate =
        [_mapView convertPoint:_point toCoordinateFromView:_mapView];
        
        self.pointAnnotation.coordinate = touchMapCoordinate;
        
        [_mapView addAnnotation:_pointAnnotation];
    }
    
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self setLocationWithLatitude:self.pointAnnotation.coordinate.latitude AndLongitude:self.pointAnnotation.coordinate.longitude];
    [self.search AMapPOIAroundSearch:self.request];
}
- (void)setLocationWithLatitude:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude{
    
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",latitude];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",longitude];
    _mapCoordinate = [NSString stringWithFormat:@"%@,%@",latitudeStr,longitudeStr];
    //NSLog(@"%@",_mapCoordinate);
    //反编码 经纬度---->位置信息
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"反编码失败:%@",error);
            //            [self.view makeToast:@"该网点经纬度信息有误，请重新标注！"];
        }else{
            //NSLog(@"反编码成功:%@",placemarks);
            CLPlacemark *placemark=[placemarks lastObject];
            //NSLog(@"%@",placemark.addressDictionary[@"FormattedAddressLines"]);
            NSDictionary *addressDic=placemark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSLog(@"%@,%@,%@,%@",state,city,subLocality,street);
            NSString *strLocation;
            if (street.length == 0 || street == NULL || [street isEqualToString:@"(null)"]) {
                strLocation= [NSString stringWithFormat:@"strLocation:%@%@%@",state,city,subLocality];
            }else{
                strLocation= [NSString stringWithFormat:@"strLocation:%@%@%@%@",state,city,subLocality,street];
            }
            
//            self.dataArr = [placemarks copy];
            
            //            self.addressTextView.text = strLocation;
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    AMapPOI *response = _dataArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"poi_2"];
    cell.textLabel.text = response.name;
    cell.detailTextLabel.text = response.address;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *response = _dataArr[indexPath.row];
    
    if (self.sendAMapAPIBlock) {
        self.sendAMapAPIBlock(response);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
