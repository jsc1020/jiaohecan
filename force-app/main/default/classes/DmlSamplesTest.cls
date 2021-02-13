@isTest
public class DmlSamplesTest {
    public static testMethod void testUpsertLeads(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0; i<100; i++){
            leadList.add(new Lead(LastName = 'testLead' + i,
                                 Company = 'testCompany' + i));
        }
        Test.startTest();
        
		List<DataBase.UpsertResult> upsertRList = DmlSamples.upsertLeads(leadList);
        
        Test.stopTest();
        
        Set<Id> ids = new Set<Id>();
        for(DataBase.UpsertResult re: upsertRList){
            System.assert(re.isSuccess());
			ids.add(re.getId());
		}
        List<Lead> leads = [SELECT Id,(SELECT Subject FROM Tasks)
                           FROM Lead
                           WHERE Id IN :ids];
        for(Lead l: leads){
            System.assertEquals(1, l.tasks.size());
            System.assertEquals('Follow up', l.tasks[0].Subject);
        }
    }
}