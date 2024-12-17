import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/_application/service/storage/storage_service.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/widgets/select_state_ui.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/widgets/select_township_ui.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/user/model/state_model.dart';
import 'package:innwa_mobile_dev/user/model/township_model.dart';
import 'package:innwa_mobile_dev/user/model/user_model.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../_application/service/api_service/model.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc(this._restAPI) : super(ProfileEditState()) {
    on<ProfileInitialEvent>(_profileInitial);
    on<GetImageFromGalleryEvent>(_getImageFromGallery);
    on<GetImageFromCameraEvent>(_getImageFromCamera);
    on<ClearImageEvent>(_clearImageEvent);
    on<UpdateFormEvent>(_updateForm);
    on<GetStateEvent>(_getStateEvent);
    on<GetTownshipEvent>(_getTownshipEvent);
    on<ShowStateBotttomSheetEvent>(_showStateBottomSheet);
    on<UpdateSelectedStateEvent>(_updateSelectedState);
    on<ShowTownshipBottomsheetEvent>(_showTownshipBottomsheetEvent);
    on<UpdateSelectedTownshipEvent>(_updateSelectedTownship);
  }

  final RestAPI _restAPI;

  final GlobalKey<FormState> updateForm = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _updateForm(UpdateFormEvent event, Emitter emit) async {
    final validate = updateForm.currentState!.validate();
    if (validate) {
      final UserBloc userBloc = BlocProvider.of<UserBloc>(event.context);
      emit(state.copyWith(sendStatus: ApiStatus.processing));
      final resData = await _updateUser(
        userId: userBloc.state.user!.id ?? 0,
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "address_detail": addressController.text,
          "phone": "09${phoneController.text}",
          "state_id":
              state.selectedState != null && state.selectedTownship != null
                  ? state.selectedState!.id
                  : null,
          "township_id":
              state.selectedState != null && state.selectedTownship != null
                  ? state.selectedTownship!.id
                  : null,
        },
        filePath: state.selectedFile != null ? [state.selectedFile!.path] : [],
      );
      emit(state.copyWith(sendStatus: ApiStatus.completed));
      if (resData != null) {
        BlocProvider.of<UserBloc>(event.context)
          ..add(
            UpdateUserDataEvent(
              context: event.context,
              user: UserModel.fromJson(
                resData["customer"],
              ),
            ),
          )
          ..add(
            UpdateProfileImagePathEvent(
              context: event.context,
              data: resData["profile_image_path"] + "/",
            ),
          );

        await Future.wait([
          StorageService.I.storeData(
            data: jsonEncode(UserModel.fromJson(
              resData["customer"],
            ).toJson()),
            key: StorageService.I.loginDataStoreKey,
          ),
          StorageService.I.storeData(
            data: resData["profile_image_path"],
            key: StorageService.I.profileImagePath,
          ),
        ]);
        showSnackBar(
          message: resData["message"],
          title: "Update Success",
          context: event.context,
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
        RouterService.of(event.context).pop();
      }
    }
  }

  Future<Map<String, dynamic>?> _updateUser({
    required int userId,
    required Map<String, dynamic> data,
    required List<String> filePath,
  }) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.postWithForm<Map<String, dynamic>>(
      method: "POST",
      path: "${ApiKey.userUpdate}/$userId?_method=PUT",
      error: error,
      data: data,
      filePaths: filePath,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  void _updateSelectedTownship(
    UpdateSelectedTownshipEvent event,
    Emitter emit,
  ) async {
    if (event.data.id != state.selectedTownship?.id) {
      emit(state.copyWith(
          selectedTownship: event.data, isSelectedTownship: true));
      if (event.canPop) {
        RouterService.of(event.context).pop();
      }
    } else {
      emit(state.clearTownship().copyWith(isSelectedTownship: false));
    }
  }

  void _updateSelectedState(UpdateSelectedStateEvent event, Emitter emit) {
    if (event.data.id != state.selectedState?.id) {
      emit(
        state.copyWith(
          townships: [],
        ),
      );
      emit(state
          .clearTownship()
          .copyWith(selectedState: event.data, isSelectedState: true));
      add(GetTownshipEvent(context: event.context));
      if (event.canPop) {
        RouterService.of(event.context).pop();
      }
    } else {
      emit(state.clearState().copyWith(isSelectedState: false));
    }
  }

  Future<void> _showTownshipBottomsheetEvent(
    ShowTownshipBottomsheetEvent event,
    Emitter emit,
  ) async {
    await showModalBottomSheet(
      context: event.context,
      builder: (ctx) {
        return BlocProvider.value(
          value: BlocProvider.of<ProfileEditBloc>(event.context),
          child: const SelectTownshipUi(),
        );
      },
    );
  }

  Future<void> _showStateBottomSheet(
    ShowStateBotttomSheetEvent event,
    Emitter emit,
  ) async {
    await showModalBottomSheet(
      context: event.context,
      builder: (ctx) {
        return BlocProvider.value(
          value: BlocProvider.of<ProfileEditBloc>(event.context),
          child: const SelectStateUi(),
        );
      },
    );
  }

  Future<void> _getTownshipEvent(GetTownshipEvent event, Emitter emit) async {
    emit(state.copyWith(townshipGetState: ApiStatus.processing));
    final resData = await _getTownship(stateId: state.selectedState!.id);
    if (resData != null) {
      final jsonList = resData["townships"] as List;
      final List<TownshipModel> data =
          jsonList.map((e) => TownshipModel.fromJson(e)).toList();
      emit(state.copyWith(
          townshipGetState: ApiStatus.completed, townships: data));
    } else {
      emit(state.copyWith(townshipGetState: ApiStatus.failure));
    }
  }

  Future<void> _getStateEvent(GetStateEvent event, Emitter emit) async {
    emit(state.copyWith(stateGetState: ApiStatus.processing));
    final resData = await _getStates();
    if (resData != null) {
      final jsonList = resData["states"] as List;
      final List<StateModel> data =
          jsonList.map((e) => StateModel.fromJson(e)).toList();
      emit(state.copyWith(stateGetState: ApiStatus.completed, states: data));
    } else {
      emit(state.copyWith(stateGetState: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getStates() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.states,
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  Future<Map<String, dynamic>?> _getTownship({required int stateId}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.township}/$stateId",
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  void _profileInitial(ProfileInitialEvent event, Emitter emit) {
    final UserState userState = BlocProvider.of<UserBloc>(event.context).state;

    emailController.text = userState.user!.email ?? '';
    nameController.text = userState.user!.name ?? '';
    addressController.text = userState.user!.addressDetail ?? "";
    if (userState.user!.phone != null) {
      List<String> tempPhone = userState.user!.phone!.split("");
      tempPhone.removeAt(0);
      tempPhone.removeAt(1);
      phoneController.text = tempPhone.join("");
    }
    if (userState.user!.state != null) {
      add(UpdateSelectedStateEvent(
          context: event.context, data: userState.user!.state!, canPop: false));
    }

    if (userState.user!.township != null) {
      add(
        UpdateSelectedTownshipEvent(
          context: event.context,
          data: userState.user!.township!,
          canPop: false,
        ),
      );
    }
  }

  void _clearImageEvent(ClearImageEvent event, Emitter emit) {
    emit(state.clearImage().copyWith(isSelectedFile: false));
  }

  Future<void> _getImageFromGallery(
      GetImageFromGalleryEvent event, Emitter emit) async {
    debugPrint(
        "-----------Pass-----------------------------------------------------");
    final permission = await _requestPermission();
    if (permission) {
      final File? image = await _getImage(ImageSource.gallery);
      if (image != null) {
        final cropImage = await _cropImage(image: image);
        if (cropImage != null) {
          emit(state.copyWith(selectedFile: cropImage, isSelectedFile: true));
        }
      }
    }
  }

  Future<void> _getImageFromCamera(
      GetImageFromCameraEvent event, Emitter emit) async {
    final permission = await _requestPermission();
    if (permission) {
      final File? image = await _getImage(ImageSource.camera);
      if (image != null) {
        final cropImage = await _cropImage(image: image);
        if (cropImage != null) {
          emit(state.copyWith(selectedFile: cropImage, isSelectedFile: true));
        }
      }
    }
  }

  Future<File?> _cropImage({required File image}) async {
    File? croppedfile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Colors.deepPurpleAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedfile != null) {
      return croppedfile;
    } else {
      print("Image is not cropped.");
    }
    return null;
  }

  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> result =
        await [Permission.storage, Permission.camera].request();

    if (result[Permission.storage] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<File?> _getImage(ImageSource source) async {
    final bool isGranted = await _requestPermission();
    if (!isGranted) {
      return null;
    }
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
