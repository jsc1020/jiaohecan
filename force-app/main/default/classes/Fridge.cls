public class Fridge implements KitchenUtility {
	public String modelNumber;
    public Integer numberInStock;
    
    public void setModelNumber(String theModelNumber) {
    	modelNumber = theModelNumber;
    }
    public String getModelNumber() {
    	return modelNumber;
    }
    
    public void setNumberInStock(Integer theNumberInStock) {
    	numberInStock = theNumberInStock;
    }
    public Integer getNumberInStock() {
    	return numberInStock;
    }
    
    public void updateStock(Integer justSold) {
    	numberInStock = numberInStock - justSold;
    }
}