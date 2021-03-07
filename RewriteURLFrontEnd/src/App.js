import './App.css';

function App() {

  const lastPart = window.location.href.split("/").pop()
  window.location.href = "anysync://" + lastPart

  return (
    <div className="App">
      <header className="App-header">
      </header>
    </div>
  );
}

export default App;
