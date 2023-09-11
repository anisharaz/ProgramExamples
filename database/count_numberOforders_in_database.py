from mysql.connector import connect
import json as js
conn = connect(
    host="10.0.0.3",
    user="root",
    password="kali",
    database="classicmodels"
)
cur = conn.cursor()

cur.execute("select customers.customerName,orders.orderNumber from customers left join orders on customers.customerNumber=orders.customerNumber")
count = 0
current = ""
order_detail={}
for x in cur:
    if(x[1] == None):
        continue
    if(x[0] != current):
        count = 1
        current = x[0]
        order_detail[x[0]] = count
    else:
        count += 1
        order_detail[x[0]] = count
print(js.dumps(order_detail, indent=2))