trigger forTestTrigger on Account (before update) {
    
    for (Account acc: trigger.new) {
        
        if (acc.BillingAddressKana__c != trigger.oldMap.get(acc.Id).BillingAddressKana__c) {
            
            acc.ShippingAddressKana__c = trigger.oldMap.get(acc.Id).BillingAddressKana__c;
            update acc;
        }
    }
}