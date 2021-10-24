import axios from 'axios'
import {useEffect, useState} from "react";

export function TableIntensityStore() {
    const [storeList, setStoreList] = useState([])
    useEffect(() => {
        axios.get('http://localhost:3001/get/store')
            .then((response) => {
                setStoreList(response.data)
            })
    }, [])

    return <div className='table'>
        <h2>Интенсивность использования складов</h2>
        <table border={1}>
            <thead>
            <tr>
                <th>Адрес</th>
                <th>Приход</th>
                <th>Расход</th>
            </tr>
            </thead>
            <tbody>
            {storeList.map((item, i) => {
                return <tr key={item.store_id}>
                    <td>{item.address}</td>
                    <td>{item.receipt}</td>
                    <td>{item.expenditure}</td>
                </tr>
            })}
            </tbody>
        </table>
    </div>
}