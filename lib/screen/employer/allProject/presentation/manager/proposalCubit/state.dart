abstract class ProposalState {}

class ProposalInitial extends ProposalState {}

// Get

class ProposalLoadingState extends ProposalState {}

class ProposalSuccessState extends ProposalState {}

class ProposalErrorState extends ProposalState {
  final String error;
  ProposalErrorState(this.error);
}
