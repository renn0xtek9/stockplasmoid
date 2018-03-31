function makeList(id,list_of_tags){
	var stringarray=list_of_tags.split(';');
	var arraylength=stringarray.length;
	for (var i = 0; i < arraylength; i++) {
		id.append({"name":stringarray[i]});
	}
	console.log(list_of_tags);
}
