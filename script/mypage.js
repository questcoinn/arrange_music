document.querySelector("input#open-btn").addEventListener("click", (e) => {
    const self = e.target;
    const box  = document.querySelector("div#heard-box");
    
    self.style.animation = "disappear 1s";
    box.style.animation = "down 1s";

    self.style.opacity = "0";
    box.style.maxHeight = "none";
    box.style.boxShadow = "";
    box.style.marginBottom = "none";

    setTimeout(() => {
        self.parentElement.removeChild(self);
        box.style.animation = "";
    }, 1000);
});

if(document.querySelector("div#heard-box").children.length > 5) {
    document.querySelector("div#heard-box").style.boxShadow = "inset 0px -35px 10px -18px #ccc";
}