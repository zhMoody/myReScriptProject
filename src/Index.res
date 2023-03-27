%%raw(`import './styles/index.css';`)

let rootQuery = ReactDOM.querySelector("#root")

switch rootQuery {
| None => ()
| Some(root) => ReactDOM.render(<App />, root)
}
