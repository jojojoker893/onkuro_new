document.addEventListener("turbo:load", () => {
  const flashMessages = document.querySelectorAll(".flash");

  flashMessages.forEach((flash) => {
    setTimeout(() => {
      flash.classList.add("fade"); // フェードアウトを適用
      setTimeout(() => flash.remove(), 500); // フェードアウト後に削除
    }, 1000);
  });
});
