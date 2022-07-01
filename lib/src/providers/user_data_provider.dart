import 'package:appetit/src/models/app_user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'dart:developer';

// CLASE PARA MANEJAR LA BASE DE DATOS
class UserDataProvider with ChangeNotifier {

  // GUARDAR DATOS DEL USUARIO
  Future<bool> saveUserData({
    required AppUser userData,
    required SupabaseClient client,
  }) async {
    bool result = false;
    try {
      final insertResponse = await client
        .from('appUsers')
        .insert([
          {
            'name': userData.userName,
            'profile': userData.userProfilePicture,
            'address': userData.userAddress,
            'lat': userData.userLat,
            'lng': userData.userLng,
            'phone': userData.userPhone,
            'userToken': userData.authToken,
          },
        ])
        .execute();
      if (insertResponse.error == null) {
        print("**** INSERT OK ****");
        inspect(insertResponse.data);
        result = true;
      } else {
        print("**** INSERT ERROR ****");
        inspect(insertResponse.error);
        result = false;
      }
    } catch(e) {
      print("**** INSERT ERROR - ${e}");
      result = false;
    }
    return result;
  }

  // TRAER DATOS DE UN USUARIO
  Future<Map<String, dynamic>> getUserData({
    required String userToken,
    required SupabaseClient client,
  }) async {
    final Map<String, dynamic> _result = {
      "result": false,
    };
    try {
      final searchResponse = await client
        .from('appUsers')
        .select()
        .textSearch('userToken', "$userToken")
        .execute(count: CountOption.exact);
      if (searchResponse.error == null) {
        print("**** SEARCH OK ****");
        inspect(searchResponse.data);
        print("**** SEARCH COUNT ****");
        print(searchResponse.count);
        if (searchResponse.count! == 0) {
          _result["result"] = false;
        }
        if (searchResponse.count! == 1) {
          _result["result"] = true;
          _result.addAll({
            "count": searchResponse.count,
          });
          _result.addAll(searchResponse.data[0]);
        }
        if (searchResponse.count! > 1) {
          bool deleteResult = await deleteUserData(userToken: userToken, client: client);
          if (deleteResult) {
            _result["result"] = false;
          } else {
            _result["result"] = true;
            _result.addAll({
              "count": searchResponse.count,
            });
            _result.addAll(searchResponse.data[0]);
          }
        }
      } else {
        print("**** SEARCH ERROR ****");
        inspect(searchResponse.error);
        _result["result"] = false;
      }
    } catch(e) {
      print("**** SEARCH ERROR - ${e}");
      _result["result"] = false;
    }
    return _result;
  }

  // ACTUALIZAR DATOS DEL USUARIO
  Future<bool> updateUserData({
    required AppUser userData,
    required SupabaseClient client,
  }) async {
    bool result = false;
    try {
      final updateResponse = await client
        .from('appUsers')
        .update(
          {
            'name': userData.userName,
            'profile': userData.userProfilePicture,
            'address': userData.userAddress,
            'lat': userData.userLat,
            'lng': userData.userLng,
            'phone': userData.userPhone,
            'userToken': userData.authToken,
          },
        )
        .eq('userToken', '${userData.authToken}')
        .execute();
      if (updateResponse.error == null) {
        print("**** UPDATE OK ****");
        inspect(updateResponse.data);
        result = true;
      } else {
        print("**** UPDATE ERROR ****");
        inspect(updateResponse.error);
        result = false;
      }
    } catch(e) {
      print("**** UPDATE ERROR - ${e}");
      result = false;
    }
    return result;
  }

  // BORRAR DATOS DEL USUARIO
  Future<bool> deleteUserData({
    required String userToken,
    required SupabaseClient client,
  }) async {
    bool result = false;
    try {
      final deleteResponse = await client
        .from('appUsers')
        .delete()
        .match({'userToken': "${userToken}"})
        .execute();
      if (deleteResponse.error == null) {
        print("**** DELETE OK ****");
        inspect(deleteResponse.data);
        result = true;
      } else {
        print("**** DELETE ERROR ****");
        inspect(deleteResponse.error);
        result = false;
      }
    } catch(e) {
      print("**** DELETE ERROR - ${e}");
      result = false;
    }
    return result;
  }

}
