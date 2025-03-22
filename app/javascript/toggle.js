console.log("toggle.jsおk");
document.addEventListener("DOMContentLoaded", () => {
  const icon = document.getElementById("search_toggle")
  const form = document.getElementById("search_form")

  if (icon && form) {
    icon.addEventListener("click",() => {
      form.style.display = form.style.display === "none" ? "block" : "none";
    });
  }
});