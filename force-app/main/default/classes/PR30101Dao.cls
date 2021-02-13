public class PR30101Dao {
    
    public static List<selectOption> getAccount()
    {
        List<selectOption> selectOptions = new List<selectOption>();
        String id = null;
        String name = null;
        
        AggregateResult[] accountList = [SELECT Account__r.Name name, Account__r.Id accountId
                       FROM Prodcut__c
                       WHERE NoSafe__c = 1
                       AND Flag__c = '0'
                       GROUP BY Account__r.Id, Account__r.Name];
        for(AggregateResult acc : accountList)
        {
            id = (String)acc.get('accountId');
            name = (String)acc.get('name');
            selectOptions.add(new SelectOption(id, name));
        }
        
        return selectOptions;
    }
    
    public static List<PR30101Been> getBeen(Id id)
    {
        List<PR30101Been> beenList = new List<PR30101Been>();
        List<Prodcut__c> productList = new List<Prodcut__c>();

        productList = [SELECT ProductCode__c, Name, Unit__c, SalesPrice__c, Account__c
                       FROM Prodcut__c
                       WHERE Flag__c = '0'
                       AND NoSafe__c = 1
                       AND Account__r.Id = :id];
        for(Prodcut__c p : productList)
        {
            beenList.add(new PR30101Been(p));
        }
        
        return beenList;
    }
}