//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract trackProduct {
    //details of the product
    struct product {
        string name; //name
        string mfd; //manufacturing date
        string exp; //exp date
        string location; //location
    }

    //map unique id to product
    mapping(uint256 => product) public productID;

    //function to add a product
    function addProduct(
        string memory _name,
        string memory _mfd,
        string memory _exp,
        uint256 _prodID
    ) public {
        productID[_prodID] = product(_name, _mfd, _exp, "");
    }

    //function to update the product detail
    function updateLocation(uint256 _prodID, string memory _location) public {
        product memory addedProd = productID[_prodID];
        addedProd.location = _location;
        productID[_prodID] = addedProd;
    }

    //function to view the product detail
    function viewProductDetail(uint256 _prodID)
        public
        view
        returns (string memory)
    {
        return productID[_prodID].location;
    }

    //function to delete the product detail
    function deleteProduct(uint256 _prodID) public {
        delete productID[_prodID];
    }
}