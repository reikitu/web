function createMemberList(_jsonText) {
	let target = document.getElementById("memberList");
	_jsonText.forEach(data => {
		let parallax = document.createElement("div");
		parallax.classList.add("parallax");
		target.appendChild(parallax);

		let h2 = document.createElement("h2");
		h2.style.textAlign = "center";
		h2.textContent = data.name;
		parallax.appendChild(h2);

		let content = document.createElement("div");
		content.classList.add("parallax_content");
		parallax.appendChild(content);
		let p = document.createElement("p");
		p.style.textAlign = "left";
		p.innerText = data.message;
		content.appendChild(p);

		let filename = data.filename ? data.filename : "no_image";
		let img = document.createElement("img");
		img.src = "img/member/" + filename + ".png";
		//img.src = "https://drive.google.com/uc?export=view&id=" + _data.ImageID + "&usp=sharing";
		parallax.appendChild(img);
	});
}
