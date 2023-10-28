//const queryParams = new URLSearchParams(window.location.search);
//const id = queryParams.get('id');

//fetch('https://65280d15931d71583df1ccd0.mockapi.io/ProductsList/'+id, {
//  method: 'GET',
//  headers: {'content-type':'application/json'},
//}).then(res => {
//  if (res.ok) {
//      return res.json();
//  }
//  // handle error
//}).then(tasks => {
//  // Do something with the list of tasks
//  setDetails(tasks);
//}).catch(error => {
//  // handle error
//  alert("Unable to fetch API. Please reload.");
//})

//function setDetails(object){
//    const productImg = document.querySelector(".product-img");
//    const productName = document.querySelector(".product-name");
//    const productPrice = document.querySelector(".product-price");
//    const productDescription = document.querySelector('.product-description');
//    const productSeller = document.querySelector('.product-seller');
    
//    productImg.setAttribute("src",object['ProductImage']);
//    productImg.setAttribute("alt",object['ProductName']);

//    productName.textContent += object['ProductName'];
//    let newPrice = parseInt(object['ProductPrice']);
//    newPrice -= (newPrice * 0.1);
//    productPrice.innerHTML += `₹ <del> ${object['ProductPrice']} </del> &nbsp ${newPrice}`;
//    productDescription.textContent = object['Description'];
//    productSeller.textContent += object['Seller'];

//    for(let i=1 ; i<=3 ; i++){
//        let item = `<div class="review">
//                        <div class="make-flex card-img">
//                            <img class="reviewer-img" src=${object["ReviewerImg"+i]} height='200px'  />
//                        </div>
//                        <div class="review-content">
//                            <h4 class="reviewer-name">${object["Reviewer"+i]}</h4>
//                            <p class="review-description">${object['Review'+i]}</p>
//                        </div>
//                    </div>`;
//        document.querySelector(".reviews-list").insertAdjacentHTML("beforeend",item);
//    }
//}

var buyQuantityTag =  document.querySelector(".quantity-value");

document.querySelector(".quantity-up").addEventListener("click",function(){
    let quantity = parseInt(buyQuantityTag.textContent);
    console.log(typeof quantity);
  if(quantity <= 10)
    buyQuantityTag.textContent = quantity + 1;
  else
    alert("Please select quantity less than 10.");
})

document.querySelector(".quantity-down").addEventListener("click",function(){
    let quantity = parseInt(buyQuantityTag.textContent);
    console.log(typeof quantity);
  if(quantity > 0)
    buyQuantityTag.textContent = quantity - 1;
})






