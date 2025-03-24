document.addEventListener("turbo:load", () => {
  toggleVisialize("search-button", "search-form");
  toggleVisialize("filter-button", "filter-form");

  function toggleVisialize(buttonId, targetId) {
    const btn = document.getElementById(buttonId)
    const target = document.getElementById(targetId)

    if (btn && target) {
      btn.addEventListener("click", () => {
        target.classList.toggle("hidden");
      });
    }
  }
});