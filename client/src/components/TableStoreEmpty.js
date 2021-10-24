import axios from 'axios'
import {useState} from "react";

export function TableStoreEmpty() {
    const [storeList, setStoreList] = useState([])
    const [dateBeg, setDateBeg] = useState('');
    const [dateEnd, setDateEnd] = useState('');

    const handleClick = (e) => {
        e.preventDefault();
        axios.get(`http://localhost:3001/get/store/empty/${dateBeg}/${dateEnd}`, {
            params: {
                date_beg: dateBeg,
                date_end: dateEnd,
            }
        })
            .then((response) => {
                setStoreList(response.data)
            }, [])
    }

    return <div className='table'>
        <h2>Отчет о пустующих складах за определенный промежуток времени</h2>
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
                <th>Адрес</th>
                <th>Площадь</th>
                <th>Оборудование</th>
            </tr>
            </thead>
            <tbody>
            {storeList.map((item, i) => {
                return <tr key={item.store_id}>
                    <td>{item.address}</td>
                    <td>{item.special_equipment}</td>
                    <td>{item.area}</td>
                </tr>
            })}
            </tbody>
        </table>
    </div>
}

