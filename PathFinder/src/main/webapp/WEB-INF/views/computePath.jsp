<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.0.3/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.0.3/dist/leaflet.js"></script>

<t:template>
    <jsp:attribute name="header">
        <%@include file="../components/navbar.jsp"%>
        
        <script type="text/javascript">
	        function addMarker(e) {
	            var srcLat = document.getElementById("srcLat");
	            var srcLng = document.getElementById("srcLng");
	            var dstLat = document.getElementById("dstLat");
	            var dstLng = document.getElementById("dstLng");
	
	            if (srcPointFilled == false) {
	                // set the form fields and set the filled var
	                srcLat.setAttribute("value", e.latlng.lat);
	                srcLng.setAttribute("value", e.latlng.lng);
	                srcPointFilled = true;
	
	                // show the marker
	                srcPointMarker = new L.marker(e.latlng).addTo(mymap);
	            }
	            else if (dstPointFilled == false) {
	                // set the form fields and set the filled var
	                dstLat.setAttribute("value", e.latlng.lat);
	                dstLng.setAttribute("value", e.latlng.lng);
	                dstPointFilled = true;
	
	                // show the marker
	                dstPointMarker = new L.marker(e.latlng).addTo(mymap);
	            }
	        }
	
	        function submitForm(form) {
	            if (srcPointFilled == true && dstPointFilled == true) {
	                form.submit();
	            }
	            else {
	                alert("Per calcolare il percorso selezionare prima due punti sulla mappa");
	            }
	        }
	
	        function resetForm()
	        {
	            // reset form fields
	            srcLat.setAttribute("value", "");
	            srcLng.setAttribute("value", "");
	            dstLat.setAttribute("value", "");
	            dstLng.setAttribute("value", "");
	
	            // reset the filled var
	            srcPointFilled = false;
	            dstPointFilled = false;
	
	            // remove the markers
	            mymap.removeLayer(srcPointMarker);
	            mymap.removeLayer(dstPointMarker);
	
	            return false;
	        }
	    </script>
    </jsp:attribute>
	<jsp:attribute name="footer">
        <div id="pagefooter" class="row">
            <%@include file="../components/footer.jsp"%>
        </div>
    </jsp:attribute>

	<jsp:body>
	    <div>
            <h1>Servizio di calcolo del percorso</h1>
            <p>Selezionare due punti sulla mappa come sorgente e destinazione del percorso da calcolare</p>
            
            <div id="mapid" style="width: 100%; height: 400px;"></div>

            <script>
	            var srcPointFilled = false;
	            var dstPointFilled = false;
	            var srcPointMarker;
	            var dstPointMarker;
            
                // Create the map and set the view on Turin
                var mymap = L.map('mapid').setView([45.064, 7.681], 13);
                L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
		    		maxZoom: 18,
		    		attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
		    			'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
		    			'Imagery © <a href="http://mapbox.com">Mapbox</a>',
		    		id: 'mapbox.streets'
		    	}).addTo(mymap);

                /* register the click event for
                 *  - setting the source and destination point coordinates
                 *  - showing the points markers
                */
                mymap.on('click', addMarker);
            </script>
        </div>
        
        <form action="resultPath" method="POST">
        	<input id="srcLat" name="srcLat" type="text" value="" hidden="true"/>
	        <input id="srcLng" name="srcLng" type="text" value="" hidden="true"/>
	        <input id="dstLat" name="dstLat" type="text" value="" hidden="true"/>
	        <input id="dstLng" name="dstLng" type="text" value="" hidden="true"/>
	        <input type="button" value="Calcola percorso" onclick="return submitForm(this.form);"/>
	        <input type="button" value="Cancella" onclick="return resetForm();"/>
        </form>
    </jsp:body>
    
    

</t:template>