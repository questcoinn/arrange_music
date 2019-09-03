/*const myImage = document.createElement('img');

const myRequest = new Request('/images/nothing.png');

fetch(myRequest)
.then(response => response.blob())
.then(function(myBlob) {
  var objectURL = URL.createObjectURL(myBlob);
  myImage.src = objectURL;
  URL.revokeObjectURL(myBlob);
});

document.body.appendChild(myImage);*/

/*const type = "image/png";

fetch("imgtobinary.jsp")
    .then((res) => {
        res.text().then((text) => {
            let binary = text.split(" ").map(x => parseInt(x));
            binary = new Uint8Array(binary);
            return new Blob([binary], { type: type });

        }).then((myBlob) => {
            const url = URL.createObjectURL(myBlob);
            const img = document.createElement("img");
            img.src = url;
            document.body.appendChild(img);
            URL.revokeObjectURL(myBlob);
        });
    });*/

const option = {
    type: "image/png",
    file: "nothing.png"
}

const getBlob = async (option) => {
    const response = await fetch(`imgtobinary.jsp?file=${option.file}`);
    
    let binary = await response.text();
    binary = binary.split(" ").map(x => parseInt(x));
    binary = new Uint8Array(binary);

    return new Blob([binary], { type: option.type });
}

getBlob(option).then((myBlob) => {
    const url = URL.createObjectURL(myBlob);
    const img = document.createElement("img");
    img.src = url;
    document.body.appendChild(img);
    URL.revokeObjectURL(myBlob);
});