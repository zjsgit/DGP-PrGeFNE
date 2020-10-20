<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>result</title>
		<!-- bootstrap core css   -->
		<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet"	type="text/css" href="bootstrap/css/non-responsive.css" />
		<link rel="stylesheet"	type="text/css" href="bootstrap/css/bootstrap-table.min.css" />
		<link rel="stylesheet"	type="text/css" href="css/result.css" />
	</head>
	<body>
		<div class="container">
		
			<div id="forgene">
				<div>
					<h4>Candidate genes for: ${disease} </h4>
					
					<div style="margin-bottom:5px;">
						<a class="btn btn-info btn-sm" href ="./index.jsp">back</a>
						<a class="pull-right btn btn-info btn-sm" href ="./downloadRe?msg=genes">download</a>
					</div>
				</div>
				<table id="showResult1"></table>
			</div>
			<div id="forenrich">
				<div>
					<h4>Enrichment analysis of ${type} </h4>
					<div style="margin-bottom:5px;">
						<a class="btn btn-info btn-sm" href ="./index.jsp">back</a>
						<a class="pull-right btn btn-info btn-sm" href ="./downloadRe?msg=enrichment">download</a>
					</div>
				</div>
				<table id="showResult2"  style="table-layout: fixed;"></table>
			</div>

		</div>
		
	</body>
	
	<script src="js/jquery.js" type="text/javascript" ></script>
	<script src="bootstrap/js/bootstrap.min.js" type="text/javascript" ></script>
	<script src="bootstrap/js/bootstrap-table.min.js" type="text/javascript" ></script>
	<script type="text/javascript">
		$(function(){
			
			var re = ${genes};
			//var result = JSON.stringify(re);
			
			var enrichment = ${enrichment};
			
			
			$("#showResult1").bootstrapTable({
				
				data:re,
				striped:true,
				showRefresh:false,
				pagination:true,
				slidePagination:"client",
				pageSize:10,
				pageNumber:1,
				paginationFirstText:"first page",
				paginationPreText:"up page",
				paginationNextText:"next page",
				paginationLastText:"last page",
				buttonClass:'btn',
				iconSize:"page",
				columns:[{
						field:'gene',
						title:'GeneNames'
					},{
						field:'rank',
						title:'Ranking'
					}],
				onLoadSuccess: function(){
					
				},
				onLoadError: function(statusCode){
					return "load error";
				},
				formatLoadingMessage: function(){
					return "loading";
				}
			}); 
			
			//---------------------------------------------------------------------
			if (enrichment == null | enrichment == ""){
				$("#forenrich").hide();
			}else{
				$("#showResult2").bootstrapTable({
					
					data:enrichment,
					striped:true,
					columns:[{
							field:'pathway',
							title:'Item',
							width:590
						},{
							field:'Pvalue',
							title:'Pvalue',
							width:170
						},{
							field:'adjPvalue',
							title:'adjPvalue',
							width:170
						}],
					onLoadSuccess: function(){
						
					},
					onLoadError: function(statusCode){
						return "load error";
					},
					formatLoadingMessage: function(){
						return "loading";
					}
				}); 
			}
			
		
		});
		
	
	</script>
	
</html>