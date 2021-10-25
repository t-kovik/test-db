import axios from 'axios'
import {useState} from "react";

export function TableHistoryTraffic() {
    const [storeList, setStoreList] = useState([]);
    const [dateBeg, setDateBeg] = useState('');
    const [dateEnd, setDateEnd] = useState('');

    const handleClick = (e) => {
        e.preventDefault();
        axios.get(`http://localhost:3001/get/product/traffic/${dateBeg}/${dateEnd}`, {params: {
            date_beg: dateBeg,
            date_end: dateEnd,
            }})
            .then((response) => {
                setStoreList(response.data)
            })
    }

    return <div className='table'>
        <h2>История движения товара на складе за определенный период</h2>
        <form action="" className="form">
            от
            <input  type="date"
                    className='form__input'
                    name="date_beg"
                    required
                    onChange={(e) => {setDateBeg(e.target.value)}} />
            до
            <input type="date"
                   className='form__input'
                   name="date_end"
                   required
                   onChange={(e) => {setDateEnd(e.target.value)}}/>
            <button className='form__btn' onClick={handleClick}>Поиск</button>
        </form>
        <table border={1}>
            <thead>
            <tr>
                <th>Склад</th>
                <th>Товар</th>
                <th>Приход</th>
                <th>Расход</th>
                <th>Дата</th>
            </tr>
            </thead>
            <tbody>
            {storeList.map((item, i) => {
                const date = new Date(item.date).toISOString().slice(0,10);
                return <tr key={item.store_id}>
                    <td>{item.store}</td>
                    <td>{item.product}</td>
                    <td>{item.receipt}</td>
                  <td>{item.expenditure}</td>
                    <td>{date}</td>
                </tr>
            })}
            </tbody>
        </table>
    </div>
}