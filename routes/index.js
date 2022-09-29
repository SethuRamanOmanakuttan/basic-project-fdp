var express = require('express');
var router = express.Router();
var contract = require('./contract.js')


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Sample App' , product_location: ""});
});

// add product
router.post('/addProd', async function(req, res, next) {
   console.log("Adding new product ....")
   id = Number(req.body['id'])
   name = req.body['name']
   mfd = req.body['mfd']
   exp = req.body['exp']
   receipt = await contract.addProduct(name,mfd,exp,id)
   receipt_string = JSON.stringify(receipt)
   res.render('add_product', { transaction_receipt:receipt_string });
});

//update location
router.post('/updateLoc', async function(req, res, next) {
   console.log("Updating Product Location....")
   id = Number(req.body['id'])
   location = req.body['location']
   receipt = await contract.updateLocation(id,location)
   receipt_string = JSON.stringify(receipt)
   res.render('update_location', { transaction_receipt:receipt_string });
});

//delete product
router.post('/deleteProd', async function(req, res, next) {
   console.log("Deleteting Product.....")
   id = Number(req.body['id'])
   receipt = await contract.deleteProduct(id)
   receipt_string = JSON.stringify(receipt)
   res.render('delete_product', { transaction_receipt:receipt_string });
});

//view product
router.post('/getDetail', async function(req, res, next) {
   console.log("Fetching Product Location")
   id = Number(req.body['location'])
   details = await contract.viewProductDetail(Number(id))
   res.render('product_detail', { product_location:details });
});


module.exports = router;
