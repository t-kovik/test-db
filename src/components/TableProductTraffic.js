import axios from 'axios'
import {useState} from "react";

export function TableProductTraffic() {
    const [storeList, setStoreList] = useState([])
    const [product, setProduct] = useState('');

    const handleClick = (e) => {
        e.preventDefault();
        axios.get(`http://localhost:3001/get/product/${product}`,
            {params: {product: product}})
            .then((response) => {
                setStoreList(response.data)
            })
    }

    return <div className='table'>
        <h2>Отчет о движении заданного товара по складам</h2>
        <form action="" className='form'>
            <input type="text"
                   className='form__input'
                   placeholder='Название товара'
                   name='product'
                   required
                   onChange={(e) => {
                       setProduct(e.target.value)
                   }}/>
            <button className='form__btn' onClick={handleClick}>Поиск</button>
        </form>
        <table border={1}>
            <thead>
            <tr>
                <th>Товар</th>
                <th>Cклад</th>
                <th>Приход</th>
                <th>Расход</th>
                <th>Дата</th>
            </tr>
            </thead>
            <tbody>
            {storeList.map((item, i) => {
                const date = new Date(item.date).toISOString().slice(0, 10);
                return <tr key={item.store_id}>
                    <td>{item.product}</td>
                    <td>{item.store}</td>
                    <td>{item.receipt}</td>
                    <td>{item.expenditure}</td>
                    <td>{date}</td>
                </tr>
            })}
            </tbody>
        </table>
    </div>
}