function onClickedNavigationButton(element) {
  // 仮
  element.classList.toggle("active");
  let navigation = document.getElementById("navigation");
  if(navigation.classList.length > 0) {
    navigation.classList.toggle("fadeIn");
    navigation.classList.toggle("fadeOut");
  }
  else {
    navigation.classList.add("fadeIn");
  }
}
