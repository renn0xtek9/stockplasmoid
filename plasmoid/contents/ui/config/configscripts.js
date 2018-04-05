function PopulateOnvistaUrlModel(onvistaurlmodel,onvistaurllist)
{
	//The model that there is in the config!!
	console.log("Now populating");
	onvistaurlmodel.clear();
	
	
	console.log("Analyzeing the urllist");
	var json=JSON.parse(onvistaurllist);
// 	console.log("There are "+ielem+"entries");
	console.log(Object.keys(json));
	for (var key in Object.keys(json))
	{
		console.log("Element" +key);
		onvistaurlmodel.append(json[key]);
// 		console.log(json[key]["stock_name"]);
// 		console.log(json[key]["stock_url"]);
	}
	
	
// 	onvistaurlmodel.append({"stock_name":"Warrant Tesla","stock_url":"https://www.onvista.de/derivate/optionsscheine/SG-CALL-TESLA-MOTORS-380-0-01-17-12-21-DE000SG73UZ6?custom=c"});
// 	onvistaurlmodel.append({"stock_name":"Warrant combank","stock_url":"https://www.onvista.de/derivate/optionsscheine/COMMERZBANK-CALL-DEUTSCHE-BOERSE-40-0-1-13-06-18-DE000CE4R7X6"});
}
function PopulateOnvistaItemModel(itemmodel,onvistaurllist)
{
	//The model that we have in the main view !!
	console.log("Now populating the main model");
	var json=JSON.parse(onvistaurllist);
	for (var key in Object.keys(json))
	{
// 		console.log("Element" +key);
// 		onvistaurlmodel.append(json[key]);
		itemmodel.addItem(json[key]["stock_url"],json[key]["stock_name"]);
	}
}
function DressNewListOfOnvistaModelData(onvistaurlmodel)
{
	console.log("Dressing new list");
	
	console.log("There are "+onvistaurlmodel.count+" elements");
	var str="{\n";
	for (var i=0;i< onvistaurlmodel.count;i++)
	{
		var elem=onvistaurlmodel.get(i);
		str=str+"\""+i+"\":\n"+"\t{\"stock_name\":\""+elem.stock_name+"\",\n\t\"stock_url\":\""+elem.stock_url+"\"}";
		if (i<onvistaurlmodel.count-1)
		{
			str=str+",";
		}
		str=str+"\n";
	}
	str+='}';
	console.log(str);
	return str;
}

