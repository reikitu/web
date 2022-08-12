function createMemberList(_jsonText) {
	let target = document.getElementById("memberList");
	_jsonText.forEach(data => {
		let parallax = document.createElement("div");
		parallax.classList.add("parallax");
		target.appendChild(parallax);

		let name = document.createElement("h2");
		name.style.textAlign = "center";
		name.textContent = data.name;
		parallax.appendChild(name);

		let content = document.createElement("div");
		content.classList.add("parallax_content");
		parallax.appendChild(content);
		let p = document.createElement("p");
		p.style.textAlign = "left";
		p.innerText = data.message;
		content.appendChild(p);

		let img = document.createElement("img");
		let filename = data.filename ? data.filename : "no_image";
		img.src = "img/member/" + filename + ".png";
		//img.src = "https://drive.google.com/uc?export=view&id=" + _data.ImageID + "&usp=sharing";
		parallax.appendChild(img);
	});
}
