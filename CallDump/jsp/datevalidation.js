	


<script language = "Javascript">
/**
 * DHTML date validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */
// Declaring valid date character, minimum year and maximum year
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		return false
	}
        return true
}

function ValidateDate(){
     var smonth = document.submitCallDumpForm.startmonth.value; 
     var sday = document.submitCallDumpForm.startday.value;
     var syear = document.submitCallDumpForm.startyear.value;
     var emonth = document.submitCallDumpForm.endmonth.value; 
     var eday = document.submitCallDumpForm.endday.value;
     var eyear = document.submitCallDumpForm.endyear.value;

     var oneyearago = new Date()
     var startdate = new Date()
     var enddate = new Date()
     var now = new Date()
     var midnight = new Date()

     var sstatus = false;
     var estatus = false;
     sstatus = ValidateStartDate();
     estatus = ValidateEndDate();
     
     var strtlbl = document.getElementById('startdatelabel');
     var endlbl = document.getElementById('enddatelabel');

     if (sstatus == false) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     if (estatus == false) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return estatus;
     }

     startdate.setFullYear(syear,smonth-1,sday);
     enddate.setFullYear(eyear,emonth-1,eday);
     oneyearago.setDate(oneyearago.getDate()-365)
     midnight.setHours(23);
     midnight.setMinutes(59);

     if (startdate>enddate) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     // See if start date is over 1 year old
     if (startdate<oneyearago) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     if (startdate>now) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     if (enddate>now) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     if (enddate>midnight) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     if (startdate>midnight) {
          strtlbl.style.backgroundColor='#FF0000'
          endlbl.style.backgroundColor='#FF0000'
          return sstatus;
     }
     strtlbl.style.backgroundColor='#00FF00'
     endlbl.style.backgroundColor='#00FF00'
}
function ValidateStartDate(){
      var month = document.submitCallDumpForm.startmonth.value; 
      var day = document.submitCallDumpForm.startday.value;
      var year = document.submitCallDumpForm.startyear.value;
      var dt = month + "/" + day + "/" + year;
      var status = false;
      status = isDate(dt);
      return status;
 }

function ValidateEndDate(){
      var month = document.submitCallDumpForm.endmonth.value; 
      var day = document.submitCallDumpForm.endday.value;
      var year = document.submitCallDumpForm.endyear.value;
      var dt = month + "/" + day + "/" + year;
      var status = false;
      status = isDate(dt);
      return status;
 }

</script>
