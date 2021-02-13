public class PieChartController {
    public List<PieWedgeData> getPieData() {
        List<PieWedgeData> dataList = new List<PieWedgeData>();
        dataList.add(new PieWedgeData('Jan', 30));
        dataList.add(new PieWedgeData('Feb', 15));
        dataList.add(new PieWedgeData('Mar', 10));
        dataList.add(new PieWedgeData('Apr', 20));
        dataList.add(new PieWedgeData('May', 20));
        dataList.add(new PieWedgeData('Jun', 5));
        return dataList;
    }
    
    @RemoteAction
    public static List<PieWedgeData> getRemotePieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        data.add(new PieWedgeData('Jan', 30));
        data.add(new PieWedgeData('Feb', 15));
        data.add(new PieWedgeData('Mar', 10));
        data.add(new PieWedgeData('Apr', 20));
        data.add(new PieWedgeData('May', 20));
        data.add(new PieWedgeData('Jun', 5));
        return data;
    }
    
    // Wrapper class
    public class PieWedgeData {
        public String name { get; set; }
        public Integer value{ get; set; }
        public PieWedgeData(String name, Integer value) {
            this.name = name;
            this.value= value;
        }
    }
}