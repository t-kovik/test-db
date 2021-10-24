import {useEffect, useState} from "react";

const api = {
    key: '65d6ba0d8e6a5d6df6b9f72c0e8cda54',
    base: 'https://api.openweathermap.org/data/2.5/'
}

export function Weather() {
    const [query, setQuery] = useState('Ivanovo');
    const [weather, setWeather] = useState({});

    function fetchWeather() {
        fetch(`${api.base}weather?q=${query}&units=metric&APPID=${api.key}`)
            .then(res => res.json())
            .then(result => {
                setQuery('');
                setWeather(result);
            })
    }

    const search = ev => {
        if (ev.key === "Enter") {
            fetchWeather();
        }
    }

    useEffect(() => {
        fetchWeather();
    }, [])

    const dateBuilder = (d) => {
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

        let date = d.getDate();
        let month = months[d.getMonth()];
        let year = d.getFullYear();

        return `${date} ${month} ${year}`
    }

    return (
        <div className='weather'>
            {(typeof weather.main != "undefined") ? (
                <div className='weather-box'>
                    <div className="weather-box__data">{dateBuilder(new Date())}</div>
                        <div className="weather-box__data">{weather.name}, {weather.sys.country}</div>
                        <div className={
                            (typeof weather.main != "undefined") ? (
                                (weather.weather[0].main === "Clouds") ? 'icon-weather cloudy' :
                                    (weather.weather[0].main === "Rain") ? 'icon-weather rain' :
                                        (weather.weather[0].main === "Fog") ? 'icon-weather foggy' :
                                            'icon-weather') : 'icon-weather'
                        }>

                        </div>
                        <div className="weather-box__data">{Math.round(weather.main.temp)}&#176;C</div>
                </div>) : ('')}
            <div className="weather__search">
                <input type="text"
                       className="weather__search-input"
                       placeholder="Введите город..."
                       value={query}
                       onChange={e => setQuery(e.target.value)}
                       onKeyPress={search}/>
                <button className="weather__search-btn" onClick={() => {fetchWeather()}}>Поиск города</button>
            </div>
        </div>
    );
}