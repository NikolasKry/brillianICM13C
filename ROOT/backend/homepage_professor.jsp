<?xml version="1.0" encoding="UTF-8" ?>
<%@ page import="org.dhbw.imbit11.ApplicationConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><%= ApplicationConstants.PAGETITLE_PROFESSOR %></title>
<link rel="apple-touch-icon" sizes="57x57" href="images/favicons/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="114x114" href="images/favicons/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="72x72" href="images/favicons/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="144x144" href="images/favicons/logo144.png">
<link rel="apple-touch-icon" sizes="60x60" href="images/favicons/logo60.png">
<link rel="apple-touch-icon" sizes="120x120" href="images/favicons/logo120.png">
<link rel="apple-touch-icon" sizes="76x76" href="images/favicons/logo76.png">
<link rel="apple-touch-icon" sizes="152x152" href="images/favicons/logo152.png">
<link rel="icon" type="image/png" href="images/favicons/logo196.png" sizes="196x196">
<link rel="icon" type="image/png" href="images/favicons/logo160.png" sizes="160x160">
<link rel="icon" type="image/png" href="images/favicons/logo96.png" sizes="96x96">
<link rel="icon" type="image/png" href="images/favicons/logo16.png" sizes="16x16">
<link rel="icon" type="image/png" href="images/favicons/logo32.png" sizes="32x32">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="msapplication-TileImage" content="images/favicons/logo144.png">
<link type="text/css" rel="stylesheet" href="css/jquery.easyui.css" />
<link type="text/css" rel="stylesheet" href="css/jquery.easyui.icon.css" />
<link rel="stylesheet" type="text/css"
	href="css/jquery.fancybox.css?v=2.1.5" media="screen" />
<link type="text/css" rel="stylesheet" href="css/master.css" />
<script type="text/javascript" src="js/frameworks/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="js/frameworks/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/frameworks/jquery.fancybox.pack.js?v=2.1.5"></script>
<script type="text/javascript" src="js/master.js"></script>
</head>
<body class="easyui-layout">
	<div class="north" data-options="region:'north',border:false">
		<div class="div-header window">
			<a id="logout" class="easyui-linkbutton" data-options="plain:true"
				onclick="window.location.href='LogoutUser'"><%=ApplicationConstants.LOGOUT_BUTTON_TEXT%></a>
			<a id="imprint" class="easyui-linkbutton" data-options="plain:true"><%=ApplicationConstants.IMPRINT_BUTTON_TEXT%></a>
		</div>
	</div>
	<div class="center mainWindow" data-options="region:'center'">
		<div id="studentsOfProfessor">
			<h1>Lecturer Page</h1>
			<br />
			<div id="groupsOfProfessor">			
				<h4>Groups</h4>
				Below, all existing groups are listed with their belonging students.
				<br />
				<p style="color: blue">${status}</p>
				<br />
				<br />
				
				<%
					
					if(request.getAttribute("groups")!=null){
											
											//students = new String[((String [][]) request.getAttribute("students")).length][request.getAttribute("students")[0].length];
											@SuppressWarnings("unchecked")
											ArrayList<ArrayList<String>> groups = (ArrayList<ArrayList<String>>)request.getAttribute("groups");
											if(groups.isEmpty()){
												out.println("<p style='color: red'>You have currently no groups. Create a group by entering a groupname below and click on 'create group'.</p>");	
											}
										//out.println("<table><tr><td>Group</td><td>Registration Link</td></tr>");
										for(int i=0; i<groups.size(); i++){//ArrayList<String> row : groups
											//group name
											out.println("<div class=\"group\"><table><tr><td><big>");
											out.println(groups.get(i).get(1));
											out.println("</big></td><td>");
											//send email invitation button
											out.println("<form action=\""+ application.getContextPath()+"/SendRegistrationLink\" method=\"get\"><input style=\"display:none\" id=\"invitationbutton"+i+"\" type=\"submit\" "+
												"value=\"Send email invitation\"/><a class= \"easyui-linkbutton\" onclick=\"$('#invitationbutton"+i+"').trigger('click')\">send email invitation</a>");
											out.println("<input type=\"text\" name=\"link\" value=\""+ groups.get(i).get(2) +"\" style=\"display:none\"/></form></td><td>");
											//delete group without members button
											out.println("<td><form action=\""+ application.getContextPath()+"/DeleteGroup\" method=\"post\">"
												+ "<input style=\"display:none\" id=\"deleteGroupButton"+i+"\" type=\"submit\" value=\"Delete Group\"/> <a class= \"easyui-linkbutton\" onclick=checker("+i+",\""+groups.get(i).get(1)+"\")>delete group</a>"
												+ "<input type=\"text\" name=\"group_id\" value=\""+ groups.get(i).get(0) +"\" style=\"display:none\"/>"
												+ "</form></td><td>");
											//delete group with all members button
											out.println("<td><form action=\""+ application.getContextPath()+"/DeleteGroupMembers\" method=\"post\">"
												+ "<input style=\"display:none\" id=\"deleteGroupMembersButton"+i+"\" type=\"submit\" value=\"Delete Group Members\"/> <a class= \"easyui-linkbutton\" onclick=checker("+i+",\""+groups.get(i).get(1)+"\")>delete group with members</a>"
												+ "<input type=\"text\" name=\"group_id\" value=\""+ groups.get(i).get(0) +"\" style=\"display:none\"/>"
												+ "</form></td><td>");
											//set progress dropdown and button with set TCQ progress
											out.println("<form action=\""+ application.getContextPath()+"/SetUserProgress\" method=\"post\">"
												+ "<input type=\"text\" name=\"group_id\" value=\""+ groups.get(i).get(0) +"\" style=\"display:none\"/>"
												+ "<input type=\"text\" name=\"cost\" value=\"71\" style=\"display:none\"/>" 
												+ "<input type=\"text\" name=\"time\" value=\"71\" style=\"display:none\"/>"
												+ "<input type=\"text\" name=\"quality\" value=\"71\" style=\"display:none\"/>"
												/* Set the Level Name and Unique Level ID for the Dropdown in the Lecturer page here */
												+ "<select name=\"lvlId\" id=\"lvlId\">"
												+ "<option value=\"l204e000\">Budget Planning</option>"
												+ "<option value=\"l290e000\">Critical Path</option>"
												+ "<option value=\"l009e013\">Project Management Phasen</option>"
												+ "<option value=\"l022e000\">Risk Analysis</option>"
												+ "<option value=\"l031e000\">Stakeholder Analysis</option>"								
												+ "<option value=\"l201e000\">Work Breakdown Structure</option>"
												+ "</select>"								
												+ "<input id=\"setProgress"+i+"\" type=\"submit\" "+"value=\"setProgress\" style=\"display:none\" /></td><td>"
												+ "<a class= \"easyui-linkbutton\" onclick=\"$('#setProgress"+ i +"').trigger('click')\")>Set Progress</a></td></form></td><td>");
											out.println("</td></tr></table> ");
											
											//add students table beneath group header
											
											if(request.getAttribute("students")!=null){
												//students = new String[((String [][]) request.getAttribute("students")).length][request.getAttribute("students")[0].length];
												@SuppressWarnings("unchecked")
												ArrayList<ArrayList<String>> students = (ArrayList<ArrayList<String>>)request.getAttribute("students");
												ArrayList<ArrayList<String>> studentsFiltered = new ArrayList<ArrayList<String>>();
												for (ArrayList<String> singleStudent : students){
													if(singleStudent.get(7).equals(groups.get(i).get(0))){
														studentsFiltered.add(singleStudent);
													}
												}
												
												
												if(studentsFiltered.isEmpty()){
													out.println("<p style='color: red'>There are currently no students in this group. Invite students by sending a registration email.</p>");
												}else{
													out.println("<table id=\"students\" class=\"easyui-datagrid\" style=\"width: 800px\" data-options=\"fitColumns:true,singleSelect:true\">"
															+"<thead><tr><th data-options=\"field:'delete',width:47,resizable:false\"></th>"
															+"<th data-options=\"field:'reset',width:47,resizable:false\"></th>"
															+"<th data-options=\"field:'lastname',width:100,resizable:false\">Last name</th>"
															+"<th data-options=\"field:'firstname',width:100,resizable:false\">First name</th>"
															+"<th data-options=\"field:'cost',width:40,resizable:false,styler:cellStyler\">Cost</th>"
															+"<th data-options=\"field:'time',width:40,resizable:false,styler:cellStyler\">Time</th>"
															+"<th data-options=\"field:'quality',width:40,resizable:false,styler:cellStyler\">Quality</th>"
															+"<th data-options=\"field:'finished',width:60,resizable:false\">Finished</th>"
															+"<th data-options=\"field:'email',width:200,resizable:false\">Email</th>"
															+"</tr></thead><tbody>");
												}
											int a = 0;
											for(ArrayList<String> row : students){
												a++;
												if (groups.get(i).get(1).equals(row.get(5))){
													out.println("<tr><td>");
													out.println("<form action=\""+ application.getContextPath()+"/DeleteUser\" method=\"post\"><input style=\"display:none\" id=\"deleteUserButton"+a+"\" type=\"submit\" "+
															"value=\"Delete User\"/><a class= \"easyui-linkbutton\" onclick=\"$('#deleteUserButton"+a+"').trigger('click')\">Delete</a>");
													out.println("<input type=\"text\" name=\"delete_email\" value=\""+ row.get(6) +"\" style=\"display:none\"/></form>");
													out.println("</td><td>");
													out.println("<form action=\""+ application.getContextPath()+"/ResetUserProgress\" method=\"post\"><input style=\"display:none\" id=\"resetUserProgressButton"+a+"\" type=\"submit\" "+
															"value=\"Reset User\"/><a class= \"easyui-linkbutton\" onclick=\"$('#resetUserProgressButton"+a+"').trigger('click')\">Reset</a>");
													out.println("<input type=\"text\" name=\"reset_email\" value=\""+ row.get(6) +"\" style=\"display:none\"/></form>");
													out.println("</td><td>");
													out.println(row.get(1));
													out.println("</td><td>");
													out.println(row.get(0));
													out.println("</td><td>");
													out.println(row.get(2));
													out.println("</td><td>");
													out.println(row.get(3));
													out.println("</td><td>");
													out.println(row.get(4));
													out.println("</td><td>");
													out.println(row.get(8));
													out.println("</td><td>");
													//Check whether student has confirmed registration by clicking on Link:
													//if true, print email in table, if false, print error message
														String mailToTest = row.get(6);
														Boolean found;
														String wordToFind  = "@";
														found = mailToTest.contains(wordToFind);
														if (found){
															out.println(row.get(6));
														} else {
															out.println("<font color=\"red\">Registration not yet confirmed.</font>");
														}
													out.println("</td></tr>");
													
											}
												}
												out.println("</tbody></table></div>");
											}			
											
											}
											//out.println("</table> ");
										}else{
											out.println("<tr>You have not created any courses yet.</tr>");
										}
				%>
			</div>


			<div style="width: 800px; background-color: white; border-width:1px; border-style:solid; border-color:black; padding: 2px">
				<div style="width: 390px; float: left;">
					<h4>Create New Group</h4>
					<form action="NewUsergroup" method="post">
						<div class="formLabel">name:</div>
						<input type="text" name="groupname" maxlength="50" required /> <input
							type="submit" style="display: none" id="createGroup"
							value="Create group" /><br />
						<br /> <a class="easyui-linkbutton"
							onclick="$('#createGroup').trigger('click')">create group</a>
						<p style="color: green">${success}</p>
						<p style="color: red">${error}</p>
					</form>
				</div>
				<div style="margin-left: 410px;">
					<h4>Change Lecturer Password</h4>
					<form action="ResetPassword" method="post">
						<input type="text" name="username" maxlength="50"
							value="${username}" style="display: none" /> <input type="text"
							name="role" maxlength="50" value="professor" style="display: none" />
						<div class="formLabel">new password:</div>
						<input type="password" name="password" maxlength="50" /><br />
						<br />
						<div class="formLabel">repeat new password:</div>
						<input type="password" name="password_repeat" maxlength="50" /><br />
						<br /> <input id="updatePassword" type="submit"
							name="updatePassword" value="Update password" hidden="hidden" /> <a
							class="easyui-linkbutton"
							onclick="$('#updatePassword').trigger('click')">update
							password</a>
					</form>
				</div>
			</div>
			<div class="mainEventContainerImprint easyui-window"
				data-options="closed:true,width:863,height:576"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$('body').show();
	$('#imprint').bind('click', function() {
		showImprint();
	});

	function cellStyler(value, row, index) {
		if (value <= 30) {
			return 'background:#ffa8a8;';
		} else if (value >= 70) {
			return 'background:lightgreen;';
		} else {
			return 'background:khaki';
		}
	}

	function checker(i, groupname) {
		var box = window.confirm("Click OK if you want to delete group: "
				+ groupname);
		if (box) {
			$('#deleteGroupButton' + i).trigger('click');
		}
	}
	function confirmPasswordChange()
	{
		var box = window.confirm("Click OK if you want to change password. You will be logged out. ");
		if(box)
		{
			$('#updatePassword').trigger('click');
			sessionStorage.removeItem('userid');
			window.location.href = 'LogoutUser';
		}
	}
</script>
</html>
