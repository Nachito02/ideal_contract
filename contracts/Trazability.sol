// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract Trazability is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    struct ProductData {
    string id;
    string protocolName;
    string name;
    string status;
    TrazabilityData[] trazability;
    string ownerUid;
}

struct TrazabilityData {
    Line[] line;
    string name;
}

struct Line {
    string path;
    string name;
    Milestone[] milestones;
}

struct Milestone {
    string image;
    string description;
}
    mapping(string => Product) productDataByLotNumber;

    constructor() ERC721("Ideal Trazabilidad", "IDEAL") {}

    function safeMint(
        address to,
        string memory uri,
        ProductData memory data,
        string memory lotNumber
    ) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        productDataByLotNumber[lotNumber] = Product(data, tokenId);
    }

    function setProductData(
        string memory lotNumber,
        ProductData memory data
    ) public {
        productDataByLotNumber[lotNumber].data = data;
    }

    function getProductDataByLotNumber(
        string memory lotNumber
    ) public view returns (ProductData memory) {
        require(
            bytes(lotNumber).length > 0,
            "Numero de lote no puede estar vacio"
        );
        return productDataByLotNumber[lotNumber].data;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
