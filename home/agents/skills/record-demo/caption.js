(() => {
  const key = "__demo_caption";

  const render = (text, position) => {
    let bar = document.getElementById(key);
    if (!bar) {
      bar = document.createElement("div");
      bar.id = key;
      bar.setAttribute("aria-hidden", "true");
      bar.style.cssText =
        "position:fixed;left:50%;transform:translateX(-50%);z-index:2147483647;" +
        "pointer-events:none;padding:10px 20px;border-radius:10px;" +
        "background:rgba(17,17,17,.85);color:#fff;font:500 18px/1.4 system-ui,sans-serif;" +
        "max-width:80vw;text-align:center";
      document.documentElement.appendChild(bar);
    }
    bar.style.top = position === "top" ? "32px" : "";
    bar.style.bottom = position === "top" ? "" : "32px";
    bar.textContent = text;
    bar.hidden = !text;
  };

  window.__caption = (text, position = "bottom") => {
    sessionStorage.setItem(key, JSON.stringify({ text, position }));
    render(text, position);
  };

  const restore = () => {
    const saved = JSON.parse(sessionStorage.getItem(key) || "null");
    if (saved) render(saved.text, saved.position);
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", restore);
  } else {
    restore();
  }
})();
