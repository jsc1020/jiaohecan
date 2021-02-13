@isTest
private class TestCleanUpBatchClass {
    static testmethod void test() {
        // The query used by the batch job.
        String query = 'SELECT Id,CreatedDate FROM Prodcut__c ' +
            'WHERE Id NOT IN (SELECT Prodcut__c FROM LineItem__c)';
        // Create some test merchandise items to be deleted
        // by the batch job.
        Prodcut__c[] ml = new List<Prodcut__c>();
        for (Integer i=0;i<10;i++) {
            Prodcut__c m = new Prodcut__c(
                Name='商品追加' + i,
                ProductCode__c='CD' + i,
                SalesPrice__c=2000,
                StockQuantity__c=100);
            ml.add(m);
        }
        insert ml;
        Test.startTest();
        CleanUpRecords c = new CleanUpRecords(query);
        Database.executeBatch(c);
        Test.stopTest();
        // Verify merchandise items got deleted
        Integer i = [SELECT COUNT() FROM Prodcut__c];
        System.assertEquals(i, 0);
    }
}