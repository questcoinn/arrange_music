// left
window.onload = () => {
    const { year, month, feed } = initCal();
    checkCal(year, month, feed);
}

document.querySelector("select#year").addEventListener("change", (e) => {
    const { year, month, feed } = initCal();
    checkCal(year, month, feed);
});

document.querySelector("select#month").addEventListener("change", (e) => {
    const { year, month, feed } = initCal();
    checkCal(year, month, feed);
});

const initCal = () => {
    const year  = document.querySelector("select#year").value;
    const month = document.querySelector("select#month").value;
    const feed = document.querySelector("div#feed");
    
    document.querySelector("article#calendar-info").innerHTML = "";

    return { year: year, month: month, feed: feed }
}

const checkCal = async (year, month, el) => {
    const _response = await thismonth(year, month);
    const response = _response.trim()
    
    el.innerHTML = response;
}

// right
document.body.addEventListener("click", (e) => {
    const validList = [ "album", "artist", "title" ];
    const className = e.target.className;

    if(validList.includes(className)){
        const container = className === "album" ? e.target : e.target.parentElement;

        const artist = container.querySelector("span.artist").innerHTML;
        const title  = container.querySelector("span.title").innerHTML;
        
        const articleEl = document.querySelector("article#calendar-info");
        //articleEl.style.overflow = "scroll";

        checkArt(artist, title, articleEl);
    }
});

const checkArt = async (artist, title, el) => {
    const _response = await showdetails(artist, title);
    const response = _response.trim()
    
    el.innerHTML = response;
}