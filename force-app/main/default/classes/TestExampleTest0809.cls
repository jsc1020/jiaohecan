@isTest
public class TestExampleTest0809 {
    public static testMethod void testUpsertExample(){     
               
		Account acc = new Account(Name = 'test取引先');
		insert acc;
        Product2 pro2 = new Product2(Name = 'test商品');
        insert pro2;
        Opportunity opp = new Opportunity(Name = 'test商談商品',
                                         AccountId = acc.Id,
                                         stageName = '交渉',
                                         CloseDate = Date.today().addDays(10));
        insert opp;
        Pricebook2 pb2 = [SELECT Name,Id
                         FROM Pricebook2
                         WHERE Name = 'Standard'
                         LIMIT 1];
        PricebookEntry pbe = new PricebookEntry(Product2Id = pro2.Id,
                                               Pricebook2Id = pb2.Id,
                                               IsActive = true,
                                               UseStandardPrice = true,
                                               UnitPrice = 1000);
        insert pbe;
        
        OpportunityLineItem lineItem = new OpportunityLineItem(PricebookEntryId = pbe.Id);
        insert lineItem;
        
        Test.startTest();
        
        ExampleTest.upsertExample();
        
        Test.stopTest();
        
    }
}