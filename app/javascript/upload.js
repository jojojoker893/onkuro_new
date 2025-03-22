document.addEventListener("turbo:load", () => {
  const uploadZone = document.getElementById("uploadContainer");
  const input = document.getElementById("imageInput");

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
    e.preventDefault();
    input.files = e.dataTransfer.files;
  });
});