<script language="Javascript" type="text/javascript">

function validateCTN(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.ctn.value=="") {
           lbl.style.backgroundColor='#FF0000';
        return;
    } 
    if (isInteger(document.submitCallDumpForm.ctn.value)==false) {
           lbl.style.backgroundColor='#FF0000';
        return;
    } 
    if (document.submitCallDumpForm.ctn.value.length<10) {
           lbl.style.backgroundColor='#FF0000';
        return;
    } 
    lbl.style.backgroundColor='#00FF00';
}

function validateText1(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.text1.value=="") {
        uncheckAll1Box();
        uncheckInd1Box();
        if (isAllTextEmpty()==true) {
           lbl.style.backgroundColor='#FF0000';
        }
        return;
    }
    if (document.submitCallDumpForm.all1.checked==true) {
         lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callingnum1.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callednum1.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.dialeddigits1.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.origclli1.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.termclii1.checked==true) {
        lbl.style.backgroundColor='#00FF00';
        return;
    }
    document.submitCallDumpForm.all1.checked=true;
    lbl.style.backgroundColor='#00FF00';
}

function validateText2(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.text2.value=="") {
        uncheckAll2Box();
        uncheckInd2Box();
        if (isAllTextEmpty()==true) {
           lbl.style.backgroundColor='#FF0000';
        }
        return;
    }
    if (document.submitCallDumpForm.all2.checked==true) {
         lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callingnum2.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callednum2.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.dialeddigits2.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.origclli2.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.termclii2.checked==true) {
        lbl.style.backgroundColor='#00FF00';
        return;
    }
    document.submitCallDumpForm.all2.checked=true;
    lbl.style.backgroundColor='#00FF00';
}

function validateText3(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.text3.value=="") {
        uncheckAll3Box();
        uncheckInd3Box();
        if (isAllTextEmpty()==true) {
           lbl.style.backgroundColor='#FF0000';
        }
        return;
    }
    if (document.submitCallDumpForm.all3.checked==true) {
         lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callingnum3.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callednum3.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.dialeddigits3.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.origclli3.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.termclii3.checked==true) {
        lbl.style.backgroundColor='#00FF00';
        return;
    }
    document.submitCallDumpForm.all3.checked=true;
    lbl.style.backgroundColor='#00FF00';
}

function validateText4(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.text4.value=="") {
        uncheckAll4Box();
        uncheckInd4Box();
        if (isAllTextEmpty()==true) {
           lbl.style.backgroundColor='#FF0000';
        }
        return;
    }
    if (document.submitCallDumpForm.all4.checked==true) {
         lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callingnum4.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callednum4.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.dialeddigits4.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.origclli4.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.termclii4.checked==true) {
        lbl.style.backgroundColor='#00FF00';
        return;
    }
    document.submitCallDumpForm.all4.checked=true;
    lbl.style.backgroundColor='#00FF00';
}


function validateText5(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.text5.value=="") {
        uncheckAll5Box();
        uncheckInd5Box();
        if (isAllTextEmpty()==true) {
           lbl.style.backgroundColor='#FF0000';
        }
        return;
    }
    if (document.submitCallDumpForm.all5.checked==true) {
         lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callingnum5.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callednum5.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.dialeddigits5.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.origclli5.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.termclii5.checked==true) {
        lbl.style.backgroundColor='#00FF00';
        return;
    }
    document.submitCallDumpForm.all5.checked=true;
    lbl.style.backgroundColor='#00FF00';
}

function validateText6(){
    var lbl = document.getElementById('searchlabel');
    if (document.submitCallDumpForm.text6.value=="") {
        uncheckAll6Box();
        uncheckInd6Box();
        if (isAllTextEmpty()==true) {
           lbl.style.backgroundColor='#FF0000';
        }
        return;
    }
    if (document.submitCallDumpForm.all6.checked==true) {
         lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callingnum6.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.callednum6.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.dialeddigits6.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.origclli6.checked==true) {
        lbl.style.backgroundColor='#00FF00';
         return;
    }
    if (document.submitCallDumpForm.termclii6.checked==true) {
        lbl.style.backgroundColor='#00FF00';
        return;
    }
    document.submitCallDumpForm.all6.checked=true;
    lbl.style.backgroundColor='#00FF00';
}

function isAllTextEmpty() 
{
   if (document.submitCallDumpForm.text1.value!="") {
      return false;
   }
   if (document.submitCallDumpForm.text2.value!="") {
      return false;
   }
   if (document.submitCallDumpForm.text3.value!="") {
      return false;
   }
   if (document.submitCallDumpForm.text4.value!="") {
      return false;
   }
   if (document.submitCallDumpForm.text5.value!="") {
      return false;
   }
   if (document.submitCallDumpForm.text6.value!="") {
      return false;
   }
   return true;
}

function textAllEmpty() {
   var lbl = document.getElementById('searchlabel');
   if (isAllTextEmpty()==true) {
      lbl.style.backgroundColor='#FF0000';
   }
}
function check1AllEmpty() {
    if (document.submitCallDumpForm.all1.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callingnum1.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callednum1.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.dialeddigits1.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.origclli1.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.termclii1.checked==true) {
       return false;
    }
    return true;
}
function check2AllEmpty() {
    if (document.submitCallDumpForm.all2.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callingnum2.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callednum2.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.dialeddigits2.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.origclli2.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.termclii2.checked==true) {
       return false;
    }
    return true;
}
function check3AllEmpty() {
    if (document.submitCallDumpForm.all3.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callingnum3.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callednum3.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.dialeddigits3.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.origclli3.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.termclii3.checked==true) {
       return false;
    }
    return true;
}
function check4AllEmpty() {
    if (document.submitCallDumpForm.all4.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callingnum4.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callednum4.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.dialeddigits4.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.origclli4.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.termclii4.checked==true) {
       return false;
    }
    return true;
}

function check5AllEmpty() {
    if (document.submitCallDumpForm.all5.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callingnum5.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callednum5.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.dialeddigits5.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.origclli5.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.termclii5.checked==true) {
       return false;
    }
    return true;
}
function check6AllEmpty() {
    if (document.submitCallDumpForm.all6.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callingnum6.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.callednum6.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.dialeddigits6.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.origclli6.checked==true) {
       return false;
    }
    if (document.submitCallDumpForm.termclii6.checked==true) {
       return false;
    }
    return true;
}


function uncheckAll1Box()
{
    document.submitCallDumpForm.all1.checked=false;
    textAllEmpty();
    if (check1AllEmpty()==true) {
         if (document.submitCallDumpForm.text1.value!="") {
              document.submitCallDumpForm.all1.checked=true;
         }
    }
}

function uncheckInd1Box()
{
    document.submitCallDumpForm.callingnum1.checked=false;
    document.submitCallDumpForm.callednum1.checked=false;
    document.submitCallDumpForm.dialeddigits1.checked=false;
    document.submitCallDumpForm.origclli1.checked=false;
    document.submitCallDumpForm.termclii1.checked=false;
    textAllEmpty();
    if (check1AllEmpty()==true) {
         if (document.submitCallDumpForm.text1.value!="") {
              document.submitCallDumpForm.all1.checked=true;
         }
    }

}
function uncheckAll2Box()
{
    document.submitCallDumpForm.all2.checked=false;
    textAllEmpty();
    if (check2AllEmpty()==true) {
         if (document.submitCallDumpForm.text2.value!="") {
              document.submitCallDumpForm.all2.checked=true;
         }
    }

}
function uncheckInd2Box()
{
    document.submitCallDumpForm.callingnum2.checked=false;
    document.submitCallDumpForm.callednum2.checked=false;
    document.submitCallDumpForm.dialeddigits2.checked=false;
    document.submitCallDumpForm.origclli2.checked=false;
    document.submitCallDumpForm.termclii2.checked=false;
    textAllEmpty();
    if (check2AllEmpty()==true) {
         if (document.submitCallDumpForm.text2.value!="") {
              document.submitCallDumpForm.all2.checked=true;
         }
    }

}

function uncheckAll3Box()
{
    document.submitCallDumpForm.all3.checked=false;
    textAllEmpty();
    if (check3AllEmpty()==true) {
         if (document.submitCallDumpForm.text3.value!="") {
              document.submitCallDumpForm.all3.checked=true;
         }
    }

}
function uncheckInd3Box()
{
    document.submitCallDumpForm.callingnum3.checked=false;
    document.submitCallDumpForm.callednum3.checked=false;
    document.submitCallDumpForm.dialeddigits3.checked=false;
    document.submitCallDumpForm.origclli3.checked=false;
    document.submitCallDumpForm.termclii3.checked=false;
    textAllEmpty();
    if (check3AllEmpty()==true) {
         if (document.submitCallDumpForm.text3.value!="") {
              document.submitCallDumpForm.all3.checked=true;
         }
    }


}

function uncheckAll4Box()
{
    document.submitCallDumpForm.all4.checked=false;
    textAllEmpty();
    if (check4AllEmpty()==true) {
         if (document.submitCallDumpForm.text4.value!="") {
              document.submitCallDumpForm.all4.checked=true;
         }
    }

}
function uncheckInd4Box()
{
    document.submitCallDumpForm.callingnum4.checked=false;
    document.submitCallDumpForm.callednum4.checked=false;
    document.submitCallDumpForm.dialeddigits4.checked=false;
    document.submitCallDumpForm.origclli4.checked=false;
    document.submitCallDumpForm.termclii4.checked=false;
    textAllEmpty();
    if (check4AllEmpty()==true) {
         if (document.submitCallDumpForm.text4.value!="") {
              document.submitCallDumpForm.all4.checked=true;
         }
    }


}

function uncheckAll5Box()
{
    document.submitCallDumpForm.all5.checked=false;
    textAllEmpty();
    if (check5AllEmpty()==true) {
         if (document.submitCallDumpForm.text5.value!="") {
              document.submitCallDumpForm.all5.checked=true;
         }
    }

}
function uncheckInd5Box()
{
    document.submitCallDumpForm.callingnum5.checked=false;
    document.submitCallDumpForm.callednum5.checked=false;
    document.submitCallDumpForm.dialeddigits5.checked=false;
    document.submitCallDumpForm.origclli5.checked=false;
    document.submitCallDumpForm.termclii5.checked=false;
    textAllEmpty();
    if (check5AllEmpty()==true) {
         if (document.submitCallDumpForm.text5.value!="") {
              document.submitCallDumpForm.all5.checked=true;
         }
    }

}

function uncheckAll6Box()
{
    document.submitCallDumpForm.all6.checked=false;
    textAllEmpty();
    if (check6AllEmpty()==true) {
         if (document.submitCallDumpForm.text6.value!="") {
              document.submitCallDumpForm.all6.checked=true;
         }
    }

}
function uncheckInd6Box()
{
    document.submitCallDumpForm.callingnum6.checked=false;
    document.submitCallDumpForm.callednum6.checked=false;
    document.submitCallDumpForm.dialeddigits6.checked=false;
    document.submitCallDumpForm.origclli6.checked=false;
    document.submitCallDumpForm.termclii6.checked=false;
    textAllEmpty();
    if (check6AllEmpty()==true) {
         if (document.submitCallDumpForm.text6.value!="") {
              document.submitCallDumpForm.all6.checked=true;
         }
    }

}

</script>

