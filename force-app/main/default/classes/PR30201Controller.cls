public class PR30201Controller {
    
    public List<PR30201Been> productList{get;set;}
    
    public  PR30201Controller()
    {
        productList = getProductList();
    }
    
    public List<PR30201Been> getProductList()
    {
        List<PR30201Been> productList = PR30201Dao.getProductStock();
        
        return productList;
    }
    
    public void change()
    {
        for (PR30201Been p : this.productList) {
            // チェックボックス = Trueの判定
            if (p.checkStock && p.nyukosu >0) {
               p.afterStock = Integer.ValueOf(p.product.StockQuantity__c) + p.nyukosu;
            }
        }
    }
    
    public PageReference save()
    {
        Savepoint sp = Database.setSavepoint();
        List<Prodcut__c> productList = new List<Prodcut__c>();
        for (PR30201Been p : this.productList) {
            // チェックボックス = Trueの判定
            if (p.checkStock && p.nyukosu >0) {
                p.product.StockQuantity__c = p.afterStock;
                productList.add(p.product);
                p.checkStock = false;
                p.nyukosu = 0;
                p.afterStock = null;
            }
        }
        
        if(productList.size() > 0)
        {            
            try
            {
                update productList;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'在庫更新成功！'));
                this.productList = getProductList();
            }
            catch(DMLException e)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'在庫更新失敗！' + e));
                Database.rollback(sp);
            }
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'入庫してください！'));
        }
        
        return null;
    }
    
    public PageReference cancel()
    {
        this.productList = getProductList();
        
        return null;
    }
}