function onClickedNavigationButton(element) {
  // 仮
  element.classList.toggle("active");
  let navigation = document.getElementById("navigation");
  navigation.classList.toggle("fadeIn");
  navigation.classList.toggle("fadeOut");
}
