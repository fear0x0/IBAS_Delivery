from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Установка соединения с базой данных
conn = mysql.connector.connect(
    host="localhost",
    port="3306",
    user="root",
    password="root",
    database="deliverydb"
)

# Маршрут для добавления новой записи
@app.route('/add_product', methods=['POST'])
def add_product():
    if request.method == 'POST':
        data = request.json
        cursor = conn.cursor()
        # Используем SQL-запрос для добавления записи
        cursor.execute("INSERT INTO products (menu_name, price) VALUES (%s, %s)", (data['menu_name'], data['price']))
        conn.commit()
        cursor.close()
        return jsonify({'message': 'Product added successfully'})

# Маршрут для удаления записи
@app.route('/delete_product/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    if request.method == 'DELETE':
        cursor = conn.cursor()
        # Используем SQL-запрос для удаления записи
        cursor.execute("DELETE FROM products WHERE product_id = %s", (product_id,))
        conn.commit()
        cursor.close()
        return jsonify({'message': 'Product deleted successfully'})

# Маршрут для редактирования записи
@app.route('/edit_product/<int:product_id>', methods=['PUT'])
def edit_product(product_id):
    if request.method == 'PUT':
        data = request.json
        cursor = conn.cursor()
        # Используем SQL-запрос для редактирования записи
        cursor.execute("UPDATE products SET menu_name = %s, price = %s WHERE product_id = %s", (data['menu_name'], data['price'], product_id))
        conn.commit()
        cursor.close()
        return jsonify({'message': 'Product edited successfully'})

# Маршрут для вывода всех записей
@app.route('/get_all_products', methods=['GET'])
def get_all_products():
    if request.method == 'GET':
        cursor = conn.cursor(dictionary=True)
        # Используем SQL-запрос для получения всех записей
        cursor.execute("SELECT * FROM products")
        products = cursor.fetchall()
        cursor.close()
        return jsonify(products)

if __name__ == '__main__':
    app.run(debug=True)
