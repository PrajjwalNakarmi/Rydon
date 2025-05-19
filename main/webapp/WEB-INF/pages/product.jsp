<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rydon - Rent a Bike</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />   
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Include header -->
    <jsp:include page="header.jsp" />

    <!-- Banner with Embedded Search -->
    <section class="rent-banner">
        <h1>Find Your Perfect Ride</h1>
        <p>Choose from the best bikes, customize your ride, and enjoy your journey!</p>
        
        <div class="banner-search">
		    <div class="search-container">
		        <input type="text" id="searchInput" placeholder="Search bikes by name..." />
		    </div>
		</div>
    </section>

    <!-- Bike Cards -->
	   <section class="bike-list">
	
	    <!-- Bike Card Template -->
	    <div class="bike-card">
	        <div class="bike-card-image">
	            <img src="${pageContext.request.contextPath}/resources/images/citybike.jpg" alt="City Bike">
	            
	        </div>
	        <div class="bike-card-content">
	            <h2>City Bike</h2>
	            <p>Perfect for commuting, errands, and leisure rides around the city.</p>
	            <div class="rental-options">
	                <label>Rental Duration:</label>
	                <select>
	                    <option>1 Hour - $5</option>
	                    <option>3 Hours - $12</option>
	                    <option>6 Hours - $20</option>
	                    <option>Full Day - $30</option>
	                </select>
	            </div>
	            <a href="#" class="rent-now">Rent Now</a>
	        </div>
	    </div>
	
	    <div class="bike-card">
	        <div class="bike-card-image">
	            <img src="${pageContext.request.contextPath}/resources/images/ebike.jpg" alt="E-Bike">
	            
	        </div>
	        <div class="bike-card-content">
	            <h2>E-Bike</h2>
	            <p>Electric boost for longer rides — no sweat even on steep roads!</p>
	            <div class="rental-options">
	                <label>Rental Duration:</label>
	                <select>
	                    <option>1 Hour - $8</option>
	                    <option>3 Hours - $20</option>
	                    <option>6 Hours - $35</option>
	                    <option>Full Day - $50</option>
	                </select>
	            </div>
	            <a href="#" class="rent-now">Rent Now</a>
	        </div>
	    </div>
	
	    <div class="bike-card">
	        <div class="bike-card-image">
	            <img src="${pageContext.request.contextPath}/resources/images/mbike.webp" alt="Mountain Bike">
	            
	        </div>
	        <div class="bike-card-content">
	            <h2>Mountain Bike</h2>
	            <p>For adventurers and thrill seekers — rugged trails are no match!</p>
	            <div class="rental-options">
	                <label>Rental Duration:</label>
	                <select>
	                    <option>3 Hours - $15</option>
	                    <option>6 Hours - $25</option>
	                    <option>Full Day - $40</option>
	                    <option>2 Days - $70</option>
	                </select>
	            </div>
	            <a href="#" class="rent-now">Rent Now</a>
	        </div>
	    </div>
	
	    <div class="bike-card">
	        <div class="bike-card-image">
	            <img src="${pageContext.request.contextPath}/resources/images/roadbike.jpg" alt="Road Bike">
	            
	        </div>
	        <div class="bike-card-content">
	            <h2>Road Bike</h2>
	            <p>Lightweight and fast — ideal for long distances and smooth roads.</p>
	            <div class="rental-options">
	                <label>Rental Duration:</label>
	                <select>
	                    <option>2 Hours - $10</option>
	                    <option>6 Hours - $22</option>
	                    <option>Full Day - $35</option>
	                </select>
	            </div>
	            <a href="#" class="rent-now">Rent Now</a>
	        </div>
	    </div>
	
	    <div class="bike-card">
		    <div class="bike-card-image">
		        <img src="${pageContext.request.contextPath}/resources/images/hybrid.jpeg" alt="Hybrid Bike">
		        
		    </div>
		    <div class="bike-card-content">
		        <h2>Hybrid Bike</h2>
		        <p>Best of both worlds — smooth on roads, reliable off-road.</p>
		        <div class="rental-options">
		            <label>Rental Duration:</label>
		            <select>
		                <option>3 Hours - $14</option>
		                <option>6 Hours - $26</option>
		                <option>Full Day - $38</option>
		            </select>
		        </div>
		        <a href="#" class="rent-now">Rent Bike</a>
		    </div>
		</div>
	
	    <div class="bike-card">
	        <div class="bike-card-image">
	            <img src="${pageContext.request.contextPath}/resources/images/cruiser.jpg" alt="Cruiser Bike">
	            
	        </div>
	        <div class="bike-card-content">
	            <h2>Cruiser Bike</h2>
	            <p>Laid-back comfort and style — great for beach and boardwalk rides.</p>
	            <div class="rental-options">
	                <label>Rental Duration:</label>
	                <select>
	                    <option>1 Hour - $6</option>
	                    <option>3 Hours - $14</option>
	                    <option>Full Day - $28</option>
	                </select>
	            </div>
	            <a href="#" class="rent-now">Rent Now</a>
	        </div>
	    </div>
	
	    
	
	</section>


    <script>
        const searchInput = document.getElementById('searchInput');
        searchInput.addEventListener('input', function () {
            const value = this.value.toLowerCase().trim();
            const cards = document.querySelectorAll('.bike-card');

            cards.forEach(card => {
                const title = card.querySelector('h2').textContent.toLowerCase();
                const keywords = title.split(" ");
                const match = keywords.some(word => word.startsWith(value)) || title.includes(value);
                card.style.display = match || value === '' ? 'flex' : 'none';
            });
        });
    </script>

	  <!-- Include footer -->
    <jsp:include page="footer.jsp" />

</body>
</html>
