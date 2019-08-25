// signin.js
const checkExistingId = (str) => {
    const xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.querySelector("div#uid p.info").innerHTML = this.responseText;
        }
    };

    xhttp.open("GET", "/auth/signcheck.jsp?val=" + str, true);
    xhttp.send();
}

// logincheck.js
const checkId = (uid, upwd) => {
    return new Promise((resolve, reject) => {
        const xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                resolve(this.responseText);
            }
        }

        xhttp.open("GET", `/auth/idcheck.jsp?uid=${uid}&upwd=${upwd}`, true);
        xhttp.send();
    });
}

// albumcheck.js
const checkAlbum = (artist, title) => {
    return new Promise((resolve, reject) => {
        const xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                resolve(this.responseText);
            }
        }

        xhttp.open("GET", `/db/albumcheck.jsp?artist=${artist}&title=${title}`, true);
        xhttp.send();
    });
}

// albumbtns.js
const thumbsup = (uid, artist, title) => {
    return new Promise((resolve, reject) => {
        const xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                resolve(this.responseText);
            }
        };

        xhttp.open("GET", `/user/recommend.jsp?uid=${uid}&artist=${artist}&title=${title}`, true);
        xhttp.send();
    })
}

// albumbtns.js
const heardthis = (uid, artist, title) => {
    return new Promise((resolve, reject) => {
        const xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                resolve(this.responseText);
            }
        };

        xhttp.open("GET", `/user/heard.jsp?uid=${uid}&artist=${artist}&title=${title}`, true);
        xhttp.send();
    })
}