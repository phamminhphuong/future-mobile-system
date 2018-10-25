function myFunction() {
  document.getElementById("dropmenu").classList.toggle("show");
}
function myFunction1() {
  document.getElementById("dropmenu1").classList.toggle("show");
}
window.onclick = function(event) {
  if (!event.target.matches('.pop-hover-title')) {
    var dropdowns = document.getElementsByClassName("dropdown-menu");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
