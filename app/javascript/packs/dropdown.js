// ドロップダウンメニューのトグル機能を追加
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector(".dropbtn").addEventListener("click", function() {
    var dropdownContent = this.nextElementSibling;
    dropdownContent.style.display = dropdownContent.style.display === "block" ? "none" : "block";
  });
  // クリックがドロップダウン以外で発生した場合にドロップダウンを閉じる
  window.addEventListener("click", function(event) {
    if (!event.target.matches('.dropbtn')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      for (var i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.style.display === "block") {
          openDropdown.style.display = "none";
        }
      }
    }
  });
});
