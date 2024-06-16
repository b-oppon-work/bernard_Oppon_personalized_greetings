// Get the name from the URL path (e.g., /JohnDoe)
const pathParts = window.location.pathname.split('/');
const name = pathParts[1]; // Extract the name from the second part

// Get the current hour (0-23)
const currentHour = new Date().getHours();

// Determine the greeting based on the time
let greeting = "";
if (currentHour < 12) {
  greeting = "Good morning";
} else if (currentHour < 18) {
  greeting = "Good afternoon";
} else {
  greeting = "Good evening";
}

// Display the personalized greeting
document.getElementById("greeting").textContent = `${greeting}, ${name}!`;
