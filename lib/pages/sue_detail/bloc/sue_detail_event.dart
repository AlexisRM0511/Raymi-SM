part of 'sue_detail_bloc.dart';

@immutable
abstract class SueDetailEvent {}

class LeadingIconButtonPressedEvent extends SueDetailEvent {
  final BuildContext context;

  LeadingIconButtonPressedEvent({required this.context});
}

class GoSueEditEvent extends SueDetailEvent {
  final BuildContext context;
  final SueModel sue;

  GoSueEditEvent({required this.context, required this.sue});
}
