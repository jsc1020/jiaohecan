public class A_Test1 {
/*
{!REQUIRESCRIPT("/soap/ajax/41.0/apex.js")}
{!REQUIRESCRIPT("/soap/ajax/41.0/connection.js")}
var masterchange = new sforce.SObject("F_Masterchange_houjin__c");
masterchange.f_WebKaiinnmaster__c="{!F_Webkaiinmaster__c.Id}";
masterchange.f_status__c= "0";
masterchange.f_Addressactivecheck__c="{!F_Webkaiinmaster__c.f_Activeaddress__c}";
masterchange.f_LoginID__c="{!F_Webkaiinmaster__c.f_LoginID__c}";
masterchange.f_Yagou__c="{!F_Webkaiinmaster__c.f_Yagou__c}";
masterchange.f_Kaiinnstatus__c="{!F_Webkaiinmaster__c.f_Kaiinnstatus__c}";
masterchange.f_Kaisyashuruicode__c="{!F_Webkaiinmaster__c.f_Kaisyashuruicode__c}";
masterchange.f_Kaisyasyuruizengokubun__c="{!F_Webkaiinmaster__c.f_Kaisyasyuruizengokubun__c}";
masterchange.f_Gyousyu_syobunrui__c="{!F_Webkaiinmaster__c.f_Gyousyu_syobunrui__c}";
masterchange.f_Gyousyu_daibunrui__c="{!F_Webkaiinmaster__c.f_Gyousyu_daibunrui__c}";
if("{!F_Webkaiinmaster__c.f_Gyoureki__c}"){
masterchange.f_Gyoureki__c="{!Text(F_Webkaiinmaster__c.f_Gyoureki__c)}";
}
masterchange.f_Jigyoukeitai__c="{!F_Webkaiinmaster__c.f_Jigyoukeitai__c}";
masterchange.f_Jisshitutekisihaisya1_kubun__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya1_kubun__c}";
masterchange.f_Jisshitutekisihaisya1_shimeikanji__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya1_shimeikanji__c}";
masterchange.f_Jisshitutekisihaisya1_jusho__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya1_jusho__c}";
if("{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya1_seinengappi__c}"){
masterchange.f_Jisshitutekisihaisya1_seinengappi__c=new Date('{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya1_seinengappi__c}');
}
masterchange.f_Jisshitutekisihaisya2_kubun__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya2_kubun__c}";
masterchange.f_Jisshitutekisihaisya2_shimeikanji__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya2_shimeikanji__c}";
masterchange.f_Jisshitutekisihaisya2_jusho__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya2_jusho__c}";
if("{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya2_seinengappi__c}"){
masterchange.f_Jisshitutekisihaisya2_seinengappi__c=new Date('{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya2_seinengappi__c}');
}
masterchange.f_Jisshitutekisihaisya3_kubun__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya3_kubun__c}";
masterchange.f_Jisshitutekisihaisya3_shimeikanji__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya3_shimeikanji__c}";
masterchange.f_Jisshitutekisihaisya3_jusho__c="{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya3_jusho__c}";
if("{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya3_seinengappi__c}"){
masterchange.f_Jisshitutekisihaisya3_seinengappi__c=new Date('{!F_Webkaiinmaster__c.f_Jisshitutekisihaisya3_seinengappi__c}');
}
if("{!F_Webkaiinmaster__c.f_Setsuritsubinengappi__c}"){
masterchange.f_Setsuritsubinengappi__c=new Date('{!F_Webkaiinmaster__c.f_Setsuritsubinengappi__c}');
}
masterchange.f_Denwabangou_kanyuusyabangou__c="{!F_Webkaiinmaster__c.f_Denwabangou_kanyuusyabangou__c}";
masterchange.f_Denwabangou_sigaikyokuban__c="{!F_Webkaiinmaster__c.f_Denwabangou_sigaikyokuban__c}";
masterchange.f_Denwabangou_sinaikyokuban__c="{!F_Webkaiinmaster__c.f_Denwabangou_sinaikyokuban__c}";
masterchange.f_Toukikanajyuusyo__c="{!F_Webkaiinmaster__c.f_Toukikanajyuusyo__c}";
masterchange.f_Toukijyuusyo_tatemonomei__c="{!F_Webkaiinmaster__c.f_Toukijyuusyo_tatemonomei__c}";
masterchange.f_Toukijyuusyo_shikutyouson__c="{!F_Webkaiinmaster__c.f_Toukijyuusyo_shikutyouson__c}";
masterchange.f_Toukijyuusyo_tyoubanti__c="{!F_Webkaiinmaster__c.f_Toukijyuusyo_tyoubanti__c}";
masterchange.f_Toukijyuusyo_todoufuken__c="{!F_Webkaiinmaster__c.f_Toukijyuusyo_todoufuken__c}";
masterchange.f_Toukijyuusyo_Yuubinbangou1__c="{!F_Webkaiinmaster__c.f_Toukijyuusyo_yuubinbangou1__c}";
masterchange.f_Toukijyuusyo_Yuubinbangou2__c="{!F_Webkaiinmaster__c.f_Toukijyuusyo_yuubinbangou2__c}";
masterchange.f_Houjinbangou__c="{!F_Webkaiinmaster__c.f_Houjinbangou__c}";
masterchange.f_Houjinmei_jigyousyamei__c="{!F_Webkaiinmaster__c.f_Houjinmei_jigyousyamei__c}";
masterchange.f_Houjinmei_jigyousyamei_kana__c="{!F_Webkaiinmaster__c.f_Houjinmei_jigyousyamei_kana__c}";
masterchange.f_Hontensyozaiti_kana__c="{!F_Webkaiinmaster__c.f_Hontensyozaiti_kana__c}";
masterchange.f_Hontensyozaiti_tatemonomei__c="{!F_Webkaiinmaster__c.f_Hontensyozaiti_tatemonomei__c}";
masterchange.f_Hontensyozaiti_shikutyouson__c="{!F_Webkaiinmaster__c.f_Hontensyozaiti_shikutyouson__c}";
masterchange.f_Hontensyozaiti_tyoubanti__c="{!F_Webkaiinmaster__c.f_Hontensyozaiti_tyoubanti__c}";
masterchange.f_Hontensyozaiti_todoufuken__c="{!F_Webkaiinmaster__c.f_Hontensyozaiti_todoufuken__c}";
masterchange.f_Hontenshozaichi_Yuubinbangou1__c="{!F_Webkaiinmaster__c.f_Hontenshozaichi_Yuubinbangou1__c}";
masterchange.f_Hontenshozaichi_Yuubinbangou2__c="{!F_Webkaiinmaster__c.f_Hontenshozaichi_Yuubinbangou2__c}";
masterchange.f_GaibuIDrenkeiflag__c="{!F_Webkaiinmaster__c.f_GaibuIDrenkeiflag__c}";
if("{!F_Webkaiinmaster__c.f_Yakushokuinnsu__c}"){
masterchange.f_Yakushokuinnsu__c="{!Text(F_Webkaiinmaster__c.f_Yakushokuinnsu__c)}";
}
masterchange.f_Anketokekka__c="{!F_Webkaiinmaster__c.f_Anketokekka__c}";

var result=sforce.connection.create([masterchange]);
var baseurl="{! LEFT($Api.Partner_Server_URL_410, FIND( '/services', $Api.Partner_Server_URL_410))}"; 
if (result[0].getBoolean("success")) {
window.open(baseurl+result[0].id+"/e?retURL=%2F"+result[0].id,"_blank");
}else{
if(result[0].errors && result[0].errors.message){
alert(result[0].errors.message);
}else{
alert(result[0]);
}
}

 */
}