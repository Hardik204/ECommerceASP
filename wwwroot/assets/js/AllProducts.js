const queryParams = new URLSearchParams(window.location.search);
const pageIndex = parseInt(queryParams.get('pageIndex'));
document.querySelector("#pageNumber").textContent = ` ${pageIndex} `;

const url = new URL('https://65280d15931d71583df1ccd0.mockapi.io/ProductsList');
url.searchParams.append('completed', false); //https://65280d15931d71583df1ccd0.mockapi.io/ProductsList?completed=false
url.searchParams.append('page', pageIndex); //https://65280d15931d71583df1ccd0.mockapi.io/ProductsList?completed=false&page=1
url.searchParams.append('limit', 12); //https://65280d15931d71583df1ccd0.mockapi.io/ProductsList?completed=false&page=1&limit=10

fetch(url, {
        method: "GET",
        headers: { "content-type": "application/json" },
    })
        .then((res) => {
            if (res.ok) {
                return res.json();
            }
            // handle error
        })
        .then((tasks) => {
            // Do something with the list of tasks
            tasks.forEach(element => {
                console.log(element);
                makeCard(element);
                //document.querySelector(".allProducts").append(product);
            });
        })
        .catch((error) => {
            // handle error
            console.log(error);
            alert("Error occured while fetching the data from api. Please reload.");
        });

    function makeCard(object) {
        //console.log(object);
        // //create card element
        // var card = document.createElement("div");
        // card.classList.add("card");

        // //create card header element
        // var cardImageDiv = document.createElement("div");
        // cardImageDiv.classList.add("card-img");
        // var cardImg = document.createElement("img");
        // cardImg.setAttribute("height","210px");
        // cardImg.setAttribute("src", object['ProductImage']);
        // cardImg.setAttribute("alt", object['ProductName']);
        // cardImageDiv.append(cardImg);

        // //create card body element
        // var cardBodyDiv = document.createElement("div");
        // cardBodyDiv.classList.add("make-flex");
        // cardBodyDiv.classList.add("card-body");
        // var productNameDiv = document.createElement("div");
        // productNameDiv.textContent = object['ProductName'];
        // productNameDiv.classList.add("product-name");
        // var productPriceDiv = document.createElement("div");
        // productPriceDiv.classList.add("product-price");
        // var buyersNoSmall = document.createElement("small");
        // buyersNoSmall.classList.add("buyers-no");
        // buyersNoSmall.textContent = object['Buyers'];
        // productNameDiv.append(buyersNoSmall);
        // cardBodyDiv.append(productNameDiv);
        // cardBodyDiv.append(productPriceDiv);

        // //create card footer element
        // var cardFooterDiv = document.createElement("div");
        // cardFooterDiv.classList.add("make-flex");
        // cardFooterDiv.classList.add("card-footer");
        // var viewProductUrl = document.createElement("a");
        // viewProductUrl.text = "View Product";
        // viewProductUrl.setAttribute("href", "SelectProduct.html?id=" + object['id']);
        // cardFooterDiv.append(viewProductUrl);

        // // Merge into card
        // card.append(cardImageDiv);
        // card.append(cardBodyDiv);
        // card.append(cardFooterDiv);
        // document.querySelector(".allProducts").append(card);


        const card = `<div class="card">
                        <div class="card-img">
                          <img src="${object["ProductImage"]}" alt="image" height="250px">
                        </div>
                        <div class="make-flex card-body">
                          <div class="product-name">${object["ProductName"]}<br/><small class="buyers-no"> ${object["Buyers"]} users bougth this item.</small></div>
                          <div class="product-price">Rs.${object["ProductPrice"]}</div>
                        </div>
                        <div class="make-flex card-footer">
                          <a href="selectProduct.html?id=${object["id"]}">View Product</a>
                        </div>
                      </div>`;
        // console.log(card);
        console.log(document.querySelector(".allProducts"));
        // console.log(typeof card);
        document.querySelector(".allProducts").insertAdjacentHTML("beforeend",card);
    }


    document.querySelector("#nextPage").addEventListener("click",function(){
        window.open("AllProducts.html?pageIndex="+(pageIndex + 1));
    })

    document.querySelector("#previousPage").addEventListener("click",function(){
        window.open("AllProducts.html?pageIndex="+(pageIndex - 1));
    })