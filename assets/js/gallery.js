(function () {
	"use strict";

	var stream = document.getElementById("stream");
	if (!stream) { return; }

	// Items arrive flat, in the row-major interleaved sequence rendered by the
	// home layout. Their order is the display order at any column count.
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

		stream.innerHTML = "";
		var cols = [];
		for (var i = 0; i < n; i++) {
			var col = document.createElement("div");
			col.className = "stream__col";
			stream.appendChild(col);
			cols.push(col);
		}

		items.forEach(function (item, i) {
			// At 4 columns, honor the curated column from _data/gallery.yml
			// (data-col) so the YAML is reproduced exactly even when its
			// columns have unequal lengths; otherwise deal round-robin.
			var target = n === 4 ? (parseInt(item.getAttribute("data-col"), 10) - 1) : (i % n);
			cols[target].appendChild(item);
		});

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
