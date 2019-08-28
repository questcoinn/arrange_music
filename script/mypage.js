document.querySelector("input#open-btn").addEventListener("click", (e) => {
    const self = e.target;
    const box  = document.querySelector("div#heard-box");
    
    self.style.animationName = "disappear";
    self.style.animationDuration = "1s";
    box.style.animationName = "down";
    box.style.animationDuration = "1s";

    self.style.opacity = "0";
    box.style.maxHeight = "none";
    box.style.boxShadow = "none";
    box.style.marginBottom = "none";

    setInterval(() => {
        e.target.parentElement.removeChild(e.target);
    }, 2000);
});

if(document.querySelector("div#heard-box").children.length > 5) {
    document.querySelector("div#heard-box").style.boxShadow = "inset 0px -35px 10px -18px #ccc";
}