# SupplyChain Smart Contract

This Ethereum smart contract, written in Solidity, implements a basic supply chain management system. It allows users to place orders, process orders, ship orders, and mark orders as delivered.

## Contract Details

- **Owner:** Address of the contract owner.
- **Order Status Enum:**
  - Pending
  - InProgress
  - Shipped
  - Delivered

## Functions

### `placeOrder(string memory _product, uint256 _quantity) external`

Allows a buyer to place an order with the specified product and quantity. Emits an `OrderPlaced` event.

### `processOrder(uint256 _orderId) external onlyOwner`

Allows the owner to process a pending order, changing its status to `InProgress` and incrementing the order quantity. Emits an `OrderProcessed` event.

### `shipOrder(uint256 _orderId) external onlyOwner`

Allows the owner to mark an order as shipped. Emits an `OrderShipped` event.

### `deliverOrder(uint256 _orderId) external onlyOwner`

Allows the owner to mark a shipped order as delivered. Emits an `OrderDelivered` event.

## Events

- `OrderPlaced(uint256 orderId, address buyer, string product, uint256 quantity)`
- `OrderProcessed(uint256 orderId)`
- `OrderShipped(uint256 orderId)`
- `OrderDelivered(uint256 orderId)`

## Modifiers

### `onlyOwner`

Ensures that only the contract owner can call a specific function.
