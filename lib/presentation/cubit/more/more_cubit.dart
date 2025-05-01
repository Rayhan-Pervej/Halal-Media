import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/constants/api_constants.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';
part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());
  Future<void> getSharelink() async {
    emit(Logoutloading());
    await SharePlus.instance.share(
      ShareParams(uri: Uri.parse(ApiConstants.shareApplink)),
    );
    emit(Logoutloaded("Loaded"));
  }
}
