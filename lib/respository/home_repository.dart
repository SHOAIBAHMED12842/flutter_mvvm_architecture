
import 'package:provider_mvvm_architecture/data/network/BaseApiServices.dart';
import 'package:provider_mvvm_architecture/data/network/NetworkApiService.dart';
import 'package:provider_mvvm_architecture/model/movies_model.dart';
import 'package:provider_mvvm_architecture/res/app_url.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<MovieListModel> fetchMoviesList()async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}