document.addEventListener("turbo:load", () => {
  toggleVisialize("search-toggle", "search-form");
  toggleVisialize("filter-toggle", "filter-form");

  function toggleVisialize(toggleId, formId) {
    const toggle = document.getElementById(toggleId);
    const form = document.getElementById(formId);

    if(toggle && form) {
      toggle.addEventListener("click", () => {
        form.classList.toggle("toggle-vision");
        form.classList.toggle("toggle-hidden");
      });
    }
  }
});