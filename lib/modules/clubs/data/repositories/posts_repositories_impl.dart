
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:igrejoteca_app/modules/clubs/data/models/post_model.dart';
import 'package:igrejoteca_app/modules/clubs/data/repositories/posts_repositories.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/enviroments/enviroment.dart';
import '../../../../core/utils/consts.dart';

class PostsRepositoryImpl extends PostsRepository{

  
  @override
  Future<Result<ClubPayload, Exception>> getPosts(String clubId) async {
    try {
      Uri url = getBackendURL(path: "/api/club/posts", queryParameters: {"club_id": clubId});
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        
        Map<String, dynamic> body = json.decode(resp.body);
        List<PostModel> posts = (body["posts"] as List).map((e) => PostModel.fromjson(e)).toList();
        List<String> members = (body["members"] as List<dynamic>).map((e) => e.toString()).toList();
        ClubPayload payload = ClubPayload(members: members, posts: posts);       
        return Result.success(payload);
      }else {
        return Result.failure(Exception());
      }
    } catch (e) {
      return Result.failure(Exception());
    }
  }
  
  @override
  Future<PostModel?> createPost({required String clubId, required String text}) async {
    try {
      Uri url = getBackendURL(path: "/api/club/posts");
      Map<String, String> headers = await Consts.authHeader();
      String body = json.encode({"club_id": clubId, "text": text});
      http.Response resp = await http.post(url, headers: headers, body: body);

      if (resp.statusCode == 201) {    

        Map<String, dynamic> body = json.decode(resp.body);
        PostModel post = PostModel.fromjson(body["data"]);

        return post;
      }else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

 
  
}


