import 'dart:convert';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/allProject/data/dataSource/proposal_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/proposal_one_model.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/proposalCubit/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProposalCubit extends Cubit<ProposalState> {
  ProposalCubit() : super(ProposalInitial());

  static ProposalCubit of(BuildContext context) => BlocProvider.of<ProposalCubit>(context);

  ProposalOneModel? proposalOneModel;

  void getAllProposals({required BuildContext context}) async {
    emit(ProposalLoadingState());

    //  Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    // Preferences.setSaved(value: RoleId.eight.name.tr, key: 'genderUser');
    //if (context.mounted) return;

    await ProposalDataSource.getProposals().then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('==== Error ====');
        emit(ProposalErrorState(l.errMessage));
      }, (r) async {
        await Preferences.setSaved(value: jsonEncode(r.toJson()), key: allProposalsKey);
        allProposalsModelCache = r;

        emit(ProposalSuccessState());
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }

  Future<void> getOneProposals({required BuildContext context, required int idProposal}) async {
    emit(ProposalLoadingState());

    //  Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    // Preferences.setSaved(value: RoleId.eight.name.tr, key: 'genderUser');
    //if (context.mounted) return;

    await ProposalDataSource.getOneProposal(idProposal: idProposal).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('==== Error ====');
        emit(ProposalErrorState(l.errMessage));
      }, (r) async {
        proposalOneModel = r;

        emit(ProposalSuccessState());
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }
}
