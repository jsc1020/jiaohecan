@isTest
public class fotTestTriggerTest {

    @isTest
    public static void testA_Test () {
        
        Account acc = new Account();
        acc.Name = 'test';
        acc.BillingAddressKana__c = 'a';
        acc.ShippingAddressKana__c = 'b';
        
        insert acc;
        
        acc.BillingAddressKana__c = 'c';
        update acc;
        
        Account accTmp = [SELECT Id, BillingAddressKana__c, ShippingAddressKana__c FROM Account LIMIT 1];
        
        system.debug('accTmp:' + accTmp);
    }
}