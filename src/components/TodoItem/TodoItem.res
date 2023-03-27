type todo = {
  id: string,
  check: bool,
  text: string,
}
let defaultTodos: array<todo> = []
@react.component
let make = (~item, ~deleteItem, ~chanceChecked) => {
  let className = if item.check {
    "item reminder"
  } else {
    "item"
  }
  <div
    className="item font_Style animate__animated animate__bounceIn"
    onClick={_ => chanceChecked(item.id)}>
    <h4 className> {item.text->React.string} </h4>
    <span onClick={_ => deleteItem(item.id)}> {"x"->React.string} </span>
  </div>
}
