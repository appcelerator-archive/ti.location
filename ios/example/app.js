Ti.Location  = require('ti.location');

var blur = Ti.UI.createButton({title:'blur'});
var clear = Ti.UI.createButton({title:'clear'});

var win = Ti.UI.createWindow({
	backgroundColor:'#ccc',
	rightNavButton:blur,
	leftNavButton:clear
});

var textField = Ti.UI.createTextArea({
	top:210,
	bottom:10,
	left:10,
	right:10,
	value:'',
	backgroundColor:'white'
});

win.add(textField);
var manager = Ti.Location.createLocationManager();

blur.addEventListener('click', function(){
	textField.blur();
});
clear.addEventListener('click', function(){
//	textField.value = '';
	manager.stopAll();
});


var Log = function(a){
	Ti.API.info(a);
	textField.value = textField.value+'\n'+a;
};

var MyButton = function(a){
	a = a || {};
	a.width = 145;
	a.height = 22;
	return Ti.UI.createButton(a);
};

var btn; /* :) */

// ------------------------------- significant change -------------------------------
win.add(btn = MyButton({
	left:10,
	top:20,
	title:'Start significant'
}));
btn.addEventListener('click', function(){
	Log('startMonitoringSignificantLocationChanges');
	manager.startMonitoringSignificantLocationChanges();
});

win.add( btn = MyButton({
	right:10,
	top:20,
	title:'Stop significant'
}));
btn.addEventListener('click', function(){
	Log('stopMonitoringSignificantLocationChanges');
	manager.stopMonitoringSignificantLocationChanges();
});

// ------------------------------- Normal location change -------------------------------
win.add( btn = MyButton({
	left:10,
	top:60,
	title:'Start normal'
}));
btn.addEventListener('click', function(){
	Log('startUpdatingLocation');
	manager.startUpdatingLocation();
});

win.add( btn = MyButton({
	right:10,
	top:60,
	title:'Stop normal'
}));
btn.addEventListener('click', function(){
	Log('stopUpdatingLocation');
	manager.stopUpdatingLocation();
});

// ------------------------------- Heading Change -------------------------------
win.add( btn = MyButton({
	left:10,
	top:100,
	title:'Start heading'
}));
btn.addEventListener('click', function(){
	Log('startUpdatingHeading');
	manager.startUpdatingHeading();
});

win.add( btn = MyButton({
	right:10,
	top:100,
	title:'Stop heading'
}));
btn.addEventListener('click', function(){
	Log('stopUpdatingHeading');
	manager.stopUpdatingHeading();
});

// ------------------------------- create the region & get the region -------------------------------
win.add( btn = MyButton({
	left:10,
	top:140,
	title:'Create Region'
}));
var r;
btn.addEventListener('click', function(){
	Log('manager.createRegion({...})');
	r = Ti.Location.createRegion({
		latitude:37.388657,
		longitude:-122.050831,
		distance:10,
		identifier:'AppceleratorHeadQuarters'
	});
});

win.add( btn = MyButton({
	right:10,
	top:140,
	title:'Get Region'
}));
btn.addEventListener('click', function(){
	Log('manager.allRegions');
	var array = manager.allRegions();
	alert(array);
	Log(array);
		// var len = array.length;
		// for(var i = 0; i < len; i ++){
		// 	alert(array[i]);
		// }
});

// ------------------------------- start monitoring for the region -------------------------------
win.add( btn = MyButton({
	left:10,
	top:180,
	title:'Start Monitoring'
}));
btn.addEventListener('click', function(){
	Log('startMonitoringForRegion');
	manager.startMonitoringForRegion(r);
});

win.add( btn = MyButton({
	right:10,
	top:180,
	title:'Stop Monitoring'
}));
btn.addEventListener('click', function(){
	Log('stopMonitoringForRegion');
	manager.stopMonitoringForRegion(r);
	r = null;
//	r.destroyProxy();
});

win.open({modal:true});

// ------------------------------- create notification -------------------------------
var notification = Ti.Location.createNotification();

// ------------------------------- event listeners -------------------------------
manager.addEventListener(Ti.Location.LOCATION_UPDATE, function(e){
	notification.showNotification({
		title:'LOCATION_UPDATE'
	});
	Log(e);
});
manager.addEventListener(Ti.Location.ENTER_REGION, function(e){
	Log(e);
	// show the notification for entering the region
	notification.showNotification({
		title:'ENTER_REGION'
	});
});
manager.addEventListener(Ti.Location.EXIT_REGION, function(e){
	Log(e);
	//	show the notification for exiting the region
	notification.showNotification({
		title:'EXIT_REGION',
		viewButton:'Hello World'
	});
});
manager.addEventListener(Ti.Location.MONITOR_REGION, function(e){
	notification.showNotification({
		title:'MONITOR_REGION'
	});
	Log(e);
});
manager.addEventListener(Ti.Location.REGION_MONITOR_FAIL, function(e){
	Log(e);
});
manager.addEventListener(Ti.Location.HEADING, function(e){
	Log(e);
});
manager.addEventListener(Ti.Location.ERROR, function(e){
	Log(e);
});

// these are the event listener constants
Log(Ti.Location.LOCATION_UPDATE);
Log(Ti.Location.ENTER_REGION);
Log(Ti.Location.EXIT_REGION);
Log(Ti.Location.MONITOR_REGION);
Log(Ti.Location.REGION_MONITOR_FAIL);
Log(Ti.Location.HEADING);
Log(Ti.Location.ERROR);

// is this supported?
Log('Is supported: '+ (manager.isSupported() ? 'true' : 'false'));
