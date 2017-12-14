<%@ taglib prefix="jstl-core" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html"%>
<%@ include file="header.jsp"%>
<%@ include file="select.js"%>
<%@ include file="datevalidation.js"%>
<%@ include file="checkbox.js"%>
<%@ include file="menu.jsp"%>

<html:form method="post" action="/submitter/submitCallDumpForm">

	<!-- START MAIN TABLE -->
	<table width="100%"  border="0" height="100%">

		<tr BGCOLOR="#FF0000">
						<td width="50%" id="searchlabel">
							<center>
								<font size="4">Search Criteria</font>
							</center>
						</td>
						<td width="50%" id="searchdestlabel">
							<font size="4"><center> Search Destination </center> </font>
						</td>

                </tr>
		<tr>

			<!-- (upper left) -->
			<td width="50%">
				<table width="100%" border="0" height="100%">
					<!-- START SEARCH_CRITERIA TABLE -->
					<tr>
						<td heigth="100%">
							<table width="90%" border="0" height="100%">
								<tr>
									<th>
										<font size="4"><center>
												Search String
											</center> </font>
										<center></center>
									</th>
									<th>
										ALL Fields
									</th>
									<th>
										Calling Number
									</th>
									<th>
										Called Number
									</th>
									<th>
										Dialed Digits
									</th>
									<th>
										Orig CLLI
									</th>
									<th>
										Term CLLI
									</th>
								</tr>
								<tr>
									<td width="60%">
										<input type="text" maxlength="30" size="20" name="text1" onchange="validateText1();">
									</td>
									<td width="7%">
										<input type="checkbox" name="all1" onclick="uncheckInd1Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callingnum1"
											onclick="uncheckAll1Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callednum1"
											onclick="uncheckAll1Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="dialeddigits1"
											onclick="uncheckAll1Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="origclli1"
											onclick="uncheckAll1Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="termclii1"
											onclick="uncheckAll1Box()">
									</td>
								</tr>
								<tr>
									<td width="60%">
										<input type="text" maxlength="30" size="20" name="text2" onchange="validateText2();">
									</td>
									<td width="7%">
										<input type="checkbox" name="all2" onclick="uncheckInd2Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callingnum2"
											onclick="uncheckAll2Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callednum2"
											onclick="uncheckAll2Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="dialeddigits2"
											onclick="uncheckAll2Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="origclli2"
											onclick="uncheckAll2Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="termclii2"
											onclick="uncheckAll2Box()">
									</td>
								</tr>
								<tr>
									<td width="60%">
										<input type="text" maxlength="30" size="20" name="text3" onchange="validateText3();">
									</td>
									<td width="7%">
										<input type="checkbox" name="all3" onclick="uncheckInd3Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callingnum3"
											onclick="uncheckAll3Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callednum3"
											onclick="uncheckAll3Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="dialeddigits3"
											onclick="uncheckAll3Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="origclli3"
											onclick="uncheckAll3Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="termclii3"
											onclick="uncheckAll3Box()">
									</td>
								</tr>
								<tr>
									<td width="60%">
										<input type="text" maxlength="30" size="20" name="text4" onchange="validateText4();">
									</td>
									<td width="7%">
										<input type="checkbox" name="all4" onclick="uncheckInd4Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callingnum4"
											onclick="uncheckAll4Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callednum4"
											onclick="uncheckAll4Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="dialeddigits4"
											onclick="uncheckAll4Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="origclli4"
											onclick="uncheckAll4Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="termclii4"
											onclick="uncheckAll4Box()">
									</td>
								</tr>
								<tr>
									<td width="60%">
										<input type="text" maxlength="30" size="20" name="text5" onchange="validateText5();">
									</td>
									<td width="7%">
										<input type="checkbox" name="all5" onclick="uncheckInd5Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callingnum5"
											onclick="uncheckAll5Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callednum5"
											onclick="uncheckAll5Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="dialeddigits5"
											onclick="uncheckAll5Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="origclli5"
											onclick="uncheckAll5Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="termclii5"
											onclick="uncheckAll5Box()">
									</td>
								</tr>
								<tr>
									<td width="60%">
										<input type="text" maxlength="30" size="20" name="text6" onchange="validateText6();">
									</td>
									<td width="7%">
										<input type="checkbox" name="all6" onclick="uncheckInd6Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callingnum6"
											onclick="uncheckAll6Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="callednum6"
											onclick="uncheckAll6Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="dialeddigits6"
											onclick="uncheckAll6Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="origclli6"
											onclick="uncheckAll6Box()">
									</td>
									<td width="7%">
										<input type="checkbox" name="termclii6"
											onclick="uncheckAll6Box()">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- END SEARCH_CRITERIA TABLE -->
			</td>
			<!--  END OF ROW1,COL1 MAIN TABLE -->

			<td heigth="100%" width="50%">
				<!--  START ROW1, COL2 MAIN TABLE -->


				<table height="100%" border="0" valign="top">
					<tr>
						<td>
							<font size="4"><center>
									Available Switches
								</center> </font>
						</td>
						<td>
							<font size="4"><center></center> </font>
						</td>
						<td>
							<font size="4"><center>
									Switches To Search
								</center> </font>
						</td>
					</tr>

					<tr>

						<td><html:select size="11" style="width: 50mm" property="switchlist"><html:options collection="switcheskey" property="name"
															labelName="name" />
							</html:select>
						</td>
						<td style="width: 30mm">
							<table>
								<tr>
									<td>
										<input type="button" value="   &gt&gt   "
											name="button1"
							onclick="customMoveSelectedOptionsTo(this.form['switchlist'],this.form['selectswitchlist'],true)">
									</td>
								</tr>
								<tr>
									<td>
										<input type="button" value="   &lt&lt   "
											name="button2"
						 onclick="customMoveSelectedOptionsFrom(this.form['selectswitchlist'],this.form['switchlist'],true)">
									</td>
								</tr>
							</table>
						</td>

						<td>
							<select size="11" onchange="selectAllOptions(this.form['selectswitchlist'])" multiple="true" style="width: 50mm"" name="selectswitchlist">
							</select>
						</td>
					</tr>
				</table>
			</td>
			<!--  END ROW1, COL2 MAIN TABLE -->
		</tr>
	</table>
	<br>
	<table align="center" width="75%"  border="0" height="100%">
		<tr BGCOLOR="#FF0000">
			<td id="startdatelabel">
				<center><font size="4">Start Date</font></center>
			</td>
			<td id="enddatelabel">
				<center><font size="4">End Date</font></center>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<table border="0" width="100%">
				<tr>
					<td align="center" width="28%"><font size="4">Month</font></td>
					<td align="center" width="18%"><font size="4">Day</font></td>
					<td align="center" width="18%"><font size="4">Year</font></td>
					<td align="center" width="18%"><font size="4">Hour</font></td>
					<td align="center" width="18%"><font size="4">Min</font></td>
				</tr>
				</table>
			</td>
			<td width="50%">
				<table border="0" width="100%">
				<tr>
					<td align="center" width="28%"><font size="4">Month</font></td>
					<td align="center" width="18%"><font size="4">Day</font></td>
					<td align="center" width="18%"><font size="4">Year</font></td>
					<td align="center" width="18%"><font size="4">Hour</font></td>
					<td align="center" width="18%"><font size="4">Min</font></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<table border="0" width="100%">
				<tr>
					<td align="center" width="20%">
                                           <select name="startmonth" width="100%" onchange="ValidateDate()">
                                             <option value ="1">January</option>
                                             <option value ="2">February</option>
                                             <option value ="3">March</option>
                                             <option value ="4">April</option>
                                             <option value ="5">May</option>
                                             <option value ="6">June</option>
                                             <option value ="7">July</option>
                                             <option value ="8">August</option>
                                             <option value ="9">September</option>
                                             <option value ="10">October</option>
                                             <option value ="11">November</option>
                                             <option value ="12">December</option>
                                           </select>
                                        </td>
					<td align="center" width="20%">
					  <select name="startday" width="20%" onchange="ValidateDate()">
                                             <option value ="1">01</option>
                                             <option value ="2">02</option>
                                             <option value ="3">03</option>
                                             <option value ="4">04</option>
                                             <option value ="5">05</option>
                                             <option value ="6">06</option>
                                             <option value ="7">07</option>
                                             <option value ="8">08</option>
                                             <option value ="9">09</option>
                                             <option value ="10">10</option>
                                             <option value ="11">11</option>
                                             <option value ="12">12</option>
                                             <option value ="13">13</option>
                                             <option value ="14">14</option>
                                             <option value ="15">15</option>
                                             <option value ="16">16</option>
                                             <option value ="17">17</option>
                                             <option value ="18">18</option>
                                             <option value ="19">19</option>
                                             <option value ="20">20</option>
                                             <option value ="21">21</option>
                                             <option value ="22">22</option>
                                             <option value ="23">23</option>
                                             <option value ="24">24</option>
                                             <option value ="25">25</option>
                                             <option value ="26">26</option>
                                             <option value ="27">27</option>
                                             <option value ="28">28</option>
                                             <option value ="29">29</option>
                                             <option value ="30">30</option>
                                             <option value ="31">31</option>
                                          </select>
                                        </td>
					<td align="center" width="20%">
                                           <select name="startyear" width="20%" onchange="ValidateDate()">
                                             <option value ="2013">2013</option>
                                             <option value ="2014">2014</option>
                                           </select>
                                        </td>
					<td align="center" width="20%">
					  <select name="starthour" width="20%" onchange="ValidateDate()">
					                         <option value ="0">00</option>
                                             <option value ="1">01</option>
                                             <option value ="2">02</option>
                                             <option value ="3">03</option>
                                             <option value ="4">04</option>
                                             <option value ="5">05</option>
                                             <option value ="6">06</option>
                                             <option value ="7">07</option>
                                             <option value ="8">08</option>
                                             <option value ="9">09</option>
                                             <option value ="10">10</option>
                                             <option value ="11">11</option>
                                             <option value ="12">12</option>
                                             <option value ="13">13</option>
                                             <option value ="14">14</option>
                                             <option value ="15">15</option>
                                             <option value ="16">16</option>
                                             <option value ="17">17</option>
                                             <option value ="18">18</option>
                                             <option value ="19">19</option>
                                             <option value ="20">20</option>
                                             <option value ="21">21</option>
                                             <option value ="22">22</option>
                                             <option value ="23">23</option>
                                           </select>
                                        </td>
					<td align="center" width="20%">
					  <select name="startmin" width="20%" onchange="ValidateDate()">
                                             <option value ="00">00</option>
                                             <option value ="15">15</option>
                                             <option value ="30">30</option>
                                             <option value ="45">45</option>
                                             <option value ="59">59</option>
                                           </select>
                                        </td>
				</tr>
				</table>
			</td>
			<td width="50%">
				<table border="0" width="100%">
				<tr>
                                        <td align="center" width="20%">
                                           <select name="endmonth" width="20%" onchange="ValidateDate()">
                                             <option value ="1">January</option>
                                             <option value ="2">February</option>
                                             <option value ="3">March</option>
                                             <option value ="4">April</option>
                                             <option value ="5">May</option>
                                             <option value ="6">June</option>
                                             <option value ="7">July</option>
                                             <option value ="8">August</option>
                                             <option value ="9">September</option>
                                             <option value ="10">October</option>
                                             <option value ="11">November</option>
                                             <option value ="12">December</option>
                                           </select>
                                        </td>
                                        <td align="center" width="20%">
                                          <select name="endday" width="20%" onchange="ValidateDate()">
                                             <option value ="1">01</option>
                                             <option value ="2">02</option>
                                             <option value ="3">03</option>
                                             <option value ="4">04</option>
                                             <option value ="5">05</option>
                                             <option value ="6">06</option>
                                             <option value ="7">07</option>
                                             <option value ="8">08</option>
                                             <option value ="9">09</option>
                                             <option value ="10">10</option>
                                             <option value ="11">11</option>
                                             <option value ="12">12</option>
                                             <option value ="13">13</option>
                                             <option value ="14">14</option>
                                             <option value ="15">15</option>
                                             <option value ="16">16</option>
                                             <option value ="17">17</option>
                                             <option value ="18">18</option>
                                             <option value ="19">19</option>
                                             <option value ="20">20</option>
                                             <option value ="21">21</option>
                                             <option value ="22">22</option>
                                             <option value ="23">23</option>
                                             <option value ="24">24</option>
                                             <option value ="25">25</option>
                                             <option value ="26">26</option>
                                             <option value ="27">27</option>
                                             <option value ="28">28</option>
                                             <option value ="29">29</option>
                                             <option value ="30">30</option>
                                             <option value ="31">31</option>
                                          </select>
                                        </td>
                                        <td align="center" width="20%">
                                           <select name="endyear" width="20%" onchange="ValidateDate()">
                                             <option value ="2013">2013</option>
                                             <option value ="2014">2014</option>
                                           </select>
                                        </td>

                                        <td align="center" width="20%">
                                          <select name="endhour" width="20%" onchange="ValidateDate()">
                                             <option value ="0">00</option>
                                             <option value ="1">01</option>
                                             <option value ="2">02</option>
                                             <option value ="3">03</option>
                                             <option value ="4">04</option>
                                             <option value ="5">05</option>
                                             <option value ="6">06</option>
                                             <option value ="7">07</option>
                                             <option value ="8">08</option>
                                             <option value ="9">09</option>
                                             <option value ="10">10</option>
                                             <option value ="11">11</option>
                                             <option value ="12">12</option>
                                             <option value ="13">13</option>
                                             <option value ="14">14</option>
                                             <option value ="15">15</option>
                                             <option value ="16">16</option>
                                             <option value ="17">17</option>
                                             <option value ="18">18</option>
                                             <option value ="19">19</option>
                                             <option value ="20">20</option>
                                             <option value ="21">21</option>
                                             <option value ="22">22</option>
                                             <option value ="23">23</option>
                                           </select>
                                        </td>
                                        <td align="center" width="20%">
                                          <select name="endmin" width="20%" onchange="ValidateDate()">
                                             <option value ="00">00</option>
                                             <option value ="15">15</option>
                                             <option value ="30">30</option>
                                             <option value ="45">45</option>
                                             <option value ="59">59</option>
                                           </select>
                                        </td>

				</tr>
				</table>
			</td>
			
		</tr>
		<!--  END OF ROW1 MAIN TABLE -->
	</table>
	<!-- END MAIN TABLE -->
	<center>
		<p>
			<html:submit>Submit CallDump</html:submit>
			<html:reset>Clear</html:reset>
		</p>
	</center>
</html:form>
<%@ include file="trailer.jsp"%>
