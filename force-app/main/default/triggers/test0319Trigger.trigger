trigger test0319Trigger on T006__c (before update) {

    for (T006__c t : Trigger.New) {
        
        Prodcut__c p = new Prodcut__c(Id = t.Prodcut__c);
        p.test0319__c = t.test0319__c;
        
        update p;
    }
}