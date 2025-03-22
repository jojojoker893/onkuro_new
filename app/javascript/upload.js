document.addEventListener("turbo:load", () => {
  const uploadZone = document.getElementById("uploadContainer");

  ["dragenter", "dragover"].forEach(eventName => {
    uploadZone.addEventListener(eventName, (e) => {
      e.preventDefault();
      uploadZone.classList.add("dragover");
    });
  });

  ["dragleave", "drop"].forEach(eventName => {
    uploadZone.addEventListener(eventName, (e) => {
      e.preventDefault();
      uploadZone.classList.remove("dragover")
    });
  });

  uploadZone.addEventListener("drop", (e) => {
  });
})