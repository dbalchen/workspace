var allWidgets=[
                ["Batch 1 Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01BCH01","1","App"],
                ["Batch 1 Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01BCH01","1","FS"],
                ["Batch 2 Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01BCH02","2","App"],
                ["Batch 2 Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01BCH02","2","FS"],
                ["Batch 3 Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01BCH03","3","App"],
                ["APRM Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=AppsA&MARKET=KPR01BCH03","3","App"],
                ["Batch 3 Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01BCH03","3","FS"],
                ["Batch 4 Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01BCH04","4","App"],
                ["ARCM Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=AppsC&MARKET=KPR01BCH04","4","App"],
                ["Batch 4 Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01BCH04","4","FS"],
                ["Batch 5 Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01BCH05","4","FS"],
                ["EBI Operations Apps","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01OPRMN","5","App"],
                ["EBI Operations Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01OPRMN","5","FS"],
                ["EBI Business Filesystem","batch","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EBI01","5","FS"],            
                ["ES1 Filesystem","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EVE01","1","FS"],
                ["ES2 Filesystem","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EVE02","1","FS"],
                ["ES3 Filesystem","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EVE03","1","FS"],
                ["ES4 Filesystem","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EVE04","1","FS"],
                ["ES5 Filesystem","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EVE05","1","FS"],
                ["ES6 Filesystem","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Filesystem&MARKET=KPR01EVE06","1","FS"],
                ["ES1 Apps","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01EVE01","2","App"],
                ["ES2 Apps","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01EVE02","2","App"],
                ["ES3 Apps","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01EVE03","2","App"],
                ["ES4 Apps","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01EVE04","2","App"],
                ["ES5 Apps","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01EVE05","2","App"],
                ["ES6 Apps","event","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Apps&MARKET=KPR01EVE06","2","App"],
                ["AC1 Control Status","ac1","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Ac1control&MARKET=KPR01BCH01","1","addWidgetAC1"],
                ["ARCM SMM1 File Status","ac1","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=ARCM_SMM1&MARKET=KPR01BCH03","1","addWidgetARCMSMM1"],
                ["Ongoing Rerate Backlog","other","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=Rerate_backlog&MARKET=KPR01BCH02","1","addWidgetRaterBacklog"],
                ["Overage Notification Count","other","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=OvpCount&MARKET=KPR01OPRMN","1","addWidgetOVP"],
                ["APRM AC Control Status","ac1","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=APRM_AC&MARKET=KPR01BCH03","1","addWidgetAPRMAC"]                        
                ];



function addWidget($title,$tab,$url,$col,$type){
	var errors=0;
	return $.ajax({
		url: $url,
		type: 'GET',
		async: false,
		success: function(data) {
			if(data.length<3){return;}
			var jsonData = jQuery.parseJSON(data);
			if($type == 'App'){
				var values = makeAppTable(jsonData);
			}else if($type == 'FS'){
				var values = makeFsTable(jsonData);
			}
			var tbl=values[0];
			var errors=values[1];
			var headerColor='green';
			if(tbl.indexOf("red")>0){
				headerColor='red';
				$("#" + $tab + "-tab").css("background","red");
			}
			if(errors>0){
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title +  '<div id=circle>' + errors +'</div></h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tbl + '</p></center></div></li>');
			}else{
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title +  '</h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tbl + '</p></center></div></li>');
			}
		}
	});
}

function makeAppTable($data){
	var errors =0;
	var tbl='<table border=1><tr><th>App</th><th>Status</th><th>Started</th></tr>';
	for (var i=0;i<$data.apps.length;i++){
		var app = $data.apps[i];
		if(app.status == 'Up'){
			tbl += '<tr style="color:green;"><td>' + app.name + '</td><td>' + app.status + '</td><td>' + app.start + '</td></tr>';
		}else if (app.required == 'N'){
			tbl += '<tr style="color:orange;"><td>' + app.name + '</td><td>' + app.status + '</td><td></td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + app.name + '</td><td>' + app.status + '</td><td></td></tr>';
		}
	}
	tbl += "</table>";

	return [tbl,errors];
}

function makeFsTable($data){
	var errors =0;
	var tbl='<table border=1><tr><th>Folder</th><th>Size</th><th>Used</th><th>Available</th><th>% Used</th></tr>';
	for (var i=0;i<$data.dirs.length;i++){
		var dir = $data.dirs[i];
		if(dir.peruse.substr(0,dir.peruse.indexOf("%")) <90){
			tbl += '<tr style="color:green;"><td>' + dir.map + '</td><td>' + dir.size + '</td><td>' + dir.used + '</td><td>' + dir.avail + '</td><td>' + dir.peruse + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + dir.map + '</td><td>' + dir.size + '</td><td>' + dir.used + '</td><td>' + dir.avail + '</td><td>' + dir.peruse + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

function makeAC1TableFiles($data){
	var errors =0;
	var tbl='<table border=1><tr><th>Format</th><th>Status</th><th>Current Program</th><th>Next Program</th><th>Creation Date</th><th>Update Date</th><th>Count</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		var today = new Date;
		var todayCompare = today.getFullYear() +''+ ('0' + (today.getMonth()+1)).slice(-2) +''+ ('0' + today.getDate()).slice(-2);
		if((row.file_status == 'RD')){
			tbl += '<tr style="color:green;"><td>' + row.file_format + '</td><td>' + row.file_status + '</td><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.create_date + '</td><td>' + row.update_date + '</td><td>' + row.count + '</td></tr>';
		}else{
			if((row.file_status == 'IU')){
				tbl += '<tr style="color:orange;"><td>' + row.file_format + '</td><td>' + row.file_status + '</td><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.create_date + '</td><td>' + row.update_date + '</td><td>' + row.count + '</td></tr>';
			}else{		
				if((row.file_status == 'AF')){
					errors++;
					tbl += '<tr style="color:red;"><td>' + row.file_format + '</td><td>' + row.file_status + '</td><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.create_date + '</td><td>' + row.update_date + '</td><td>' + row.count + '</td></tr>';
				}

			}
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

function makeAC1TableData($data){
	var errors =0;
	var tbl='<table border=1><tr><th>Count</th><th>Date</th><th>Status</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		var today=new Date;
		var todayCompare = today.getFullYear() +''+ ('0' + (today.getMonth()+1)).slice(-2) +''+ ('0' + today.getDate()).slice(-2);
		if((row.file_status != 'AF') && (row.date == todayCompare)){
			tbl += '<tr style="color:green;"><td>' + row.count + '</td><td>' + row.date + '</td><td>' + row.file_status + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + row.count + '</td><td>' + row.date + '</td><td>' + row.file_status + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

/* Adds all of the APRM Ac1 tables to the widget */
function addWidgetAPRMAC($title,$tab,$url,$col){
	var errors =0;
	return $.ajax({
		url: $url,
		type: 'GET',
		async: false,
		success: function(data) {
			var jsonData = jQuery.parseJSON(data);
			var fileValues = makeAPRMTableFiles(jsonData.file_status);
			var ratersValues= makeAPRMACTableRater(jsonData.rater_status);
			var errorsValues = makeAPRMTableErrors(jsonData.errors);
			var tblFile = fileValues[0];
			var tblRaters = ratersValues[0];
			var tblErrors= errorsValues[0];
			errors = fileValues[1] + ratersValues[1] + errorsValues[1];
			var tblStuckProcess  ='';
			if(jsonData.stuck.length > 0){
				stuckValues = makeAPRMTableStuckProcess(jsonData.stuck);
				tblStuckProcess = stuckValues[0];
				errors+=stuckValues[1];
			}
			var headerColor='green';
			if(tblFile.indexOf("red")>0 || tblRaters.indexOf("red")>0 || tblErrors.indexOf("red")>0 || tblStuckProcess.indexOf("red")>0){
				headerColor='red';
				$("#ac1-tab").css("background","red");
			}
			if(errors > 0){
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '<div id=circle>' + errors +'</div></h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tblFile + '</p><br><h3>Rater Status</h3><p>' + tblRaters + '</p><br><h3>APRM Errors</h3><p>' + tblErrors+ '</p>' + tblStuckProcess + '</center></div></li>');
			}else {
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '</h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tblFile + '</p><br><h3>Rater Status</h3><p>' + tblRaters + '</p><br><h3>APRM Errors</h3><p>' + tblErrors+ '</p>' + tblStuckProcess + '</center></div></li>');

			}
		}
	});
}

function addWidgetAC1($title,$tab,$url,$col){
	var errors = 0;
	return $.ajax({
		url: $url,
		type: 'GET',
		async: false,
		success: function(data) {
			if(data.length<3){return;}
			var jsonData = jQuery.parseJSON(data);
			var fileValues = makeAC1TableFiles(jsonData.file_status);
			var dataValues = makeAC1TableData(jsonData.data_status);
			var tblFile = fileValues[0];
			var tblData = dataValues[0];
			errors = fileValues[1] + dataValues[1];
			var headerColor='green';
			if(tblFile.indexOf("orange")>0 || tblData.indexOf("orange")>0){
				headerColor='orange';
				$("#" + $tab + "-tab").css("background","#FF6633");
			}
			if(tblFile.indexOf("red")>0 || tblData.indexOf("red")>0){
				headerColor='red';
				$("#ac1-tab").css("background","red");
			}
			if(errors>0){
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '<div id=circle>' + errors +'</div></h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tblFile + '</p><br><h3>UFF File Status</h3><p>' + tblData + '</p></center></div></li>');
			}else{
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '</h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tblFile + '</p><br><h3>UFF File Status</h3><p>' + tblData + '</p></center></div></li>');

			}
		}
	});
}


/* Shows detailed view of the rater status, red if AF or if older than today */
function makeAPRMACTableRater($data){
	var errors =0;
	var tbl='<table border=1><tr><th>Current Program</th><th>Next Program</th><th>File Status</th><th>Count</th><th>Rater</th><th>File Alias</th><th>Date</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		var today=new Date;
		var todayCompare = today.getFullYear() +''+ ('0' + (today.getMonth()+1)).slice(-2) +''+ ('0' + today.getDate()).slice(-2);
		if((row.file_status != 'AF') && (row.date == todayCompare)){
			tbl += '<tr style="color:green;"><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.file_status + '</td><td>' + row.count + '</td><td>' + row.quantity + '</td><td>' + row.file_alias + '</td><td>' + row.date + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.file_status + '</td><td>' + row.count + '</td><td>' + row.quantity + '</td><td>' + row.file_alias + '</td><td>' + row.date + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

/* Adds all of the ARCM SMM1 table to the widget */
function addWidgetARCMSMM1($title,$tab,$url,$col){
	var errors = 0;
	return $.ajax({
		url: $url,
		type: 'GET',
		async: false,
		success: function(data) {
			var jsonData = jQuery.parseJSON(data);
			var fileValues = makeARCMSMM1TableFiles(jsonData.file_status);
			var errorsValues = makeARCMSMM1TableErrors(jsonData.errors);

			var tblFile = fileValues[0];		
			var tblErrors = errorsValues[0];

			var headerColor='green';
			if(tblFile.indexOf("orange")>0){
				headerColor='orange';
				$("#ac1-tab").css("background","orange");
			}

			var sys_creation_date = new Date(fileValues[1]);
			var file_status = new Date(fileValues[2]);
			var sla_5_day = new Date;
			sla_5_day.setDate(sla_5_day.getDate() - 5);

			if(sys_creation_date < sla_5_day && file_status == 'EXPECTED'){
				headerColor='red';
				$("#ac1-tab").css("background","red");
			}else if (sys_creation_date > sla_5_day && file_status == 'EXPECTED'){
				headerColor='orange';
				$("#ac1-tab").css("background","orange");
			}else if (file_status == 'DONE'){
				headerColor='green';
				$("#ac1-tab").css("background","green");
			}

			if(errors > 0){
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '<div id=circle>' + errors +'</div></h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tblFile + '</center></div></li>');
			}else {
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '</h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tblFile + '</center></div></li>');
			}
		}
	});
}

/* Shows the Files processing through ACRM */
function makeARCMSMM1TableFiles($data){
	var errors =0;
	var tbl='<table border=1><tr><th>File Name</th><th>Sys Creation Date</th><th>File Status</th><th>File Type</th><th>Sender</th><th>Recipient</th><th>File Content</th><th>Corresponding File Name</th><th>Events Count</th><th>Total Value</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		var today = new Date;
		var sys_creation_date = new Date(row.create_date);
		var sla_5_day = new Date;
		sla_5_day.setDate(sla_5_day.getDate() - 5);
		if(sys_creation_date < sla_5_day){
			tbl += '<tr style="color:red;"><td>' + row.file_name + '</td><td>' + row.create_date + '</td><td>' + row.file_status + '</td><td>' + row.file_type + '</td><td>' + row.sender + '</td><td>' + row.recipient + '</td><td>' + row.file_content + '</td><td>' + row.corresponding_file_name + '</td><td>' + row.events_count + '</td><td>' + row.total_value + '</td></tr>';
		}else if (row.file_status == 'EXPECTED'){
			tbl += '<tr style="color:orange;"><td>' + row.file_name + '</td><td>' + row.create_date + '</td><td>' + row.file_status + '</td><td>' + row.file_type + '</td><td>' + row.sender + '</td><td>' + row.recipient + '</td><td>' + row.file_content + '</td><td>' + row.corresponding_file_name + '</td><td>' + row.events_count + '</td><td>' + row.total_value + '</td></tr>';
		}else{
			tbl += '<tr style="color:green;"><td>' + row.file_name + '</td><td>' + row.create_date + '</td><td>' + row.file_status + '</td><td>' + row.file_type + '</td><td>' + row.sender + '</td><td>' + row.recipient + '</td><td>' + row.file_content + '</td><td>' + row.corresponding_file_name + '</td><td>' + row.events_count + '</td><td>' + row.total_value + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

/* Shows the ARCM Errors, no red condition */
function makeARCMSMM1TableErrors($data){
	var errors =0;
	var tbl='<table border=1><tr><th>File Name</th><th>Count</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		if(1){
			tbl += '<tr style="color:green;"><td>' + row.file_name + '</td><td>' + row.events_count + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + row.file_name + '</td><td>' + row.events_count + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

/* Shows the Files processing through APRM, red if AF*/
function makeAPRMTableFiles($data){
	var errors =0;
	var tbl='<table border=1><tr><th>Current Program</th><th>Next Program</th><th>File Status</th><th>Count</th><th>Quantity</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		if(row.file_status !='AF'){
			tbl += '<tr style="color:green;"><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.file_status + '</td><td>' + row.count + '</td><td>' + row.quantity + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + row.curpgm + '</td><td>' + row.nxtpgm + '</td><td>' + row.file_status + '</td><td>' + row.count + '</td><td>' + row.quantity + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

/* Shows the APRM Errors, no red condition */
function makeAPRMTableErrors($data){
	var errors =0;
	var tbl='<table border=1><tr><th>Errors</th><th>Count</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		if(1){
			tbl += '<tr style="color:green;"><td>' + row.name + '</td><td>' + row.count + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:red;"><td>' + row.name + '</td><td>' + row.count + '</td></tr>';
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}

/* Check for stuck APRM process.  Flags as read if quantity is greater than 1.4M */
function makeAPRMTableStuckProcess($data){
	var errors =0;
	var tbl='<br><h3>APRM Backlog</h3><p><table border=1><tr><th>AC Table</th><th>Next Program</th><th>File Status</th><th>Count</th><th>Quantity</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		/*must be under 15M for UPRTUSAGE and under 10M for all other */
		if((row.quantity < 15000000 && row.nxt_pgm_name =='UPRTUSAGE') || row.quantity < 1000000){
			tbl += '<tr style="color:green;"><td>' + row.ac + '</td><td>' + row.nxt_pgm_name + '</td><td>' + row.file_status + '</td><td>' + row.count + '</td><td>' + row.quantity + '</td></tr>';
		}else{
			errors++;
			tbl += '<tr style="color:orange;"><td>' + row.ac + '</td><td>' + row.nxt_pgm_name + '</td><td>' + row.file_status + '</td><td>' + row.count + '</td><td>' + row.quantity + '</td></tr>';
		}
	}
	tbl += "</table></p>";	
	return [tbl,errors];
}

function addWidgetAEM($title,$tab,$url,$col){
	oTable=$("#aemTable").dataTable( {
		"fnInitComplete": function () {
			// Add a select menu for each TH element in the table footer
			$(".filter").each( function ( i ) {
				this.innerHTML = fnCreateSelect( oTable.fnGetColumnData(i) );
				$('select', this).change( function () {
					oTable.fnFilter( $(this).val(), i );
					$(".total").html(getTotalCount(oTable.fnGetColumnData(2)));
				} );
				$('#dateSel').val=('1');
			} );
			$(".total").html(getTotalCount(oTable.fnGetColumnData(2)));
		},
		"bProcessing": true,
		"sDom": 'rt<"clear">',
		"iDisplayLength": 500,
		"aaSorting": [[ 1, "desc" ],[0,"asc"]],	
		"aoColumns": [ null,{"sType":"date-dd-mmm-yy"},null],
		"sAjaxSource": $url
	} );
}

function addWidgetRaterBacklog($title,$tab,$url,$col){
	var errors=0;
	return $.ajax({
		url: $url,
		type: 'GET',
		async: false,
		success: function(data) {
			var jsonData = jQuery.parseJSON(data);
			var values = makeRaterBacklogTable(jsonData.cycles);
			var tbl = values[0];
			errors = values[1];
			var headerColor='green';
			if(tbl.indexOf("orange")>0){
				headerColor='orange';
				$("#" + $tab + "-tab").css("background","#FF6633");
			}
			if(tbl.indexOf("red")>0){
				headerColor='red';
				$("#" + $tab + "-tab").css("background","red");
			}
			if(errors>0){
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '<div id=circle>' + errors +'</div></h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tbl + '</p></center></div></li>');
			}else{
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '</h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tbl + '</p></center></div></li>');				
			}
		}
	});
}

function makeRaterBacklogTable($data){
	var errors=0;
	var tbl='<table border=1><tr><th>Cycle</th><th>Instance</th><th>Subscribers left</th><th>Number of retries</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		if((row.retries < 3) || (row.retries==3 && row.count <60)){
			tbl += '<tr style="color:green;"><td>' + row.cycle_code + '</td><td>' + row.cycle_instance + '</td><td>' + row.count + '</td><td>' + row.retries + '</td></tr>';
		}else{
			if(row.count >= 100){
				errors++;
				tbl += '<tr style="color:red;"><td>' + row.cycle_code + '</td><td>' + row.cycle_instance + '</td><td>' + row.count + '</td><td>' + row.retries + '</td></tr>';
			}else{
				tbl += '<tr style="color:orange;"><td>' + row.cycle_code + '</td><td>' + row.cycle_instance + '</td><td>' + row.count + '</td><td>' + row.retries + '</td></tr>';
			}
		}
	}
	tbl += "</table>";	
	return [tbl,errors];
}



function addWidgetOVP($title,$tab,$url,$col){
	var errors=0;
	return $.ajax({
		url: $url,
		type: 'GET',
		async: false,
		success: function(data) {
			var jsonData = jQuery.parseJSON(data);
			var values = makeOvpTable(jsonData.OVP);
			var tbl = values[0];
			errors = values[1];
			var headerColor='green';
			if(tbl.indexOf("orange")>0){
				headerColor='orange';
				$("#" + $tab + "-tab").css("background","#FF6633");
			}
			if(tbl.indexOf("red")>0){
				headerColor='red';
				$("#" + $tab + "-tab").css("background","red");
			}
			if(errors>0){
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '<div id=circle>' + errors +'</div></h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tbl + '</p></center></div></li>');
			}else{
				$("#column" + $col + "-" + $tab).append('<li class="widget color-' + headerColor + '"><div class="widget-head"><h3>' + $title + '</h3></div><div class="widget-content"><center><p><h4 style="text-align:center">' + jsonData.time + '</h4>' + tbl + '</p></center></div></li>');				
			}
		}
	});
}

function makeOvpTable($data){
	var errors=0;
	var tbl='<table border=1><tr><th>Total</th><th>100%</th><th>75%</th><th>Disclamer</th><th>Balance</th></tr>';
	for (var i=0;i<$data.length;i++){
		var row = $data[i];
		tbl += '<tr style="color:green;"><td>' + row.total_records + '</td><td>' + row.recs_100 + '</td><td>' + row.recs_75 + '</td><td>' + row.disclamir + '</td><td>' + row.balance + '</td></tr>';			
	}
	tbl += "</table>";	
	return [tbl,errors];
}


function clearColumn(i,cleared){	
	var needToClear=1;
	for(var x=0;x<cleared.length;x++){
		if(cleared[x] == "#column" + allWidgets[i][3] + "-" + allWidgets[i][1]){
			needToClear=0;
		}
	}
	if(needToClear){
		$("#column" + allWidgets[i][3] + "-" + allWidgets[i][1]).empty();
	}
	cleared[i]="#column" + allWidgets[i][3] + "-" + allWidgets[i][1];
}

function loadWidgets(){
	$("#batch-tab").css("background","green");
	$("#event-tab").css("background","green");
	$("#ac1-tab").css("background","green");	
	$("#other-tab").css("background","green");
	var cleared = [];
	for(var i=0;i<allWidgets.length;i++){
		clearColumn(i,cleared);
		if(allWidgets[i][4] == "App" || allWidgets[i][4] == 'FS'){
			//addWidgetApp(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3]);
			addWidget(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3],allWidgets[i][4]);
		}else if (allWidgets[i][4] == "addWidgetAC1"){
			addWidgetAC1(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3]);
		}else if (allWidgets[i][4] == "addWidgetARCMSMM1"){
			addWidgetARCMSMM1(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3]);		
		}else if (allWidgets[i][4] == "addWidgetAPRMAC"){
			addWidgetAPRMAC(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3]);
		}else if (allWidgets[i][4] == "addWidgetRaterBacklog"){
			addWidgetRaterBacklog(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3]);
		}else if (allWidgets[i][4] == "addWidgetOVP"){
			addWidgetOVP(allWidgets[i][0],allWidgets[i][1],allWidgets[i][2],allWidgets[i][3]);
		}else{
			console.log("Error " + allWidgets[i][4] + " not found");
		}
	}
}


$(function() {	 
	$("#batch-tab").css("background","green");
	$("#event-tab").css("background","green");
	$("#ac1-tab").css("background","green");
	$("#aem-tab").css("background","green");
	$("#other-tab").css("background","green");
	$( "#tabs" ).tabs({ collapsible: true});
	$( "#tabs" ).bind('tabsactivate',function(event, ui){
		switch(ui.newTab.index()){
		case 0:
			$("#headtext").html('EPS Monitors - Batch');
			break;
		case 1:
			$("#headtext").html('EPS Monitors - Event Servers');
			break;
		case 2:
			$("#headtext").html('EPS Monitors - AC1 Control');
			break;
		case 3:
			$("#headtext").html('EPS Monitors - AEM');
			break;
		case 4:
			$("#headtext").html('EPS Monitors - Other');
			break;
		}
	});

	loadWidgets();
	addWidgetAEM("AEM Error Counts","aem","http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=AEMErrorCount&MARKET=KPR01OPRMN","1");
	setInterval(function(){loadWidgets();},60000);

});

