public class PR30201Been 
{
    public Prodcut__c product{get;set;}
    public Integer nyukosu{get;set;}
    public Integer afterStock{get;set;}
    public Boolean checkStock{get;set;}
    
    public PR30201Been(Prodcut__c product)
    {
        this.product = product;
        this.nyukosu = 0;
        this.checkStock = false;
    }
}