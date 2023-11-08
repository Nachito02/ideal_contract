import { HardhatRuntimeEnvironment } from "hardhat/types";

async function main() {
  const hre = require("hardhat");
  const { ethers } = hre;

  // Proporciona el número de lote del producto que deseas recuperar
  const lotNumber = "12345"; // Reemplaza con el número de lote deseado

  // Obtén la instancia del contrato
  const Trazability = await hre.ethers.getContractFactory("Trazability");
  const trazability = await Trazability.attach(
    "0xca1DB79971161CC4e0A5185c80Ec004E7F25Eb02"
  ); // Reemplaza "CONTRATO_ADDRESS" con la dirección de tu contrato desplegado

  // Recupera los datos del producto
  const productData = await trazability.getProductDataByLotNumber(lotNumber);

  console.log("Datos del producto recuperados:");
  console.log("Nombre del producto:", productData.productName);
  console.log("Productor:", productData.producer);
  console.log("Origen:", productData.origin);

  const productionDate = new Date(
    Number(productData.productionDate) * 1000
  ).toLocaleDateString();
  const expirationDate = new Date(
    Number(productData.expirationDate) * 1000
  ).toLocaleDateString();

  console.log("Fecha de producción:", productionDate);
  console.log("Fecha de vencimiento:", expirationDate);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
