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

(function () {
	"use strict";

	// "..." button in the menu bar: opens the list of extra menu entries
	// (`extra: true` in _data/menu.yml). Closes on a click outside or Escape.
	var more = document.querySelector(".menu__more-toggle");
	var list = document.getElementById("menu-extra");
	if (!more || !list) { return; }

	function setOpen(open) {
		list.classList.toggle("is-open", open);
		more.setAttribute("aria-expanded", open ? "true" : "false");
	}

	more.addEventListener("click", function (e) {
		e.stopPropagation();
		setOpen(!list.classList.contains("is-open"));
	});
	document.addEventListener("click", function (e) {
		if (!list.contains(e.target)) { setOpen(false); }
	});
	document.addEventListener("keydown", function (e) {
		if (e.key === "Escape") { setOpen(false); }
	});
})();
