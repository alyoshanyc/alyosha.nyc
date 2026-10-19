(function () {
	"use strict";

	var stream = document.getElementById("stream");
	if (!stream) { return; }

	// Items arrive flat, in the row-major interleaved sequence rendered by the
	// home layout. Their order is the display order at any column count.
	var items = Array.prototype.slice.call(stream.querySelectorAll(".stream__item"));
	var current = 0;
	var byColumn = stream.getAttribute("data-order") === "columns";

	// Height of each tile per unit of column width (data-ratio = height/width).
	// A tile without a ratio counts as square.
	var heights = items.map(function (item) {
		return parseFloat(item.getAttribute("data-ratio")) || 1;
	});

	// Split the sequence into n consecutive runs (one per column, read top to
	// bottom) so the column heights come out as even as possible: dynamic
	// programming over the break points, minimizing the sum of squared column
	// heights. Returns the column index of each item.
	function balancedColumns(n) {
		var len = heights.length;
		n = Math.min(n, len);
		var prefix = [0];
		heights.forEach(function (h, i) { prefix.push(prefix[i] + h); });
		// cost[k][j]: best cost of the first j items in k columns; cut[k][j]: start of column k.
		var cost = [], cut = [];
		for (var k = 0; k <= n; k++) { cost.push([]); cut.push([]); }
		cost[0][0] = 0;
		for (var j = 1; j <= len; j++) { cost[0][j] = Infinity; }
		for (k = 1; k <= n; k++) {
			for (j = 0; j <= len; j++) {
				cost[k][j] = Infinity;
				for (var i = k - 1; i < j; i++) {
					var h = prefix[j] - prefix[i];
					var c = cost[k - 1][i] + h * h;
					if (c < cost[k][j]) { cost[k][j] = c; cut[k][j] = i; }
				}
			}
		}
		var target = new Array(len);
		for (k = n, j = len; k > 0; k--) {
			for (i = cut[k][j]; i < j; i++) { target[i] = k - 1; }
			j = cut[k][j];
		}
		return target;
	}

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
		var balanced = byColumn ? balancedColumns(n) : null;
		var targets = items.map(function (item, i) {
			// Themed galleries (data-order="columns") read down each column,
			// with the breaks balanced by height (see balancedColumns).
			// Otherwise, at 4 columns, honor the curated column from
			// _data/home.yml (data-col) so the YAML is reproduced exactly
			// even when its columns have unequal lengths; else deal round-robin.
			var target;
			if (byColumn) {
				target = balanced[i];
			} else {
				target = n === 4 ? (parseInt(item.getAttribute("data-col"), 10) - 1) : (i % n);
			}
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
