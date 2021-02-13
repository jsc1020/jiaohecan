public class A_Test2 {
/*
{!REQUIRESCRIPT("/soap/ajax/41.0/apex.js")} 
{!REQUIRESCRIPT("/soap/ajax/41.0/connection.js")} 
var masterchange = new sforce.SObject("F_Webkaiinmaster__c"); 
masterchange.id="{!F_Webkaiinmaster__c.Id}"; 
masterchange.f_Initialpassword__c= true; 
if(window.confirm('{!F_Webkaiinmaster__c.f_Houjinmei_jigyousyamei__c}のパスワードを初期化します。よろしいですか？')){
var result=sforce.connection.update([masterchange]);
window.location.reload();
}

 */
}