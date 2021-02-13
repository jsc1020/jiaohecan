public class SubClass extends SuperClass{
    public override void printName(){
        super.printName();
        System.debug('But you can call me ' + super.getFirstName());
    }
}