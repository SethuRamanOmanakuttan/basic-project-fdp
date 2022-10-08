//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/**
* A sample contract that performs the CRUD(create,read,update,delete)
* Operations on the details of a product that is provided by the user.
*/


contract trackProduct {
    
    /**
    * Structs in Solidity allows you to create more complicated data types 
    * that have multiple properties.They are useful for grouping together related data.
    * Here we use struct to define a product with the following properties :
    *   name - name of the product
    *   mfd - Manufacturing date
    *   exp - Expiry date
    *   location - location of the product
    */
    struct product {
        string name; //name
        string mfd; //manufacturing date
        string exp; //exp date
        string location; //location
    }

    /**
    * Mapping in Solidity acts like a hash table or dictionary in any other language. 
    * These are used to store the data in the form of key-value pairs, 
    * Here we have mapped a unique uint256 number to a product struct instance
    */

    mapping(uint256 => product) public productID;

    /**
    * The function adds the record of a new product to the chain
    * It takes the 
    *   -> name (string)
    *   -> manufacturing date (string)
    *   -> expiry date (string)
    *   -> product id number (number)
    * Here the memory keyword specifies where the string should be stored
    * During the time of execution
    */
    function addProduct(
        string memory _name,
        string memory _mfd,
        string memory _exp,
        uint256 _prodID
    ) public {
        //The following statements takes the product id as key and maps it to
        //A newly created instace of the product struct
        productID[_prodID] = product(_name, _mfd, _exp, "");
    }

    /**
    * The function updates the location of the product
    * It takes the 
    *   -> product id number (number)
    *   -> new location (string)
    * as parameters
    */
    function updateLocation(uint256 _prodID, string memory _location) public {
        product memory addedProd = productID[_prodID];
        addedProd.location = _location;
        productID[_prodID] = addedProd;
    }
    /**
    * The function views the current location of the product
    * It takes the 
    *   -> product id number (number)
    * as parameter
    */
    function viewProductDetail(uint256 _prodID)
        public
        view
        returns (string memory)
    {
        return productID[_prodID].location;
    }

    /**
    * The function deletes a specified product
    * It takes the 
    *   -> product id number (number)
    * as parameter
    */
    function deleteProduct(uint256 _prodID) public {
        //deletes the particular product id (key) and the associated value
        //from the mapping
        delete productID[_prodID];
    }
}