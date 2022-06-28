function loadJson() {
	let req = new XMLHttpRequest();
	req.open("get", "https://script.google.com/macros/s/AKfycbyb_DTouvJUwprOABBc6E9SJFzQOo9xdUZ_pFn-bj9b5M7MfzxcZfTB-scFPZx_-2wW/exec?type=syureneko", true);
	req.send();
	req.onreadystatechange = function () {
		// サーバーからのレスポンスが完了し、かつ、通信が正常に終了した場合
		if (req.readyState == 4 && req.status == 200) {
			let json = JSON.parse(req.responseText);
			createMemberList(json);
			createComment(json.length);
		}
	}
}

function createMemberList(_jsonText) {
	let target = document.getElementById("memberList");
	const titles = ["リーダー", "マネージャー", "コモンメンバー", "ビジター"];
	let div = document.createElement("div");
	div.classList.add("article");
	target.appendChild(div);
	let views = titles.map(title => createView(div, title));
	_jsonText.forEach(data => {
		let index = titles.indexOf(data.type);
		if (index >= 0) {
			createPanel(views[index], data.name, data.path);
			this._memberCount++;
		}
	});
	views.forEach(view => {
		if (view.children.length <= 0) {
			createPanel(view, "この役職のメンバはいません。", "");
		}
	});
}

function createView(_parent, _title) {
	let h2 = document.createElement("h2");
	h2.classList.add("article-title");
	h2.textContent = _title;
	_parent.appendChild(h2);
	let div = document.createElement("div");
	div.classList.add("content");
	_parent.appendChild(div);
	return div;
}

function createPanel(_parent, _name, _path) {
	let panel = document.createElement("div");
	panel.classList.add("character_panel");
	_parent.appendChild(panel);
	let h3 = document.createElement("h3");
	h3.textContent = _name;
	panel.appendChild(h3);
	if (_path) {
		let imgDiv = document.createElement("div");
		imgDiv.classList.add("character_image");
		panel.appendChild(imgDiv);
		let img = document.createElement("img");
		img.src = "image/character/" + _path;
		imgDiv.appendChild(img);
	}
}

function createComment(_count) {
	let target = document.getElementById("comment");
	let p = document.createElement("p");
	p.textContent = "現在チームメンバは" + _count + "人です。";
	target.appendChild(p);
}

loadJson();