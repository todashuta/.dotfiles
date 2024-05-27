javascript:(async () => {
	let name = prompt("Who are you?");
	if (name === null) return;
	if (!name) name = "nanashi";
	const msg = `Hello, ${name}!`;
	await navigator.clipboard.writeText(msg);
	alert(msg);
})();
