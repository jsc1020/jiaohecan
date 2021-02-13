trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {

    List<BatchLeadConvertErrors__c> blceList = new List<BatchLeadConvertErrors__c>();
    
    for (BatchApexErrorEvent baee : Trigger.New) {
        
        BatchLeadConvertErrors__c blce = new BatchLeadConvertErrors__c();
        
        blce.AsyncApexJobId__c = baee.AsyncApexJobId;
        blce.Records__c = baee.JobScope;
        blce.StackTrace__c = baee.StackTrace;
        
        blceList.add(blce);
    }
    
    insert blceList;
}