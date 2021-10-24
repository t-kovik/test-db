import './App.css';
import {TableStoreEmpty} from "./components/TableStoreEmpty";
import {TableIntensityStore} from "./components/TableIntensityStore";
import {TableHistoryTraffic} from "./components/TableHistoryTraffic";
import {TableProductTraffic} from "./components/TableProductTraffic";
import {Weather} from "./components/Weather";

function App() {

  return (
    <div className="App">
        <header className='header'>
            <div className="container">
                <h1>MySQL</h1>
                <Weather />
            </div>
        </header>
        <main>
            <TableStoreEmpty />
            <TableIntensityStore />
            <TableHistoryTraffic />
            <TableProductTraffic />
        </main>
    </div>
  );
}

export default App;
