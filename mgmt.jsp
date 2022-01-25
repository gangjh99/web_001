<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>" />
<script src="<c:url value='/js/jquery-3.4.0.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">

$( document ).ready(function() {
	   $('#idx').attr("readonly", true);
	   $('#writerNm').attr("readonly", true);
	   $('#indate').attr("readonly", true);
	   
}); 

function cancel() {
	location.href = "<c:url value = '/list.do'/>";
}

function add() {
	if($('#title').val()==''){
		alert("제목을 입력하세요");
		$('#title').focus();
		return;
	}
	if($('#contents').val()==''){
		alert("내용을 입력하세요");
		$('#contents').focus();
		return;
	}

	if( !confirm("등록하시겠습니까?") ){
		return;
	}

	document.form1.action = "<c:url value='/mgmt.do'/>?mode=add";
	document.form1.submit();
}

function add2(){
	if( $('#title').val() == '' ){
		alert("제목을 입력하세요");
		$('#title').focus();
		return;
	}
	if( $('#contents').val() == '' ){
		alert("내용을 입력하세요");
		$('#contents').focus();
		return;
	}
	
	if( !confirm("등록하시겠습니까?") ){
		return;
	}
	
	if( $(file).val() != '' ){
		var forData = new FormData();
		forData.append("file",$("input[name=file]")[0].files[0]);
		
		$ajax({
			url: "<c:out value='/fileAdd.do'/>",
			processData: false,
			contentType: false,
			method: "POST",
			cache: false,
			dta: formData
		})
		.done(function(data){
			if(data.indexOf("")>=0){
				return;
			}
			//alert(data);
			if( data != "" ){
				$('#filename').val(data);
				document.form1.action = "<c:url value='/mgmtAdd.do'/>?mode=add";
				document.form1.submit();
			}
		})
		.fail(function( jqXHR, textStatus, errorThrown){
			alert("오류:"+errorThrown);
		});
		
	}else{
		document.form1.action = "<c:url value='/mgmt.do'/>?mode=add";
		document.form1.submit();
	}
}

function mod(){
	if( $('#title').val() == '' ){
		alert("제목을 입력하세요");
		$('#title').focus();
		return;
	}
	if( $('#contents').val() == '' ){
		alert("내용을 입력하세요");
		$('#contents').focus();
		return;
	}
	
	if( !confirm("수정하시겠습니까?") ){
		return;
	}
	
	document.form1.action = "<c:url value='/mgmt.do'/>?mode=mod";
	document.form1.submit();
}

</script>
</head>
<body>
	<div class="container">
		<h1>등록/수정화면</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<label for="">안녕하세요</label>
			</div>
			<div class="panel-body">
				<form id="form1" name="form1" class="form-horizontal" method="post" action="">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물아이디:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="idx" name="idx"
								placeholder="자동발번" value="${boardVO.idx}">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">제목:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title"
								name="title" placeholder="제목을 입력하세요" maxlength="100" value="${boardVO.title}">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
						<div class="col-sm-10">
							<input type="hidden" class="form-control" id="writer" name="writer" placeholder="등록자를 입력하세요" maxlength="15" style="float:left; width: 30%" value="${boardVO.writer}"> 
							<input type="text" class="form-control" id="writerNm" name="writerNm" placeholder="등록자를 입력하세요" maxlength="15" style="float:left;width:30%;" value="${boardVO.writerNm}">			
							<input type="text" class="form-control" id="indate" name="indate" placeholder="등록일을 입력하세요" maxlength="10" f style="float:left; width: 30%" value="${boardVO.indate}">
								 <c:set var="indate" value="${boardVO.indate}"/>
			      
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">내용:</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="5" id="contents"
								name="contents" maxlength="1000">${boardVO.contents}</textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="panel-footer">
				<button type="button" class="btn btn-default" onclick="add();">등록</button>
				<button type="button" class="btn btn-default" onclick="mod();">수정</button>
				<button type="button" class="btn btn-default" onclick="cancel();">취소</button>
			</div>
		</div>
	</div>
</body>
</html>