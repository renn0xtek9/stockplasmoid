function BuildUrl(symbol)
{
	var theUrl="https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol="+symbol+"&interval=1min&apikey=4ZM6YOXJ7O7M2JFA";
	return theUrl;
}
function httpGet(symbol)
{
	var theUrl=BuildUrl(symbol)
// 	console.log("URL:")
// 	console.log(theUrl)
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
	xmlHttp.send( null );
	return xmlHttp.responseText;
}
function AlphaVantageTimeSeriesDailyParse(jsonanswer)
{		
	try{
		var obj=JSON.parse(jsonanswer)["Time Series (Daily)"];
		var key_last_date=Object.keys(obj)[0];
		var firstelem=obj[key_last_date];
		var value_at_close=firstelem["4. close"];
		var value_at_open=firstelem["1. open"];
		var increase=value_at_close/value_at_open*100.0-100.0
	}
	catch(e){
		console.log("Error while parsing answer");
		var value_at_close="";
		var value_at_open="";
		var increase=0.0;
	}
	var ret=[value_at_close,value_at_close/value_at_open,increase];
	return ret;
}
function isIncreaseing(increase)
{
	if (increase>0)
		return true
	return false
}


function makeList(id,list_of_tags){
	var stringarray=list_of_tags.split(';');
	var arraylength=stringarray.length;
	for (var i = 0; i < arraylength; i++) {
		var record=AlphaVantageTimeSeriesDailyParse(httpGet(stringarray[i]));
		id.append({"name":stringarray[i],"price":record[0],"increase":record[1],"increasing":isIncreaseing(record[1])});
	}
}

function FormatPrice(price){
	var formatedprice=parseFloat(price).toFixed(2);
	return formatedprice
}
