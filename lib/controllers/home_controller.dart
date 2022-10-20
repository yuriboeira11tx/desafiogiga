import 'dart:async';
import 'dart:io';
import 'package:desafiogigaservices/models/user_model.dart';
import 'package:desafiogigaservices/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class HomeController {
  APIRepository apiRepository = APIRepository();
  ValueNotifier<List<dynamic>> users = ValueNotifier<List<dynamic>>([]);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<String> error = ValueNotifier<String>("");
  Timer? timer;
  int page = 1;

  Future<void> fetchUsers({bool? isRefresh, String? filter}) async {
    if (isRefresh != null) page = 1;
    isLoading.value = true;

    var response = await apiRepository.callApi(page: page, filter: filter);
    switch (response.runtimeType) {
      case List<dynamic>:
        {
          error.value = "";

          if (isRefresh == null) {
            users.value += response.map((e) => User.fromJson(e)).toList();
          } else {
            users.value = response.map((e) => User.fromJson(e)).toList();
          }
        }
        break;
      case HttpException:
        {
          error.value = "Não foi possível encontrar os usuários";
        }
        break;
      case SocketException:
        {
          error.value = "Você está sem internet!";
        }
        break;
      default:
        {
          error.value = "Erro inesperado!";
        }
    }

    // paginação
    page++;
    isLoading.value = false;
  }
}
