<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="script/main.js"></script>
<link rel="stylesheet" type="text/css" href="tyyli.css">
<title>Asiakkaan muutos</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="5" class="oikealle"><a type="button" href="listaaasiakas.jsp" id="takaisin">Takaisin listaukseen ja hakuun </a></th>
			</tr>	
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
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
				<td><input type="submit" id="tallenna" value="Hyväksy" onclick="vieTiedot()"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="vanhaetunimi" id="vanhaetunimi">	
</form>
<span id="ilmo"></span>
</body>
<script>
function tutkiKeyX(event){
	if(event.keyCode==13){
		vieTiedot();
	}		
}


document.getElementById("etunimi").focus();


var etunimi = requestURLParam("etunimi");
fetch("asiakkaat/haeyksi/" + etunimi,{method: 'GET'})

.then( function (response) {
	return response.json()
})
.then( function (responseJson) {
	document.getElementById("etunimi").value = responseJson.etunimi;		
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("sposti").value = responseJson.sposti;	
	document.getElementById("vanhaetunimi").value = responseJson.etunimi;	
});	

function vieTiedot(){	
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
	
	var formJsonStr=formDataToJSON(document.getElementById("tiedot"));
	console.log(formJsonStr);
	
	fetch("asiakkaat",{
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Asiakkaan tietojen päivitys epäonnistui";
        }else if(vastaus==1){	        	
        	document.getElementById("ilmo").innerHTML= "Asiakkaan tietojen päivitys onnistui";			      	
		}	
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset();
}
</script>
</html>