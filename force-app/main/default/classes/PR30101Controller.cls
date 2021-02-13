public class PR30101Controller {

    public List<PR30101Been> beenList{get;set;}
    public List<selectOption> accountList{get;set;}
    public Account acc {get;set;}
    public Id accountId {get;set;}
    public T005__c t005 {get;set;}
    public List<T006__c> t006_List{get;set;}
    
    public PR30101Controller()
    {
        beenList = getBeenList();
        accountList = getAccount();
        t005 = new T005__c();
       // t006_List = this.t006_List;
        system.debug(t005);
    }
    
    public List<PR30101Been> getBeenList()
    {
        List<PR30101Been> beenList = PR30101Dao.getBeen(accountId);
        return beenList;
    }
    
    public void selectProduct()
    {
        this.beenList = getBeenList();
    }
    
    public List<selectOption> getAccount()
    {
        List<selectOption> accountList = PR30101Dao.getAccount();

        return accountList;
    }
    
    public PageReference updateProduct()
    {
        Savepoint sp = Database.setSavepoint();
        //string url = ApexPages.currentPage().getHeaders().get('host');
        Integer index = 1;
        List<T006__c> t006List = new List<T006__c>();

        try
        {
            T005__c t005_tem = new T005__c(Account__c = this.accountId,
                                           T00502__c = this.t005.T00504__c,
                                           T00504__c = this.t005.T00504__c,
                                           T00505__c = this.t005.T00504__c);
            insert t005_tem;
            t005 = t005_tem;
            
            for(PR30101Been p : this.beenList)
            {
                T006__c t006_tem = new T006__c();
                
                if(p.count > 0)
                {
                    t006_tem = new T006__c(Prodcut__c = p.product.Id,
                                           Name = String.valueOf(index),
                                           T00603__c = p.count,
                                           T00602__c = p.product.SalesPrice__c,
                                           T005__c = t005_tem.Id);    
                }
                
                t006List.add(t006_tem);
                index++;
            }

            insert t006List;
            this.t006_List = t006List;
            system.debug(this.t006_List[0].Prodcut__r);
            system.debug(this.t005);
            //system.debug(this.acc);
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'成功'));
            //url = 'https://'+url+'/apex/PR30101_VF0824PDF';
            PageReference newUrl = new PageReference('/apex/PR30101_VF0824PDF');
            return newUrl;
        }
        catch(DMLException e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'失敗'));
            Database.rollback(sp);
        }
        
        
        return null;
    }
    
}