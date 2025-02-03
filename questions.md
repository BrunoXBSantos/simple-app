# Dotmoovs Backend Technical Interview

## Overview
Welcome to the Dotmoovs backend technical interview! This assessment is designed to evaluate your skills in working with NestJS and solving basic algorithmic problems. The interview consists of two main parts:

1. **NestJS Setup Task**: A practical exercise to set up and run a simple NestJS application
2. **Algorithmic Problems**: Three programming challenges to assess your problem-solving skills
3. **Backend Development Concepts**: Five questions to assess your understanding of backend development concepts

You are free to use any programming language for the algorithmic problems and can consult documentation/resources as needed.

---

## Part 1: NestJS Setup

### Task: Run a Simple NestJS Application
1. Clone this repository to your local machine
2. Navigate to the `simple-app` directory
3. Install dependencies using
4. Build the application using
5. Start the application using
6. Verify the application is running by visiting `http://localhost:4000` in your browser

**Expected Output:**
You should see the message: "Dotmoovs Interview - Simple App is running!"

---

## Part 2: Algorithmic Problems

### Problem 1: TypeScript Code Analysis
Analyze the following TypeScript code and answer the questions below:

```typescript
interface Product {
    id: number;
    name: string;
    price: number;
    category?: string;
}

class ShoppingCart {
    private items: Product[] = [];
    private discount: number = 0;

    addItem(product: Product) {
        if (product.price > 0) {
            this.items.push(product);
        }
    }

    applyDiscount(discount: number) {
        this.discount = discount;
    }

    calculateTotal(): number {
        const subtotal = this.items.reduce((sum, product) => sum + product.price, 0);
        return subtotal * (1 - this.discount);
    }

    getMostExpensiveItem(): Product {
        return this.items.sort((a, b) => b.price - a.price)[0];
    }

    checkout() {
        if (this.items.length === 0) {
            console.log('Cart is empty');
            return;
        }

        const total = this.calculateTotal();
        console.log(`Total: $${total.toFixed(2)}`);
        console.log('Items purchased:');
        this.items.forEach(item => console.log(`- ${item.name}: $${item.price}`));
    }
}

const cart = new ShoppingCart();
cart.addItem({ id: 1, name: 'Laptop', price: 1200 });
cart.addItem({ id: 2, name: 'Mouse', price: 25 });
cart.applyDiscount(0.1);
cart.checkout();
```

**Questions:**
1. Identify potential issues in the code (runtime errors, logical errors, or type safety concerns)
2. What would be the expected output of this code?
3. What improvements could be made to make the code more robust and maintainable?

### Problem 2: Relational Database Query
Given the following three tables in a relational database, write a SQL query to retrieve the required information.

**Tables:**

1. **Customers**
   - `customer_id` (Primary Key)
   - `name`

2. **Orders**
   - `order_id` (Primary Key)
   - `customer_id` (Foreign Key to Customers)
   - `order_date`

3. **Order_Items**
   - `order_item_id` (Primary Key)
   - `order_id` (Foreign Key to Orders)
   - `product_name`
   - `quantity`
   - `price`

**Relationships:**
- A **Customer** can have many **Orders** (1-to-many relationship between Customers and Orders).
- An **Order** can have many **Order_Items** (1-to-many relationship between Orders and Order_Items).

**Task:**
Write a SQL query to retrieve the following information for each order:
- Customer name
- Order date
- Total amount for the order (calculated as the sum of `quantity * price` for all items in the order)

**Expected Output Example:**
| Customer Name | Order Date  | Total Amount |
|---------------|-------------|--------------|
| John Doe      | 2023-10-01  | 150.00       |
| Jane Smith    | 2023-10-02  | 75.00        |

**Hint:** Use `JOIN` to relate the tables and `SUM` to calculate the total amount.

---

## Part 3: Backend Development Concepts


### Question 1: Singleton Pattern and Dependency Injection
Explain the Singleton pattern and how it can be implemented using Dependency Injection.

### Question 2: HTTP Methods in REST APIs
What are the main HTTP methods used in REST APIs, and what is the purpose of each one?

### Question 3: Basic Database Concepts
What are the differences between a relational database and a NoSQL database? When would you use each type?


