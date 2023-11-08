import { HardhatRuntimeEnvironment } from "hardhat/types";

async function main() {
  const hre = require("hardhat");
  const { ethers } = hre;

  // Proporciona los datos del producto y el número de lote
  const lotNumber = "12345"; // Número de lote deseado
  const productData = {
    productName: "Producto de prueba",
    producer: "Productor de prueba",
    origin: "Origen de prueba",
    productionDate: 1636252800, // Fecha Unix en segundos (ejemplo: 01/11/2021)
    expirationDate: 1679740800, // Fecha Unix en segundos (ejemplo: 01/03/2023)
  };

  // Dirección del destinatario (usuario que recibirá el nuevo NFT)
  const recipientAddress = "0xCb5751E0bC332373597D5945e2E0E625FAfB1346"; // Reemplaza con la dirección del destinatario

  // URI del token (ubicación del archivo JSON con metadatos)
  const tokenURI =
    "https://ipfs.io/ipfs/QmTcxaZ9etN2MyrXETNQqpGqjwgATbgpgMd7GFwueH2Ju1"; // Reemplaza con el URI deseado

  // Obtén la instancia del contrato
  const Trazability = await hre.ethers.getContractFactory("Trazability");
  const trazability = await Trazability.attach(
    "0xca1DB79971161CC4e0A5185c80Ec004E7F25Eb02"
  ); // Reemplaza "CONTRATO_ADDRESS" con la dirección de tu contrato desplegado

  // Mintea un nuevo token asociado al número de lote y establece los datos del producto
  await trazability.safeMint(
    recipientAddress,
    tokenURI,
    productData,
    lotNumber
  );

  console.log("Token minteado con éxito y datos del producto establecidos.");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
