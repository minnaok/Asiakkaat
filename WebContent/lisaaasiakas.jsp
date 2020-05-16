<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="script/main.js"></script>
<link rel="stylesheet" type="text/css" href="tyyli.css"></link>

<title>Asiakkaan lisäys</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="asiakaslisays">
	<table>
		<thead>	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="2" class="oikealle"><a href="listaaasiakas.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelinnumero</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="button" id="tallenna" value="Lisää" onclick="lisaaTiedot()"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
function tutkiKey(event){
	if(event.keyCode==13){
		lisaaTiedot();
	}
	
}

document.getElementById("etunimi").focus();

function lisaaTiedot(){	
	var ilmo="";
	if(document.getElementById("etunimi").value.length<3){
		ilmo="Etunimi ei kelpaa.";		
	}else if(document.getElementById("sukunimi").value.length<2){
		ilmo="Sukunimi ei kelpaa.";		
	}else if(document.getElementById("puhelin").value.length<1){
		ilmo="Puhelinnumero ei kelpaa.";		
	}else if(document.getElementById("sposti").value.length<1){
		ilmo="Sähköposti ei kelpaa.";		
	}
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
		return;
	}
	document.getElementById("etunimi").value=(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=(document.getElementById("puhelin").value);
	document.getElementById("sposti").value=(document.getElementById("sposti").value);	
		
	var formJsonStr=formDataToJSON(document.getElementById("asiakaslisays"));
	
	fetch("asiakkaat",{
	      method: 'POST',
	      body:formJsonStr
	    })
	.then( function (response) {	
		return response.json()
	})
	.then( function (responseJson) {	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen epäonnistui";
      	}else if(vastaus==1){	        	
      		document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen onnistui";			      	
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("asiakaslisays").reset();
}
</script>
</html>