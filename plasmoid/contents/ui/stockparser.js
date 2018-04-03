function BuildUrl(symbol,apikey)
{
	var theUrl="https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol="+symbol+"&interval=1min&apikey="+apikey;
// 	console.log(theUrl);
	return theUrl;
}
function httpGetAsync(symbol, apikey,callback)
{
	var theUrl=BuildUrl(symbol,apikey);
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.onreadystatechange = function() { 
		if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
		callback(xmlHttp.responseText,symbol);
	}
	xmlHttp.open("GET", theUrl, true); // true for asynchronous 
	xmlHttp.send(null);
}
function getDictOfStockCodesAndNames(list_of_tags)
{
	var code_names_dict={};
	var stringarray=list_of_tags.split(';');	
	var arraylength=stringarray.length;
	for (var i = 0; i < arraylength; i++) {
		var nameandcode=stringarray[i].split(':');
		code_names_dict[nameandcode[0]]=nameandcode[1];
	}
	return code_names_dict;	
}
function getListofStockCodes(list_of_tags)
{
	return Object.keys(getDictOfStockCodesAndNames(list_of_tags));
}
function AlphaVantageTimeSeriesDailyParse(jsonanswer)
{		
	try{
		var obj=JSON.parse(jsonanswer)["Time Series (Daily)"];
		var key_last_date=Object.keys(obj)[0];
		var key_prev_date=Object.keys(obj)[1];
		var firstelem=obj[key_last_date];
		var secondelem=obj[key_prev_date];
		var currentvalue=firstelem["4. close"];
		var value_at_last_close=secondelem["4. close"];
		var increase=currentvalue/value_at_last_close*100.0-100.0
	}
	catch(e){
		console.log("Error while parsing answer");
		var currentvalue="";
		var value_at_last_close="";
		var increase=0.0;
	}
	var ret=[currentvalue,currentvalue/value_at_last_close,increase];
	return ret;
}
function FormatPrice(price){
	var formatedprice=parseFloat(price).toFixed(2);
	return formatedprice
}
function isIncreaseing(increase)
{
	if (increase>0)
		return true
	return false
}











function callback(response)
{
	console.log("callback");
	
	var parsed=new DOMParser.parseFromString(response,'text/html');
	
	
// 	var el = document.createElement( 'html' );
// 	el.innerHTML = response;
// // 
// 	el.getElementsByTagName( 'row' );
	
	
	
	return 0;
	
	
	var child = response.getElementsByClassName('row')[0];
	console.log(child);
// 	return 0;
// 	var bordellength=bordel.length;
// 	console.log("shit");
// 	console.log("There are"+bordellength+" elemetns");
}
function httpGetAsync2(callback)
{
	var theUrl="https://www.onvista.de/derivate/optionsscheine/SG-CALL-TESLA-MOTORS-380-0-01-17-12-21-DE000SG73UZ6?custom=c"
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.onreadystatechange = function() { 
		if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
		callback(xmlHttp.responseText);
	}
	xmlHttp.open("GET", theUrl, true); // true for asynchronous 
	xmlHttp.responseType='document'
	xmlHttp.send(null);
}







