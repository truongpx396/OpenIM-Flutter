import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:rxdart/rxdart.dart';

import 'controller/app_controller.dart';

enum IMSdkStatus {
  connectionFailed,
  connecting,
  connectionSucceeded,
  syncStart,
  synchronizing,
  syncEnded,
  syncFailed,
}

class IMCallback {
  final initLogic = Get.find<AppController>();

  Function(RevokedInfo info)? onRecvMessageRevoked;

  Function(List<ReadReceiptInfo> list)? onRecvC2CReadReceipt;

  Function(List<ReadReceiptInfo> list)? onRecvGroupReadReceipt;

  Function(Message msg)? onRecvNewMessage;

  Function(String msgId, int progress)? onMsgSendProgress;

  Function(BlacklistInfo u)? onBlacklistAdd;

  Function(BlacklistInfo u)? onBlacklistDeleted;

  final conversationAddedSubject = BehaviorSubject<List<ConversationInfo>>();

  final conversationChangedSubject = BehaviorSubject<List<ConversationInfo>>();

  final unreadMsgCountEventSubject = PublishSubject<int>();

  final friendApplicationChangedSubject =
      BehaviorSubject<FriendApplicationInfo>();

  final friendAddSubject = BehaviorSubject<FriendInfo>();

  final friendDelSubject = BehaviorSubject<FriendInfo>();

  final friendInfoChangedSubject = BehaviorSubject<FriendInfo>();

  final selfInfoUpdatedSubject = BehaviorSubject<UserInfo>();

  final groupInfoUpdatedSubject = BehaviorSubject<GroupInfo>();

  final groupApplicationChangedSubject =
      BehaviorSubject<GroupApplicationInfo>();

  final initializedSubject = PublishSubject<bool>();

  final memberAddedSubject = BehaviorSubject<GroupMembersInfo>();

  final memberDeletedSubject = BehaviorSubject<GroupMembersInfo>();

  final memberInfoChangedSubject = PublishSubject<GroupMembersInfo>();

  final joinedGroupDeletedSubject = BehaviorSubject<GroupInfo>();

  final joinedGroupAddedSubject = BehaviorSubject<GroupInfo>();

  final onKickedOfflineSubject = PublishSubject();

  final imSdkStatusSubject = BehaviorSubject<IMSdkStatus>();

  void imSdkStatus(IMSdkStatus status) {
    imSdkStatusSubject.add(status);
  }

  void kickedOffline() {
    onKickedOfflineSubject.add("");
  }

  void selfInfoUpdated(UserInfo u) {
    selfInfoUpdatedSubject.addSafely(u);
  }

  void recvMessageRevoked(RevokedInfo info) {
    onRecvMessageRevoked?.call(info);
  }

  void recvC2CMessageReadReceipt(List<ReadReceiptInfo> list) {
    onRecvC2CReadReceipt?.call(list);
  }

  void recvGroupMessageReadReceipt(List<ReadReceiptInfo> list) {
    onRecvGroupReadReceipt?.call(list);
  }

  void recvNewMessage(Message msg) {
    initLogic.showNotification(msg);
    onRecvNewMessage?.call(msg);
  }

  void recvCustomBusinessMessage(String s) {}

  void progressCallback(String msgId, int progress) {
    onMsgSendProgress?.call(msgId, progress);
  }

  void blacklistAdded(BlacklistInfo u) {
    onBlacklistAdd?.call(u);
  }

  void blacklistDeleted(BlacklistInfo u) {
    onBlacklistDeleted?.call(u);
  }

  void friendApplicationAccepted(FriendApplicationInfo u) {
    friendApplicationChangedSubject.addSafely(u);
  }

  void friendApplicationAdded(FriendApplicationInfo u) {
    friendApplicationChangedSubject.addSafely(u);
  }

  void friendApplicationDeleted(FriendApplicationInfo u) {
    friendApplicationChangedSubject.addSafely(u);
  }

  void friendApplicationRejected(FriendApplicationInfo u) {
    friendApplicationChangedSubject.addSafely(u);
  }

  void friendInfoChanged(FriendInfo u) {
    friendInfoChangedSubject.addSafely(u);
  }

  void friendAdded(FriendInfo u) {
    friendAddSubject.addSafely(u);
  }

  void friendDeleted(FriendInfo u) {
    friendDelSubject.addSafely(u);
  }

  void conversationChanged(List<ConversationInfo> list) {
    conversationChangedSubject.addSafely(list);
  }

  void newConversation(List<ConversationInfo> list) {
    conversationAddedSubject.addSafely(list);
  }

  void groupApplicationAccepted(GroupApplicationInfo info) {
    groupApplicationChangedSubject.add(info);
  }

  void groupApplicationAdded(GroupApplicationInfo info) {
    groupApplicationChangedSubject.add(info);
  }

  void groupApplicationDeleted(GroupApplicationInfo info) {
    groupApplicationChangedSubject.add(info);
  }

  void groupApplicationRejected(GroupApplicationInfo info) {
    groupApplicationChangedSubject.add(info);
  }

  void groupInfoChanged(GroupInfo info) {
    groupInfoUpdatedSubject.addSafely(info);
  }

  void groupMemberAdded(GroupMembersInfo info) {
    memberAddedSubject.add(info);
  }

  void groupMemberDeleted(GroupMembersInfo info) {
    memberDeletedSubject.add(info);
  }

  void groupMemberInfoChanged(GroupMembersInfo info) {
    memberInfoChangedSubject.add(info);
  }

  void joinedGroupAdded(GroupInfo info) {
    joinedGroupAddedSubject.add(info);
  }

  void joinedGroupDeleted(GroupInfo info) {
    joinedGroupDeletedSubject.add(info);
  }

  void totalUnreadMsgCountChanged(int count) {
    initLogic.showBadge(count);
    unreadMsgCountEventSubject.addSafely(count);
  }

  void meetingSteamChanged(MeetingStreamEvent event) {}

  void close() {
    initializedSubject.close();
    friendApplicationChangedSubject.close();
    friendAddSubject.close();
    friendDelSubject.close();
    friendInfoChangedSubject.close();
    selfInfoUpdatedSubject.close();
    groupInfoUpdatedSubject.close();
    conversationAddedSubject.close();
    conversationChangedSubject.close();
    memberAddedSubject.close();
    memberDeletedSubject.close();
    memberInfoChangedSubject.close();
    onKickedOfflineSubject.close();
    groupApplicationChangedSubject.close();
    imSdkStatusSubject.close();
    joinedGroupDeletedSubject.close();
    joinedGroupAddedSubject.close();
  }
}
