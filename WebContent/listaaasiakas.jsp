<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="tyyli.css"></link>
<script src="script/main.js"></script>

<title>Asiakashaku</title>
</head>
<body onkeydown="tutkiKey(event)">
<table id="listaus">
<thead>
<tr>
	<th colspan="3" id="ilmo"></th>
			<th><a id="uusiAuto" href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
</tr>
<tr>
<th class="oikealle"> Haku:</th> 
<th colspan="2"><input type="text" id="hakusana"></th>
	<th><input type="submit" value="Hae" id="hakunappi" onclick="haeTiedot()"></th>
		</tr>
		<tr>
		<th>Etunimi</th>
		<th>Sukunimi</th>
		<th>Puhelin</th>
		<th>Sähköposti</th>
		</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
</table>
<script>
haeTiedot();	
document.getElementById("hakusana").focus();

function tutkiKey(event){
	if(event.keyCode==13){
		haeTiedot();
	}		
}

function haeTiedot(){	
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value,{
	      method: 'GET'
	    })
	.then(function (response) {
		return response.json()	
	})
	.then(function (responseJson) {	
		var asiakkaat = responseJson.asiakkaat;	
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++){			
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";  
        	htmlStr+="<td><a href='muutaasiakas.jsp?etunimi="+asiakkaat[i].etunimi+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].etunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";        	
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})	
}

function poista(etunimi){
	if(confirm("Poista asiakas " + etunimi +"?")){	
		fetch("asiakkaat/"+ etunimi,{
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan poisto epäonnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakkaan " + etunimi +" poisto onnistui.";
				haeTiedot();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
}
</script>
</body>
</html>