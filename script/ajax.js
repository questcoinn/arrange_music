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