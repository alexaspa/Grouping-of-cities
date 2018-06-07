<%-- 
    Document   : index
    Author     : Alexandra Spanou, icsd09134
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,DB2_classes.*"%>

<head>
    <title>UotA DB2 Project</title>
    <link rel="icon" href="Images/logo.png">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
	  <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
	
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <!--Background img: -->
    <link href="css/demo.css" rel="stylesheet">
</head>
  <body>
        <% 
            if(request.getMethod().equals("POST")){
                String act = request.getParameter("act");
                if(act.equalsIgnoreCase("update")){
                    String id = request.getParameter("ID").toString();
                    String city = request.getParameter("City").toString();
                    String lat = request.getParameter("Latitude").toString();
                    String lon = request.getParameter("Longitude").toString();

                    if(Integer.parseInt(id) >= 1 && Integer.parseInt(id) <= 15 
                            && Float.parseFloat(lat) >= -90 && Float.parseFloat(lat) <= 90
                            && Float.parseFloat(lon) >= -180 && Float.parseFloat(lon) <= 180){
                        DataBaseConnection db = new DataBaseConnection();
                        boolean a = db.ConnectToDB();
                        //System.out.println("Connection: " + a);
                        
                        // update a row
                        String queryString = "update CityProject set name=? , Latitude=?, Longitude=? WHERE ID= '" + id + "'";
                        Connection conn = db.getConn();
                        //Statement statement = conn.createStatement();
                        PreparedStatement pstatement = conn.prepareStatement(queryString);
                        pstatement.setString(1, city);
                        pstatement.setFloat(2, Float.parseFloat(lat));
                        pstatement.setFloat(3, Float.parseFloat(lon));
                        pstatement.executeUpdate();
                        pstatement.close();
                        conn.close();
                    }
                }
                else if(act.equalsIgnoreCase("insert")){
                    String id1 = request.getParameter("ID1").toString();
                    String city = request.getParameter("City1").toString();
                    String lat = request.getParameter("Latitude1").toString();
                    String lon = request.getParameter("Longitude1").toString();
                    
                    DataBaseConnection db = new DataBaseConnection();
                    db.ConnectToDB();
                    Connection conn = db.getConn();
                    
                    try{
                        //insert:
                        String queryString = ("INSERT INTO CityProject VALUES(?,?,?,?)");
                        PreparedStatement pstatement = conn.prepareStatement(queryString);
                        pstatement.setString(1, id1);
                        pstatement.setString(2, city);
                        pstatement.setFloat(3, Float.parseFloat(lat));
                        pstatement.setFloat(4, Float.parseFloat(lon));
                        pstatement.executeUpdate();
                        pstatement.close();
                        conn.close();
                    }
                    catch(SQLIntegrityConstraintViolationException ex){}
                }
            }
        %>
    <div class="container">
        <header>
            <h1>University of the Aegean <span>Data Base 2 Project</span></h1>
                <a href="index.jsp"><img id="logo" class="center-block"  src = "Images/logo.png"></a>
                <br><br>
                <h1>Insert new <span>City</span></h1> 
        </header>
        <form action="index.jsp" method="POST">
            <label for="ID1" class="sr-only">ID1</label>
            <input type="ID1" name="ID1" id="ID" class="form-control" placeholder="ID acceptance values 1-15" autofocus>
            <label for="City1" class="sr-only">City1</label>
            <input type="City1" name="City1" id="City1" class="form-control" placeholder="City">
            <label for="Latitude1" class="sr-only">Latitude1</label>
            <input type="Latitude1" name="Latitude1" id="Latitude1" class="form-control" placeholder="Latitude">
            <label for="Longitude1" class="sr-only">Longitude1</label>
            <input type="Longitude1" name="Longitude1" id="Longitude1" class="form-control" placeholder="Longitude">
            </br>
            <div class="row">
                <div class="col-sm-4">
                    <button name="act"class="btn btn-lg btn-primary btn-block" value="insert" type="insert" onclick="">insert</button>
                </div>
            </div>   
        </form>
        
        <header><h1>Update a <span>City</span></h1></header>
        <form action="index.jsp" method="POST">
            <label for="ID" class="sr-only">ID</label>
            <input type="ID" name="ID" id="ID" class="form-control" placeholder="ID acceptance values 1-15">
            <label for="City" class="sr-only">City</label>
            <input type="City" name="City" id="City" class="form-control" placeholder="City">
            
            <label for="Latitude" class="sr-only">Latitude</label>
            <input type="Latitude" name="Latitude" id="Latitude" class="form-control" placeholder="Latitude">
            <label for="Longitude" class="sr-only">Longitude</label>
            <input type="Longitude" name="Longitude" id="Longitude" class="form-control" placeholder="Longitude">
            </br>
            <div class="row">
                <div class="col-sm-4">
                    <button name="act"class="btn btn-lg btn-primary btn-block" value="update" type="update" onclick="">update</button>
                </div>
            </div>   
        </form>
        <br><br>
        <header><h1>All<span> Cities</span></h1></header>
        <table style="width:100%">
            <tr>
              <th>ID</th>
              <th>City</th>
              <th>Latitude</th>
              <th>Longitude</th>
            </tr>
            <% 
                DataBaseConnection db = new DataBaseConnection();
                db.ConnectToDB();
                Connection conn = db.getConn();
                Statement statement = conn.createStatement();
                String select = "SELECT * FROM CityProject ORDER BY id";
                ResultSet result = statement.executeQuery(select);
                while (result.next()) {
                    out.print("<tr>"
                            + "<td>"+ result.getString(1) +"</td>"
                            + "<td>"+ result.getString(2) +"</td>"
                            + "<td>"+ result.getString(3) +"</td>"
                            + "<td>"+ result.getString(4) +"</td>"
                            + "</tr>");
                }
                conn.close();
                statement.close();
            %>
        </table> 
        
        <!-- Grouping -->
        <% 
            db.ConnectToDB();
            conn = db.getConn();
            String selectMaxID = "SELECT max(id) FROM CityProject";
            statement = conn.createStatement();
            result = statement.executeQuery(selectMaxID);
            float id = 16;
            while(result.next()){
                id = result.getFloat(1);
            }
            if(id>=15){
                String strProcedure="{call GroupingProcedure()}";
                CallableStatement cs=conn.prepareCall(strProcedure);
                cs.execute();
                conn.close();
            }
        %>
        <header><h1>Grouping</h1></header>
        <header><h1>Group<span> 1</span></h1></header>
        <table style="width:100%">
            <tr>
              <th>ID</th>
              <th>City</th>
              <th>Latitude</th>
              <th>Longitude</th>
            </tr>
            <% 
                db.ConnectToDB();
                conn = db.getConn();
                statement = conn.createStatement();
                String grp1 = "SELECT * FROM Group1 ORDER BY id";
                result = statement.executeQuery(grp1);
                while (result.next()) {
                    out.print("<tr>"
                            + "<td>"+ result.getString(1) +"</td>"
                            + "<td>"+ result.getString(2) +"</td>"
                            + "<td>"+ result.getString(3) +"</td>"
                            + "<td>"+ result.getString(4) +"</td>"
                            + "</tr>");
                }
                conn.close();
                statement.close();
            %>
        </table> 
        
        <header><h1>Group<span> 2</span></h1></header>
        <table style="width:100%">
            <tr>
              <th>ID</th>
              <th>City</th>
              <th>Latitude</th>
              <th>Longitude</th>
            </tr>
            <% 
                db.ConnectToDB();
                conn = db.getConn();
                statement = conn.createStatement();
                String grp2 = "SELECT * FROM Group2 ORDER BY id";
                result = statement.executeQuery(grp2);
                while (result.next()) {
                    out.print("<tr>"
                            + "<td>"+ result.getString(1) +"</td>"
                            + "<td>"+ result.getString(2) +"</td>"
                            + "<td>"+ result.getString(3) +"</td>"
                            + "<td>"+ result.getString(4) +"</td>"
                            + "</tr>");
                }
                conn.close();
                statement.close();
            %>
        </table> 
       <style>
        #map {
         height: 500px;
         width: 100%;
        }
        </style>
        <header><h1>Map<span> Markers</span></h1></header>
        <div id="map"></div>
        <script>
          
          function initMap() {
              var locations = [];
              <% 
                db.ConnectToDB();
                conn = db.getConn();
                statement = conn.createStatement();
                String select1 = "SELECT * FROM CityProject";
                result = statement.executeQuery(select1);
                while (result.next()) { %>
                    locations.push(['<% out.print(result.getString(2)); %>', <% out.print(result.getString(3)); %>, <% out.print(result.getString(4)); %>]);
                <%}
                conn.close();
                statement.close();
              %>    
 
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 3,
                center: new google.maps.LatLng(32.294270, -24.292578),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });

            var infowindow = new google.maps.InfoWindow();
            var marker, i;

            for (i = 0; i < locations.length; i++) {  
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                    map: map
                });

                google.maps.event.addListener(marker, 'click', (function(marker, i) {
                    return function() {
                        infowindow.setContent(locations[i][0]);
                        infowindow.open(map, marker);
                    };
                })(marker, i));
            }
          }
        </script>
        <script
        src="https://maps.googleapis.com/maps/api/js?key= token">
        </script>
    </div> <!-- /container -->
</html>
