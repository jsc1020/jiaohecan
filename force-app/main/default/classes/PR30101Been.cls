public class PR30101Been {
    
    public Prodcut__c product{get;set;}
    public Integer count{get;set;}
    
    public PR30101Been(Prodcut__c product)
    {
        this.count = 0;
        this.product = product;
    }

}