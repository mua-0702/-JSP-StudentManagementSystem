<%@page import="com.administrator.bean.ClassInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.administrator.bean.AllStudentInfo"%>
<%@page import="com.administrator.bean.RegisterStudentInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../assets/images/favicon.jpeg">

<title>学生信息管理系统 | 班级信息</title>

<!-- Bootstrap core CSS -->
<link
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../assets/styles/css/Administrator/home.css"
	rel="stylesheet">


</head>
<%
	/* 解决直接打开当前页面没有值的问题 */
	List<ClassInfo> list = (List<ClassInfo>) session.getAttribute("ClassInfo");
	if (list == null) {
		response.sendRedirect("../administratorClassInfoGet");
	}
%>
<body>
	<!-- 模态框 -->
	<div class="modal" tabindex="-1" role="dialog" id="myModal"
		style="display: none">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">
						<span class="glyphicon glyphicon-question-sign"></span> 提示
					</h4>
				</div>
				<div class="modal-body">
					<p>
						确定要删除&nbsp;<span style="color: red" id="myModalTip"></span>&nbsp;吗？
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="cancelDelete()">取消</button>
					<button type="button" class="btn btn-primary"
						onclick="comfirmDelete()">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 模态框2 -->
	<div class="modal" tabindex="-1" role="dialog" id="myModal2"
		style="display: none">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">
						<span class="glyphicon glyphicon-pencil"></span> 编辑
					</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" id="editForm"
						action="../administratorClassInfoEdit" method="post">
						<div class="form-group">
							<label for="inputClassId" class="col-sm-2 control-label">班号</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputClassId"
									placeholder="请输入班号" name="class_id" required="" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="inputClassName" class="col-sm-2 control-label">班名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputClassName"
									placeholder="请输入班名" name="class_name">
							</div>
						</div>

						<div class="form-group">
							<label for="inputMajor" class="col-sm-2 control-label">专业</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputMajor"
									placeholder="请输入专业" name="major">
							</div>
						</div>
						<div class="form-group">
							<label for="inputTotalPerson" class="col-sm-2 control-label">总人数</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputTotalPerson"
									placeholder="请输入专业" name="total_person" disabled>
							</div>
						</div>
						<div class="form-group">
							<label for="inputJoinYear" class="col-sm-2 control-label">创建时间</label>
							<div class=" col-sm-10">
								<input type="date" class="form-control" id="inputJoinYear"
									placeholder="请输入创建时间" name="join_year">
							</div>
						</div>

						<div class="form-group">
							<label for="inputCounselor" class="col-sm-2 control-label">辅导员</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputCounselor"
									placeholder="请输入辅导员" name="counselor">
							</div>
						</div>
						<div class="form-group">
							<label for="inputHeadmaster" class="col-sm-2 control-label">班主任</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputHeadmaster"
									placeholder="请输入班主任" name="headmaster">
							</div>
						</div>

					</form>


				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="cancelEdit()">取消</button>
					<button type="button" class="btn btn-primary"
						onclick="comfirmEdit()">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- 模态框3 添加信息用 -->
	<div class="modal" tabindex="-1" role="dialog" id="myModal3"
		style="display: none">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">
						<span class="glyphicon glyphicon-pencil"></span> 编辑
					</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" id="editForm2"
						action="../administratorClassInfoAdd" method="post">
						<div class="form-group">
							<label for="inputClassId" class="col-sm-2 control-label">班号</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputClassId"
									placeholder="请输入班号" name="class_id" required="">
							</div>
						</div>
						<div class="form-group">
							<label for="inputClassName" class="col-sm-2 control-label">班名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputClassName"
									placeholder="请输入班名" name="class_name">
							</div>
						</div>

						<div class="form-group">
							<label for="inputMajor" class="col-sm-2 control-label">专业</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputMajor"
									placeholder="请输入专业" name="major">
							</div>
						</div>
						<div class="form-group">
							<label for="inputJoinYear" class="col-sm-2 control-label">创建时间</label>
							<div class=" col-sm-10">
								<input type="date" class="form-control" id="inputJoinYear"
									placeholder="请输入创建时间" name="join_year">
							</div>
						</div>

						<div class="form-group">
							<label for="inputCounselor" class="col-sm-2 control-label">辅导员</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputCounselor"
									placeholder="请输入辅导员" name="counselor">
							</div>
						</div>
						<div class="form-group">
							<label for="inputHeadmaster" class="col-sm-2 control-label">班主任</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputHeadmaster"
									placeholder="请输入班主任" name="headmaster">
							</div>
						</div>
					</form>


				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="cancelEdit()">取消</button>
					<button type="button" class="btn btn-primary"
						onclick="confirmAdd()">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!-- 警告框 -->
	<div class="alert alert-danger alert-dismissible fade in" role="alert"
		id="warningBox"
		style="display: none; width: 300px; height: 70px; z-index: 1000; position: absolute; left: 0; right: 0; top: 0; bottom: 0; margin: 60px auto">
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">×</span>
		</button>
		<h4>错误！</h4>
		<p>${error}</p>
	</div>

	<!-- 成功框 -->
	<div class="alert alert-success alert-dismissible fade in" role="alert"
		id="successBox"
		style="display: none; width: 300px; height: 70px; z-index: 1000; position: absolute; left: 0; right: 0; top: 0; bottom: 0; margin: 60px auto">
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">×</span>
		</button>
		<h4>成功！</h4>
		<p>${success}</p>
	</div>

	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<div class="img-box">
				<img src="../assets/images/logo.webp" alt="..."
					style="width: 40px; height: 40px; display: inhert">
			</div>
			<a class="navbar-brand" href="Home.jsp"> Impulse-学生信息管理系统</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="https://itaylorfan.github.io/me/" target="blank"><span
						class="glyphicon glyphicon-question-sign"></span> 关于</a></li>
				<li>
					<!-- Single button -->
					<div class="btn-group" style="height: 50px; margin-right: 10px">
						<button type="button" class="btn btn-default dropdown-toggle"
							style="top: 8px" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false">
							<span class="glyphicon glyphicon-cog"></span> 设置
						</button>
						<ul class="dropdown-menu">
							<li><a href="./ChangePassword.jsp" style="color: blue"><span
									class="glyphicon glyphicon-pencil"></span> 更改密码</a></li>

							<!-- 分割线 -->
							<li role="separator" class="divider"></li>
							<li><a href="../administratorExitLogin" style="color: red"><span
									class="glyphicon glyphicon-off"></span> 退出登录</a></li>
						</ul>
					</div>
				</li>


			</ul>
			<form class="navbar-form navbar-left">
				<input type="text" class="form-control" placeholder="请输入内容..."
					id="searchInput" value="${searchContent}">
				<button type="button" class="btn btn-default" style="top: 8px"
					id="search">
					<span class="glyphicon glyphicon-search"></span> 搜索
				</button>
			</form>
		</div>
	</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<!-- 左边菜单 -->
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="Home.jsp"> <span
							class="glyphicon glyphicon-home"></span> 用户管理
					</a></li>
					<li><a href="StudentInfo.jsp"><span
							class="glyphicon glyphicon-user"></span> 学生信息管理</a></li>
					<li class="active"><a href="#"><span
							class="glyphicon glyphicon-blackboard"></span> 班级信息管理</a></li>
					<li><a href="CourseInfo.jsp"><span
							class="glyphicon glyphicon-list-alt"></span> 课程信息管理</a></li>
					<li><a href="CourseChartInfo.jsp"><span
							class="glyphicon glyphicon glyphicon-th"></span> 课程表信息管理</a></li>
					<li><a href="GradeInfo.jsp"><span
							class="glyphicon glyphicon-thumbs-up"></span> 成绩信息管理</a></li>
					<li><a href="UserCenter.jsp"><span
							class="glyphicon glyphicon-asterisk"></span> 个人中心</a></li>
				</ul>

			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">班级信息管理</h1>

				<!-- <h4 class="sub-header">班级信息</h4> -->

				<div class="panel panel-default panel-primary"
					style="border-top: none; text-align: center">
					<div class="panel-heading">
						<h3 class="panel-title">班级信息</h3>
					</div>
					<div class=" panel-body">
						<div class="table-responsive">
							<table class="table table-condensed">
								<thead>
									<tr>
										<th>班号</th>
										<th>班名</th>
										<th>专业</th>
										<th>总人数</th>
										<th>创建时间</th>
										<th>辅导员</th>
										<th>班主任</th>
										<th><button type="button" class="btn btn-info btn-sm"
												style="" id="refresh">刷新</button>
											<button type="button" class="btn btn-warning btn-sm" style=""
												id="add">添加</button></th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach items="${ClassInfo}" var="ci">
										<tr>
											<td>${ci.class_id}</td>
											<td>${ci.class_name}</td>
											<td>${ci.major}</td>
											<td>${ci.total_person}</td>
											<td>${ci.join_year}</td>
											<td>${ci.counselor}</td>
											<td>${ci.headmaster}</td>

											<td style="width: 20%">
												<button type="button" class="btn btn-success btn-sm"
													style="outline: none" onclick="editDialog()">编辑</button>
												<button type="button" class="btn btn-danger btn-sm"
													style="outline: none" onclick="deleteDialog()">删除</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
								<!-- 分页 -->
							<nav aria-label="Page navigation">
							<ul class="pagination">
								<li><a href="../administratorClassInfoPaging?page=prev"
									aria-label="Previous"> <span aria-hidden="true">«</span>
								</a></li>
								<!-- <li class="active"><span>1 <span class="sr-only">(current)</span></span>
								</li> -->


								<c:forEach items="${ClassInfoPageNum}" var="ci">
									<li class="pageNum"><a
										href="../administratorClassInfoPaging?page=${ci-1}">${ci}</a></li>
								</c:forEach>


								<li><a href="../administratorClassInfoPaging?page=next"
									aria-label="Next"> <span aria-hidden="true">»</span>
								</a></li>
							</ul>

							</nav>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')
	</script>
	<script
		src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
	<script>
	//点击后设置当前被选中
	<%
	int current_page=0;
	if(session.getAttribute("ClassInfoCurrentPage")!=null){
		 current_page = (Integer) session.getAttribute("ClassInfoCurrentPage");
	}
	%>
	var currentPage=<%=current_page%>
	console.log(currentPage);
	$(".pageNum").eq(currentPage).addClass("active");
	//console.log($(".pageNum")[1].classList.add("active"))
	
	</script>	
	
	<script>
		/* 确认添加信息 */
		function confirmAdd(){
			const Form=$("#editForm2 input");
			//console.log(Form);
			//获取学号数据
			const tbody=$("#tbody>tr");
			
			let index=0;
		    for(let i=0;i<Form.length;i++){
				if(Form.eq(i).val().replace(/\s+/g,"")===""){
					alert("请填写完整！");
					return
				}else{
					index++;
				}
			}
		    
		    for(let j=0;j<tbody.length;j++){
		    	if(tbody.eq(j).find("td:first")[0].innerHTML==Form.eq(0).val()){
		    		alert("班号已存在！");
					return
		    	}else if(tbody.eq(j).find("td").eq(1)[0].innerHTML==Form.eq(1).val()){
		    		alert("班名已存在！");
					return
		    	}
				//console.log(tbody.eq(j).find("td:first")[0].innerHTML);
			}
		    
			if(index===Form.length){
				console.log("可以提交！");
				$("#editForm2").submit();
			} 
			
			
			
			
		}
		/* 添加信息 */
		$("#add").click(function(){
			//console.log("aaa");
			$('#myModal3').modal("show");
		})
		
		
		/*搜索*/
		$("#search").click(function(){
			let text=$("#searchInput").val();
			if(text!==""){
				//console.log(text);
				window.location = "../administratorClassInfoSearch?query="+text;
			}
			
		})
	
		/* 	弹出编辑框 */
		function editDialog(e){
			const event=e||window.event;
			const Form=$("#editForm input");
			const SelectSex=$("#inputSex");
			/* console.log(SelectSex);
			console.log(Form); */
			
			let data=0;
			//获取当前tr的下标
			data=event.target.parentNode.parentNode.rowIndex;
			//console.log(data);
			
			for(let i=0;i<event.target.parentNode.parentNode.children.length-1;i++){
				//data+=event.target.parentNode.parentNode.children[i].innerHTML+",";
				/* if(i==2){
					SelectSex.val(event.target.parentNode.parentNode.children[i].innerHTML);
					Form.eq(i).val(event.target.parentNode.parentNode.children[i+1].innerHTML);
				}else{
					if(i>2){
						Form.eq(i).val(event.target.parentNode.parentNode.children[i+1].innerHTML);
					}else{
						Form.eq(i).val(event.target.parentNode.parentNode.children[i].innerHTML);
					}				
				} */
				Form.eq(i).val(event.target.parentNode.parentNode.children[i].innerHTML);
							
			}
			//显示模态框
			$('#myModal2').modal("show");
			//暂存数据
			$('#myModal2').attr("data",data);
		}
		/* 确认编辑 */
		function comfirmEdit(){
			const Form=$("#editForm input"); //只能获取input
			//const SelectSex=$("#inputSex");
			//console.log(Form.eq(0).val());
			//console.log(SelectSex.val());
			const tbody=$("#tbody>tr");
			
			//获取下标
			let rowIndex=$('#myModal2').attr("data");
			let index=0;
			
		    for(let i=0;i<Form.length;i++){
				if(Form.eq(i).val().replace(/\s+/g,"")===""){
					alert("请填写完整！");
					return
				}else{
					index++;
				}
			}
		    
		    for(let j=0;j<tbody.length;j++){
		    	if(tbody.eq(j).find("td").eq(1)[0].innerHTML==Form.eq(1).val()&&j!=rowIndex-1){
		    		alert("班名已存在！");
					return
		    	}
				//console.log(tbody.eq(j).find("td:first")[0].innerHTML);
			}
		    
			if(index===Form.length){
				console.log("可以提交！");
				$("#editForm").submit();
			} 
			//$("#editForm").submit();
			
		}
		
		/* 取消编辑 */
		function cancelEdit(){
			//删除节点中的数据
			$('#myModal2').removeAttr("data");
			
		}
		
		/*取消删除*/
	    function cancelDelete(){
	    	$('#myModal').removeAttr("data");
	    }
		/*确定删除*/
	    function comfirmDelete(){
			let class_id;
			class_id=$('#myModal').attr("data");
	    	//console.log(sno);
	    	window.location = "../administratorClassInfoDelete?class_id="+class_id;
	    }
	    /* 触发删除模态框 */
		function deleteDialog(e){
			const event=e||window.event;
			let sno=event.target.parentNode.parentNode.children[0].innerHTML;
			//显示模态框
			$('#myModal').modal("show");
			//暂存数据
			$('#myModal').attr("data",sno);
			$("#myModalTip").text(sno);
			//window.location = "../administratorHomeDelete";
		}
		/* 刷新按钮 */
		$("#refresh").click(function(){
			window.location = "../administratorClassInfoGet"
		})
		
	</script>

	<%
		String error = (String) session.getAttribute("error");
		if (error != null) {
	%>
	<script>
				$("#warningBox").slideDown();
				setTimeout(()=>{
					$("#warningBox").slideUp();
				},3000)
			</script>

	<%
		}

		session.setAttribute("error", null);
	%>

	<%
		String success = (String) session.getAttribute("success");
		if (success != null) {
	%>
	<script>
				$("#successBox").slideDown();
				setTimeout(()=>{
					$("#successBox").slideUp();
				},3000)
			</script>

	<%
		}
		session.setAttribute("success", null);
	%>
</body>
</html>