var history = %@;
var links = document.links;

for (i = 0; i < links.length; i++) {
	link = links[i];
	href = link.href

	if(history.indexOf(href) != -1) {
		link.style.backgroundColor = "yellow";
	}
}