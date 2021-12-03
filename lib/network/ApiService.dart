import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rent_app/adinfo.dart';
import 'package:rent_app/contactinfo.dart';
import 'package:rent_app/models/APIResponse.dart';
import 'package:rent_app/models/AdDetailsResponse.dart';
import 'package:rent_app/models/AmenitiesResponse.dart';
import 'package:rent_app/models/CategoriesListBean.dart';
import 'package:rent_app/models/CityListBean.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/models/MyAdsResponse.dart';
import 'package:rent_app/models/PostAdResponse.dart';
import 'package:rent_app/models/RegisterUserResponse.dart';
import 'package:rent_app/models/StateListBean.dart';
import 'package:rent_app/models/UserProfileResponse.dart';
import 'package:rent_app/models/UploadPicResponse.dart';
import 'package:rent_app/models/UpdateProfileResponse.dart';
import 'package:rent_app/propertyinfo.dart';
import 'package:rent_app/updateadinfo.dart';
import 'package:rent_app/updatecontactinfo.dart';
import 'package:rent_app/updatepropertyinfo.dart';
import 'package:rent_app/utils/preferences.dart';

class ApiService{
  static String mainBeUrl = "http://classified.ecodelinfotel.com/api/";

  //Register
  static Future<RegisterUserResponse> registerUser(data) async {
    String url = mainBeUrl + 'register';
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return RegisterUserResponse.fromJson(item);
    } else {
      throw 'Unable to register user';
    }
  }

  //Login
  static Future<RegisterUserResponse> loginUser(data) async {
    String url = mainBeUrl + 'login';
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return RegisterUserResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return RegisterUserResponse.fromJson(item);
      throw 'Unable to login user';
    }
  }

  //Social Login
  static Future<RegisterUserResponse> socialLoginUser(data, String provider) async {
    String url = mainBeUrl + 'auth/'+provider;
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return RegisterUserResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return RegisterUserResponse.fromJson(item);
     // throw 'Unable to login user';
    }
  }

  //forgot password
  static Future<APIResponse> forgotPass(data) async {
    String url = mainBeUrl + 'forgot-password';
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);
      throw 'Unable to login user';
    }
  }

  //verify OTP
  static Future<APIResponse> verifyOTP(data) async {
    String url = mainBeUrl + 'verify-otp';
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);
      throw 'Unable to login user';
    }
  }

  //reset password
  static Future<APIResponse> resetPassword(data) async {
    String url = mainBeUrl + 'reset-password';
    final response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);
    } else {
      throw 'Unable to register user';
    }
  }

  //Profile details
  static Future<UserProfileResponse> getProfileDetails() async {
    String? url = mainBeUrl + 'profile';
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    final response = await http.get(Uri.parse(url), headers: {
       "Accept": "application/json",
      // 'Content-Type': 'application/json',
      "Authorization": bearer + token
    });

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return UserProfileResponse.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //upload pic
  static Future<UploadPicResponse> uploadPic(String path) async {
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    Map<String, String> headers = {
      "Accept": "application/json",
    //  'Content-Type': 'application/json',
    "Authorization": bearer + token
    };
    var request =
    new http.MultipartRequest("POST", Uri.parse(mainBeUrl + "profile/update-pic"));
    request.headers.addAll(headers);
    request.files.add(new http.MultipartFile.fromBytes('image', await File.fromUri(Uri.parse(path)).readAsBytes(),filename: path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var d = jsonDecode(responseString);
      return UploadPicResponse.fromJson(d);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Update profile
  static Future<UpdateProfileResponse> updateUser(data) async {
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    String url = mainBeUrl + 'profile/update';
    final response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": bearer  + token
    }, body: data);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return UpdateProfileResponse.fromJson(item);
    } else {
      throw 'Unable to register user';
    }
  }

  //Country list
  static Future<CountryListBean> getCountryList() async {
    String url = mainBeUrl + 'getcountries';
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return CountryListBean.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //States list
  static Future<StateListBean> getStateList(int id) async {
    String url = mainBeUrl + 'getstate?countryid='+id.toString();
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return StateListBean.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Cities list
  static Future<CityListBean> getCityList(int id) async {
    String url = mainBeUrl + 'getcity?stateid='+id.toString();
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return CityListBean.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Amenities list
  static Future<AmenitiesResponse> getAmenitiesList() async {
    String url = mainBeUrl + 'getamenties';
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
    });

    print(response.body);
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return AmenitiesResponse.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Post Ad
  static Future<PostAdResponse?> postAd() async {
    String title = AdInfoState.title.text;
    String price = AdInfoState.price.text;
    String description = AdInfoState.description.text;
    String name = ContactInfoState.name.text;
    String email = ContactInfoState.email.text;
    String phone = ContactInfoState.phone.text;
    String imgPath1 = AdInfoState.imgPath1 ?? '';
    String imgPath2 = AdInfoState.imgPath2 ?? '';
    String imgPath3 = AdInfoState.imgPath3 ?? '';
    String tags = AdInfoState.tags.text ?? '';
    String categoryId = AdInfoState.selectedCategory != null ? AdInfoState
        .selectedCategory!.id.toString() : '';
    String countryId = AdInfoState.selectedCountry != null ? AdInfoState
        .selectedCountry!.id.toString() : '';
    String stateId = AdInfoState.selectedState != null ? AdInfoState
        .selectedState!.id.toString() : '';
    String cityId = AdInfoState.selectedCity != null ? AdInfoState.selectedCity!.id.toString() : '';
    String streetAddress = AdInfoState.streetAddress.text ?? '';
    String pinCode = AdInfoState.pinCode.text ?? '';
    String beds = PropertyInfoState.beds.text ?? '';
    String hall = PropertyInfoState.hall.text ?? '';
    String bathroom = PropertyInfoState.bathroom.text ?? '';
    String space = PropertyInfoState.space.text ?? '';
    String builtYear = PropertyInfoState.builtYear.text ?? '';
    String floors = PropertyInfoState.floors.text ?? '';

    String amenities = '';
    if (PropertyInfoState.selectedAmenitiesList!.isNotEmpty) {
      List<String> list = [];
      for (var item in PropertyInfoState.selectedAmenitiesList ?? []) {
        list.add(item.id.toString());
      }

      amenities = list.join(",");
    }


    String url = mainBeUrl + 'post-ads';
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": bearer + token };
    var request = http.MultipartRequest('POST', Uri.parse(url) );
    request.headers.addAll(headers);
    request.fields['title'] = title;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['amenities'] = amenities;
    request.fields['tags'] = tags;
    request.fields['category'] = categoryId;
    request.fields['country_id'] = countryId ?? '';
    request.fields['state_id'] = stateId ?? '';
    request.fields['city_id'] = cityId ?? '';
    request.fields['str_address'] = streetAddress;
    request.fields['pin_code'] = pinCode;
    request.fields['no_of_beds'] = beds;
    request.fields['no_of_hall'] = hall;
    request.fields['no_of_bathroom'] = bathroom;
    request.fields['space'] = space;
    request.fields['year'] = builtYear;
    request.fields['no_floor'] = floors;
    if(imgPath1!=''){
      request.files.add(await http.MultipartFile.fromPath('image_1', imgPath1));
    }
    if(imgPath2!=''){
      request.files.add(await http.MultipartFile.fromPath('image_2', imgPath2));
    }
    if(imgPath3!=''){
      request.files.add(await http.MultipartFile.fromPath('image_3', imgPath3));
    }
   // print(request.fields);
    var response = await request.send();
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.toBytes();
      print(responseData);
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
      var item = jsonDecode(responseString);
      print(item);
      return PostAdResponse.fromJson(item);
    } else {
      //throw response.reasonPhrase;
    }
  }

  //My Ads
  static Future<MyAdsResponse> getMyAds() async {
    String url = mainBeUrl + 'viewall-user-post';
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    print( bearer + token);
    final response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json',
      "Authorization": bearer + token
    });
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      print(item);
      return MyAdsResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return MyAdsResponse.fromJson(item);
    }
  }

  //All Ads
  static Future<MyAdsResponse> getAllAds() async {
    String url = mainBeUrl + 'viewall-ads';
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    print( bearer + token);
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json',
      "Authorization": bearer + token
    });
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);

      print("======>");
      print(item);
      return MyAdsResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return MyAdsResponse.fromJson(item);
    }
  }

  //View Ad Details
  static Future<AdDetailsResponse> getAdDetails(String? id) async {

    String url = mainBeUrl + 'view-post?id='+id!;
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    print( bearer + token);
    final response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json',
      "Authorization": bearer + token
    });
    print(response.body);
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return AdDetailsResponse.fromJson(item);

    } else {
      var item = jsonDecode(response.body);
      return AdDetailsResponse.fromJson(item);
    }
  }

  //Delete Ad
  static Future<APIResponse> deleteAd(String? id) async {

    String url = mainBeUrl + 'delete-post?id='+id!;
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    print( bearer + token);
    final response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json',
      "Authorization": bearer + token
    });
    print(response.body);
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);

    } else {
      var item = jsonDecode(response.body);
      return APIResponse.fromJson(item);
    }
  }

  //Update Ad
  static Future<PostAdResponse?> updateAd(String? id) async {
    String title = UpdateAdInfoState.title.text;
    String price = UpdateAdInfoState.price.text;
    String description = UpdateAdInfoState.description.text;
    String name = UpdateContactInfoState.name.text;
    String email = UpdateContactInfoState.email.text;
    String phone = UpdateContactInfoState.phone.text;
    String tags = UpdateAdInfoState.tags.text ?? '';
    String countryId = UpdateAdInfoState.selectedCountry != null ? UpdateAdInfoState
        .selectedCountry!.id.toString() : '';
    String stateId = UpdateAdInfoState.selectedState != null ? UpdateAdInfoState
        .selectedState!.id.toString() : '';
    String cityId = UpdateAdInfoState.selectedCity != null ? UpdateAdInfoState.selectedCity!.id.toString() : '';
    String streetAddress = UpdateAdInfoState.streetAddress.text ?? '';
    String pinCode = UpdateAdInfoState.pinCode.text ?? '';
    String beds = UpdatePropertyInfoState.beds.text ?? '';
    String hall = UpdatePropertyInfoState.hall.text ?? '';
    String bathroom = UpdatePropertyInfoState.bathroom.text ?? '';
    String space = UpdatePropertyInfoState.space.text ?? '';
    String builtYear = UpdatePropertyInfoState.builtYear.text ?? '';
    String floors = UpdatePropertyInfoState.floors.text ?? '';
    String categoryId = UpdateAdInfoState.selectedCategory != null ? UpdateAdInfoState
        .selectedCategory!.id.toString() : '';
    String amenities = '';
    if (UpdatePropertyInfoState.selectedAmenitiesList!.isNotEmpty) {
      List<String> list = [];
      for (var item in UpdatePropertyInfoState.selectedAmenitiesList ?? []) {
        list.add(item.id.toString());
      }

      amenities = list.join(",");
    }
    print(amenities);
    String imgPath1 = UpdateAdInfoState.imgPath1 ?? '';
    String imgPath2 = UpdateAdInfoState.imgPath2 ?? '';
    String imgPath3 = UpdateAdInfoState.imgPath3 ?? '';


    String url = mainBeUrl + 'update-post-ads?id='+id!;
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": bearer + token };
    var request = http.MultipartRequest('POST', Uri.parse(url) );
    request.headers.addAll(headers);
    request.fields['title'] = title;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['amenities'] = '1,2';
    request.fields['tags'] = tags;
    request.fields['category'] = '1';
    request.fields['country_id'] = countryId;
    request.fields['state_id'] = stateId;
    request.fields['city_id'] = cityId;
    request.fields['str_address'] = streetAddress;
    request.fields['pin_code'] = pinCode;
    request.fields['no_of_beds'] = beds;
    request.fields['no_of_hall'] = hall;
    request.fields['no_of_bathroom'] = bathroom;
    request.fields['space'] = space;
    request.fields['year'] = builtYear;
    request.fields['no_floor'] = floors;
    request.fields['category'] = categoryId;
    print(imgPath1);
    print(imgPath2);
    print(imgPath3);

    if(imgPath1!=''){
      request.files.add(await http.MultipartFile.fromPath('image_1', imgPath1));
    }
    if(imgPath2!=''){
      request.files.add(await http.MultipartFile.fromPath('image_2', imgPath2));
    }
    if(imgPath3!=''){
      request.files.add(await http.MultipartFile.fromPath('image_3', imgPath3));
    }
    print(url);
    print(request.fields);
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var item = jsonDecode(responseString);
      print(item);
      return PostAdResponse.fromJson(item);

    } else {
      //throw response.reasonPhrase;
    }
  }

  //Categories list
  static Future<CategoriesListBean> getCategoriesList() async {
    String url = mainBeUrl + 'getcategories';
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return CategoriesListBean.fromJson(item);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Search Ad
  static Future<MyAdsResponse> searchAd(String? city, String pinCode) async {

    String url = mainBeUrl + 'search-ads?city='+city!+'&pincode='+pinCode;
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    print( bearer + token);
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json',
      "Authorization": bearer + token
    });
    print(response.body);
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      return MyAdsResponse.fromJson(item);

    } else {
      var item = jsonDecode(response.body);
      return MyAdsResponse.fromJson(item);
    }
  }

  //Login
  static Future<http.Response?> sendMessage(data) async {
    String url = mainBeUrl + 'chat-send';
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    final response = await http.post(Uri.parse(url), body: data,
        headers: {
          "Accept": "application/json",
          // 'Content-Type': 'application/json',
          "Authorization": bearer + token
        });
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var item = jsonDecode(response.body);
      return response;
    } else {
      return null;
      throw 'Unable to login user';
    }
  }

  //Filter Ads
  static Future<MyAdsResponse> filterAds(String minPrice, String maxPrice, String beds, String bathrooms, String minSpace, String maxSpace) async {
    String url = mainBeUrl + 'search-ads?'+
        'cities='+'&'+'max_amount='+maxPrice+ '&'+'min_amount='+minPrice+'&pincode=0'+
    '&min_beds=0'+
    '&max_beds='+beds+
    '&min_bathroom=0'+
    '&max_bathroom='+bathrooms+
    '&min_space='+minSpace+
    '&max_space='+maxSpace;
    print(url);
    String? bearer = "Bearer ";
    String token = Preference?.getString("token") ?? "";
    print( bearer + token);
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      // 'Content-Type': 'application/json',
   //   "Authorization": bearer + token
    });
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);

      print("======>");
      print(item);
      return MyAdsResponse.fromJson(item);
    } else {
      var item = jsonDecode(response.body);
      return MyAdsResponse.fromJson(item);
    }
  }


}