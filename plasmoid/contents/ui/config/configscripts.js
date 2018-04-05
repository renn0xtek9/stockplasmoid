function PopulateOnvistaUrlModel(onvistaurlmodel,onvistaurllist)
{
	//The model that there is in the config!!
	onvistaurlmodel.clear();
	var json=JSON.parse(onvistaurllist);
	for (var key in Object.keys(json))
	{
		onvistaurlmodel.append(json[key]);
	}
}
function PopulateOnvistaItemModel(itemmodel,onvistaurllist)
{
	//The model that we have in the main view !!
	itemmodel.clear();
	console.log("Now populating the main model");
	var json=JSON.parse(onvistaurllist);
	for (var key in Object.keys(json))
	{
		itemmodel.addItem(json[key]["stock_url"],json[key]["stock_name"]);
	}
}
function DressNewListOfOnvistaModelData(onvistaurlmodel)
{
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
	return str;
}

