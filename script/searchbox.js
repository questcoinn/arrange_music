document.querySelector("input#toggle-size").addEventListener("click", (e) => {
    if(e.target.tsize === undefined) e.target.tsize = 0;

    const form = e.target.parentElement;

    if(e.target.tsize === 0) {
        form.id = "big";
        e.target.value = "작게";
        e.target.tsize = 1;
        
    } else if(e.target.tsize === 1) {
        form.id = "";
        e.target.value = "크게";
        e.target.tsize = 0;
    }
});