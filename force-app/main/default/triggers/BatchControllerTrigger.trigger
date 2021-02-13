trigger BatchControllerTrigger on BatchController__c(before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.executeHandler(new BatchControllerTriggerHandler());
}