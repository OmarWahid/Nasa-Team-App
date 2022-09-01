

abstract class NasaState {
}

class InitialState_ extends NasaState {}
class changeIndexButton extends NasaState {}

class SuccessProfileData extends NasaState {}
class ErrorProfileData extends NasaState {}
class LoadingProfileData extends NasaState {}

class SuccessUpdateTextData extends NasaState {
}
class ErrorUpdateTextData extends NasaState {}
class LoadingUpdateTextData extends NasaState {}

class LoadingSecond extends NasaState {}
class SuccessSecond extends NasaState {}

class ProfilePikerSuccessState extends NasaState {}
class ProfilePikerErrorState extends NasaState {}

class SuccessUploadProfileUrl extends NasaState {}
class LoadingUploadProfileUrl extends NasaState {}
class ErrorUploadProfileUrl extends NasaState {}

class SuccessCompressPhoto extends NasaState {}
class LoadingCompressPhoto extends NasaState {}
class ErrorCompressPhoto extends NasaState {}



class SuccessLogoutData extends NasaState {}
class ErrorLogoutData extends NasaState {}

class LoadingGetUserData extends NasaState {}
class SuccessGetUserData extends NasaState {
  // final UserData userData;
  // SuccessGetUserData({required this.userData});
}
class ErrorGetUserData extends NasaState {
  final String error;
  ErrorGetUserData({required this.error});
}

class SuccessGetNasaMemberData extends NasaState {
  // final NasaMemberData userData;
  // SuccessGetNasaMemberData({required this.userData});
}
class ErrorGetNasaMemberData extends NasaState {
  final String error;
  ErrorGetNasaMemberData({required this.error});
}


class SuccessNasaData extends NasaState {}
class ErrorNasaData extends NasaState {}

class LoadingNasaData extends NasaState {}

class CheckConnectState extends NasaState {}

class LoadingGetPosts extends NasaState {}
class SuccessGetPosts extends NasaState {}
class ErrorGetPosts extends NasaState {}

class LoadingLikePosts extends NasaState {}
class SuccessLikePosts extends NasaState {}
class ErrorLikePosts extends NasaState {}

class LoadingCommentPosts extends NasaState {}
class SuccessCommentPosts extends NasaState {}
class ErrorCommentPosts extends NasaState {}

class GetIdPostsTest extends NasaState {}

class SuccessGroupSendMessage extends NasaState {}
class ErrorGroupSendMessage extends NasaState {}
class LoadingGroupSendMessage extends NasaState {}
