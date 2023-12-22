import 'dart:io';

import 'package:cnattendance/screen/employer/allProject/presentation/manager/detailsContractBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailsContractCubit extends Cubit<DetailsContractState> {
  DetailsContractCubit() : super(DetailsContractInitial());

  static DetailsContractCubit of(BuildContext context) => BlocProvider.of<DetailsContractCubit>(context);
  Uint8List? imageFile;

  void getImage({Uint8List? screen}) {
    imageFile = screen;

    emit(GetImageState());
  }

  Future<void> savePdf({Uint8List? screen}) async {
    emit(SavePdfLoadingState());
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Image(pw.MemoryImage(screen!));
          },
        ),
      );
      final path = await getTemporaryDirectory();

      final file = await File('${path.path}/my_screen.pdf').writeAsBytes(await pdf.save()); // Page
      await OpenFile.open('${path.path}/my_screen.pdf');
      print('Success');
      emit(SavePdfSuccessState());
    } catch (error) {
      print(error);
      showToast('Error in $error');
      emit(SavePdfErrorState());
    }
  }
}
