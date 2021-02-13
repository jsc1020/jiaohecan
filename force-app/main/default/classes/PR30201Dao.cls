public class PR30201Dao 
{
	public static List<PR30201Been> getProductStock()
    {
        List<PR30201Been> productList = new List<PR30201Been>();
        List<Prodcut__c> productList_tem = new List<Prodcut__c>();
        
        productList_tem = [SELECT Name, StockQuantity__c, SafetyQuantity__c, NoSafe__c, Flag__c, Account__c
                           FROM Prodcut__c
                           WHERE NoSafe__c = 1];
        
        for(Integer i = 0; i < productList_tem.size(); i++)
        {
            productList.add(new PR30201Been(productList_tem[i]));
        }
        
        return productList;
    }
}