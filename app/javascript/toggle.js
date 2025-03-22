document.addEventListener("turbo:load", () => {
  const icon = document.getElementById("search-toggle")
  const form = document.getElementById("search-form")

  if (icon && form) {
    icon.addEventListener("click",() => {
      form.classList.toggle("toggle-vision")
      form.classList.toggle("toggle-hidden")
    });
  }
});