const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const mysql = require('mysql');

const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '4628801',
    database: 'storage'
})

app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({extended: true}));

//пустующие склады за определенный промежуток времени
app.get('/get/store/empty/:date_beg/:date_end', (req, res) => {
    const date_beg = req.params.date_beg;
    const date_end = req.params.date_end;
    const sqlSelectProduct = `SELECT q2.store_id, address, special_equipment, area
                              FROM (SELECT store_id,
                                           if(sum(keeping.amount) IS NULL, 0, sum(keeping.amount)) keeping_sum,
                                           q1.sum
                                    FROM (SELECT store_id,
                                                 if(sum(expenditure.amount) - sum(receipt.amount) IS NULL, 0,
                                                    sum(expenditure.amount) - sum(receipt.amount)) sum
                                          FROM receipt
                                                   RIGHT JOIN store USING (store_id)
                                                   LEFT JOIN expenditure USING (store_id)
                                          WHERE receipt.shipping_date BETWEEN ? AND ?
                                             OR expenditure.shipping_date BETWEEN ? AND ?
                                          GROUP BY store_id) q1
                                             LEFT JOIN keeping USING (store_id)
                                    GROUP BY store_id
                                    HAVING if(sum(keeping.amount) IS NULL, 0, sum(keeping.amount)) - q1.sum <= 0) q2
                                       JOIN store USING (store_id);`;
    db.query(sqlSelectProduct,[date_beg, date_end, date_beg, date_end], (err, result) => {
        res.send(result)
    })
})

//интенсивность использования складов
app.get('/get/store', (req, res) => {
    const sqlSelect = `SELECT store_id,
                              address,
                              sum(receipt.amount)     receipt,
                              sum(expenditure.amount) expenditure
                       FROM receipt
                                RIGHT JOIN store USING (store_id)
                                LEFT JOIN expenditure USING (store_id)
                       GROUP BY store_id;`;
    db.query(sqlSelect, (err, result) => {
        res.send(result)
    })
})

//история движения товара на складе за определенный период
app.get('/get/product/traffic/:date_beg/:date_end', (req, res) => {
    const date_beg = req.params.date_beg;
    const date_end = req.params.date_end;
    const sqlSelect = `SELECT store_id, address store, name product, rec_amount receipt, exp_amount expenditure, shipping_date date
                       FROM (SELECT store_id, name, amount rec_amount, 0 AS exp_amount, shipping_date
                             FROM receipt
                                      JOIN product USING (product_id)
                             UNION
                             SELECT store_id, name, 0 AS rec_amount, amount exp_amount, shipping_date
                             FROM expenditure
                                      JOIN product USING (product_id)) as q1
                                RIGHT JOIN store USING (store_id)
                       WHERE shipping_date BETWEEN ? AND ?
                       ORDER BY store_id;`;
    db.query(sqlSelect, [date_beg, date_end], (err, result) => {
        res.send(result)
    })
})

//отчет о движении заданного товара по складам
app.get('/get/product/:product', (req, res) => {
    const pr = req.params.product;
    const sqlSelectProduct = `SELECT name          product,
                                     address       store,
                                     rec_amount    receipt,
                                     exp_amount    expenditure,
                                     shipping_date date
                              FROM (SELECT name, store_id, amount rec_amount, 0 AS exp_amount, shipping_date
                                    FROM receipt
                                             JOIN product USING (product_id)
                                    UNION
                                    SELECT name, store_id, 0 AS rec_amount, amount exp_amount, shipping_date
                                    FROM expenditure
                                             JOIN product USING (product_id)) AS q1
                                       RIGHT JOIN store USING (store_id)
                              WHERE name = ?;`;
    db.query(sqlSelectProduct, pr, (err, result) => {
        res.send(result)
    })
})

app.listen(3001, () => {
    console.log('running on http://localhost:3001');
});