
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    address public owner;
    enum OrderStatus { Pending , InProgress , Shipped , Delivered }

    struct Order{
        address buyer;
        string product ; 
        uint256 quantity;
        OrderStatus status ; 
    }

    mapping(uint256 => Order) public orders;
    uint256 public orderCount;

    event OrderPlaced(uint256 orderId , address buyer , string product , uint256 quantity );
    event OrderProcessed(uint256 orderId);
    event OrderShipped (uint256 orderId);
    event OrderDelivered (uint256 orderId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        orderCount = 0 ; 
    }

    function placeOrder( string memory _product , uint256 _quantity) external {
        // Use require() to ensure the campaign is ongoing
        require(_quantity > 0 , "Quantity must be greater than zero");
        uint256 orderId = orderCount++;
        orders[orderId] = Order( msg.sender , _product , _quantity , OrderStatus.Pending);


        emit OrderPlaced(orderId , msg.sender , _product , _quantity);

    }

    function processOrder( uint256 _orderId ) external onlyOwner {
        Order storage order = orders[_orderId];
       require(order.status == OrderStatus.Pending , "Order is not pending");
        
        uint256 newQuantity = order.quantity + 1 ;
        assert(newQuantity  > order.quantity);

        order.quantity = newQuantity;
        order.status =  OrderStatus.InProgress;

       emit OrderProcessed(_orderId);
    }

    function shipOrder( uint256 _orderId ) external  onlyOwner{
        Order storage order = orders[_orderId];
        assert(order.status == OrderStatus.Shipped);
        emit OrderShipped(_orderId);
    }

    function deliverOrder( uint256 _orderId ) external  onlyOwner{
        Order storage order = orders[_orderId];
        if( order.status != OrderStatus.Shipped){
            revert("Order is not shipped");
        }
        order.status = OrderStatus.Delivered;
        emit OrderDelivered(_orderId);
    }
}
