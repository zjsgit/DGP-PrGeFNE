<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>PrGeFNE</title>
		<meta charset="utf-8" />
		<meta name="description" content="Disease Genes"/>
		<meta name="viewport" content="width=1000px;" />
		<title>PrGeFNE</title>
		
		<!-- bootstrap core css   -->
		<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet"	type="text/css" href="bootstrap/css/non-responsive.css" />
		<link rel="stylesheet" type="text/css" href="css/index.css" />
	</head>
	<body>
		<div class="container">
			<div id="header">
				
				
			</div>
			<div id="content">
				<h3 class="text-center">PrGeFNE: Predicting disease-related genes by fast network embedding.</h3>
				
				<form role="form" id="disForm" method="post" action="queryDis">
					<div class="form-inline">
						<input type="text" class="form-control" name="disease" id="dis" placeholder="Input a disease name or UMLS ID">
						
					    <button id="submitInfo" type="submit" class="btn btn-info">submit</button>
					 </div>
					 <div class="form-inline">
					  	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="number"  value="10" checked> Top-10
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="number" value="50"> Top-50
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="number" value="100"> Top-100
					 	</label>
					 </div>
					 <div class="form-inline">
					 	<strong>Enrichment Analysis:</strong>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="enrichment"  value="null" checked> Null
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="enrichment"  value="pathway"> Pathway
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="enrichment"  value="bp"> BP
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="enrichment"  value="cc"> CC
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="enrichment" value="mf"> MF
					 	</label>
					 	<label class="radio" style="margin:5px 10px;">
					 		<input type="radio" name="enrichment" id="go" value="go"> GO(BP,CC,MF)
					 	</label>
					 </div>
									 
				</form>
				
				<div>
					<p>Examples of input: <strong>ACTH Syndrome, Ectopic</strong> or <strong>C0001627</strong></p>
				</div>
				
				<!--  
				<div id="res">
					<p>If you don't want to submit disease information one by one, we provide a <a href="./file/Disease2Genes.txt">link</a> to download the result text. You are welcome to use it.</p>
					
				</div>
				-->
				
				
				<div id="introduce" style= "margin:10px;">
					<p style="text-align: justify; text-justify: inter-ideograph; text-indent: 2em;">
						Description: Identifying disease-related genes is of importance for understanding of molecule mechanisms of diseases, as well as diagnosis and treatment of diseases. Many computational methods for predicting disease-related genes have been proposed, while how to make full use of multi-source information (e.g., disease-phenotype associations and protein-protein interactions) to enhance the performance of disease-gene prediction is still an open issue. Here, we proposed a novel method for predicting disease-related genes by using fast network embedding (PrGeFNE). Specifically, a heterogeneous network is first constructed by using disease-gene, disease-phenotype, protein-protein and gene-GO associations; and the low-dimensional vector representation of nodes is extracted from the heterogeneous network by using a fast network embedding algorithm. Then, a dual-layer heterogeneous network is reconstructed by using the low-dimensional vector representation, and a network propagation is applied to the dual-layer heterogeneous network to predict disease-related genes. Through 5-fold cross-validation and newly added association validation, we displayed the important roles of different types of association data in enhancing the ability of disease-gene prediction, and confirmed the excellent performance of PrGeFNE by comparing to state-of-the-art algorithms. Furthermore, we developed a web tool to facilitate researchers to search for candidate genes predicted by PrGeFNE that are unknown to be related to diseases. This may be useful for investigation of diseases’ molecular mechanisms as well as their experimental validations.
						
					</p>
					<p>
						Reference: Ju Xiang<sup>#</sup>, Ningrui Zhang<sup>#</sup>, Jiashuai Zhang, Xiaoyi Lv and Min Li, PrGeFNE: Predicting disease-related genes by fast network embedding, 2020, submitted to Methods. 
						
					</p>
				</div>
			</div>
			
			
			<div id="footer">
				
			</div>
			
		</div>
	</body>
	<script src="js/jquery.js" type="text/javascript" ></script>
	<script type="text/javascript">
		$(function(){
			$("#submitInfo").click(function(){
				var dis = $("#dis").val();
				if(dis == "" | dis == null){
					alert("error");
					return false;
				}
				return true;
			});
		
		});
	
	</script>
	
</html>