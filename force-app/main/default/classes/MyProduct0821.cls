public class MyProduct0821
{
    private final Prodcut__c p;
    
    public myProduct0821()
    {
        p = [SELECT Name,StockQuantity__c,SalesPrice__c
             FROM Prodcut__c
             WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
    
    public Prodcut__c getP()
    {
        return p;
    }
    
    public PageReference saveP()
    {
        update p;
        return null;
    }
}