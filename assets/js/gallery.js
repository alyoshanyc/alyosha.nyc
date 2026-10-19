(function () {
	"use strict";

	var stream = document.getElementById("stream");
	if (!stream) { return; }

	// Items arrive flat, in the row-major interleaved sequence rendered by
	// _includes/stream.html. Their order is the display order at any column count.
	var items = Array.prototype.slice.call(stream.querySelectorAll(".stream__item"));
	var current = 0;

	function columnCount() {
		var w = window.innerWidth;
		if (w >= 1280) { return 4; }
		if (w >= 960) { return 3; }
		if (w >= 640) { return 2; }
		return 1;
	}

	function deal() {
		var n = columnCount();
		if (n === current) { return; }
		current = n;

		// Work out every item's column first, and only then touch the page:
		// a bad target (for example a stale cached script meeting new markup)
		// falls back to round-robin instead of leaving the stream empty.
		var targets = items.map(function (item, i) {
			// At 4 columns, honor the column folder of each photo
			// (column-N, data-col) so the folders are reproduced exactly even
			// when columns have unequal lengths; else deal round-robin.
			var target = n === 4 ? (parseInt(item.getAttribute("data-col"), 10) - 1) : (i % n);
			return target >= 0 && target < n ? target : i % n;
		});

		stream.innerHTML = "";
		var cols = [];
		for (var i = 0; i < n; i++) {
			var col = document.createElement("div");
			col.className = "stream__col";
			stream.appendChild(col);
			cols.push(col);
		}
		items.forEach(function (item, i) { cols[targets[i]].appendChild(item); });

		stream.classList.add("stream--cols");
	}

	deal();
	window.addEventListener("resize", deal);

	// Photos past the eager budget (see _layouts/home.html) start transparent
	// and fade in once their lazy load finishes.
	items.forEach(function (item) {
		var img = item.querySelector(".stream__img--fade");
		if (!img) { return; }
		if (img.complete && img.naturalWidth > 0) {
			img.classList.add("is-loaded");
		} else {
			img.addEventListener("load", function () {
				img.classList.add("is-loaded");
			});
		}
	});
})();
