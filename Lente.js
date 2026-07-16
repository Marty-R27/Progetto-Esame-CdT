const imageBox = document.querySelector("#image-zoomer-box");
const magnified = document.querySelector("#img-2");

function handleMouseMoves(e){
  if (!document.body.classList.contains("lens-mode")) return;
  const box= imageBox.getBoundingClientRect();
  const x= e.clientX - box.left;
  const y= e.clientY - box.top;


  const xPercent= (x/box.width)*100;
  const yPercent= (y/box.height)*100;

  magnified.style.left = `${x - magnified.offsetWidth / 2.5}px`;
  magnified.style.top = `${y - magnified.offsetHeight/ 2.5}px`;

  magnified.style.backgroundPosition = `${xPercent}% ${yPercent}%`;
}

imageBox.addEventListener("mousemove", handleMouseMoves);





const toggleBtn = document.querySelector("#mode-toggle");

toggleBtn.addEventListener("click", () => {
  document.body.classList.toggle("lens-mode");
  const isLens = document.body.classList.contains("lens-mode");
  toggleBtn.textContent = isLens ? "🔗" : "🔍";
});