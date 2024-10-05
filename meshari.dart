class Item {
  String name;
  double price;

  Item(this.name, this.price);

  String displayItem() {
    return '$name: \$$price';
  }
}

class ItemStock {
  Item item;
  int stock;

  ItemStock(this.item, this.stock);

  bool isInStock() {
    return stock > 0;
  }
}

class VendingMachine {
  List<ItemStock> items = [];
  double balance = 0.0;

  void addItem(Item item, int stock) {
    items.add(ItemStock(item, stock));
  }

  void selectItem(String itemName) {
    for (var itemStock in items) {
      if (itemStock.item.name == itemName) {
        if (itemStock.isInStock()) {
          print('Selected: ${itemStock.item.displayItem()}');
          return;
        } else {
          print('Sorry, $itemName is out of stock.');
          return;
        }
      }
    }
    print('Item $itemName not found.');
  }

  void insertMoney(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Inserted: \$$amount. Current balance: \$$balance');
    } else {
      print('Invalid amount. Please insert a positive value.');
    }
  }

  void dispenseItem(String itemName) {
    for (var itemStock in items) {
      if (itemStock.item.name == itemName) {
        if (!itemStock.isInStock()) {
          print('Sorry, $itemName is out of stock.');
          return;
        }
        if (balance >= itemStock.item.price) {
          balance -= itemStock.item.price;
          itemStock.stock--;
          print('Dispensed: $itemName. Remaining balance: \$$balance');
          return;
        } else {
          print('Insufficient balance. Please insert more money.');
          return;
        }
      }
    }
    print('Item $itemName not found.');
  }

  double getChange() {
    double change = balance;
    balance = 0.0; // Reset balance after giving change
    return change;
  }
}

// Testing the vending machine
void main() {
  VendingMachine vendingMachine = VendingMachine();

  // Initialize the warehouse with items
  vendingMachine.addItem(Item('Soda', 1.50), 5);
  vendingMachine.addItem(Item('Chips', 1.00), 10);
  vendingMachine.addItem(Item('Candy', 0.75), 0); // Out of stock

  // User interactions
  vendingMachine.selectItem('Chips'); // Should show price and availability
  vendingMachine.insertMoney(1.00); // Insert money
  vendingMachine.dispenseItem('Chips'); // Dispense item
  vendingMachine.insertMoney(2.00); // Insert more money
  vendingMachine.selectItem('Candy'); // Check out of stock
  vendingMachine.dispenseItem('Soda'); // Try to dispense soda
  print(
      'Change returned: \$${vendingMachine.getChange()}'); // Get remaining balance
}
