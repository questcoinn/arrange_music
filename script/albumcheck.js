document.querySelector("input#submit").addEventListener("click", (e) => {
    e.preventDefault();

    const artist = document.querySelector("input#artist-in").value;
    const title  = document.querySelector("input#title-in").value;
    const date   = document.querySelector("input#date-in").value;

    const exceptions = {
        "null_artist": artist === "",
        "null_title": title === "",
        "null_date": date === "",
    }

    if(exceptions.null_artist) {
        alert("아티스트를 입력하세요.");
    } else if(exceptions.null_title) {
        alert("앨범이름을 입력하세요.");
    } else if(exceptions.null_date) {
        alert("발매일을 입력하세요.");
    } else {
        const form = document.querySelector("main form");
        check(artist, title, form);
    }
});

const check = async (artist, title, form) => {
    const _response = await checkAlbum(artist, title);
    const response = _response.trim()
    
    if(response === "failed_con") {
        alert("서버에 문제가 있습니다.");

    } else if(response === "failed_exist") {
        alert("이미 존재하는 앨범입니다.");

    } else if(response === "successed") {
        form.requestSubmit();

    } else {
        alert("알 수 없는 오류");
    }
}