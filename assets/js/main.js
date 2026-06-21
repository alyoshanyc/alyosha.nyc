(function () {
	"use strict";

	var toggle = document.querySelector(".nav-toggle");
	var nav = document.getElementById("primary-nav");
	if (!toggle || !nav) { return; }

	toggle.addEventListener("click", function () {
		var open = nav.classList.toggle("is-open");
		toggle.setAttribute("aria-expanded", open ? "true" : "false");
		toggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
	});

	// Close the menu when a link is tapped (mobile).
	nav.addEventListener("click", function (e) {
		if (e.target.tagName === "A" && nav.classList.contains("is-open")) {
			nav.classList.remove("is-open");
			toggle.setAttribute("aria-expanded", "false");
		}
	});
})();
