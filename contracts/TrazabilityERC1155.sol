// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract Trazability is ERC1155, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    struct ProductData {
        string id;
        string name;
        string trazability;
        string productReference;
    }

    mapping(string => ProductData) private productIdToProductData;
    mapping(uint256 => string) private tokenIdToUri;
    mapping(uint256 => string) private tokenIdToProductId;

    constructor() ERC1155("Trazabilidad Ideal") {}

    function safeMint(
        address to,
        ProductData memory data,
        string memory externalUri
    ) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();

        // Convert struct to bytes
        bytes memory dataBytes = abi.encodePacked(
            data.id,
            data.name,
            data.trazability,
            data.productReference
        );

        // Mint the token
        _mint(to, tokenId, 1, dataBytes);

        // Store the product data by product ID
        productIdToProductData[data.id] = data;

        // Store the relationship between token ID and product ID
        tokenIdToProductId[tokenId] = data.id;

        // Assign the specific URI for the token
        tokenIdToUri[tokenId] = externalUri;
    }

    function getProductData(uint256 tokenId) public view returns (ProductData memory) {
        string memory productId = tokenIdToProductId[tokenId];
        return productIdToProductData[productId];
    }

    function getProductDataById(string memory productId) public view returns (ProductData memory) {
        return productIdToProductData[productId];
    }

    function uri(uint256 tokenId) public view virtual override returns (string memory) {
        return tokenIdToUri[tokenId];
    }
}