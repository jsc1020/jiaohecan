public with sharing class BatchControllerTriggerHandler extends TriggerHandler {
    // トリガーの有効化判定フラグ
    public static Boolean TriggerDisabled = false;

    /**
    * @description トリガーの有効化判定処理。
    */
    public override Boolean IsDisabled(){
        return TriggerDisabled;
    }

    /**
    * @description after update トリガーのハンドラ処理。
    * @param oldMap 更新前対象データ。
    * @param newMap 更新後対象データ。
    */
    public override void AfterInsert(Map<Id, SObject> newMap) {
        BatchController__c batchController = (BatchController__c)newMap.values().get(0);
        if (batchController.BatchStartFlg__c) {
            BatchAddressMaster batch = new BatchAddressMaster();
            Id batchId = Database.executeBatch(batch, BatchAddressMaster.BATCH_SIZE);
        }
    }
}