type select = {
  id: string,
  text: string,
}
let selectItems: array<select> = [
  {
    id: "1",
    text: "全部",
  },
  {
    id: "2",
    text: "进行中",
  },
  {
    id: "3",
    text: "已完成",
  },
]

@react.component
let make = () => {
  let (todos, setTodos) = React.useState(() => TodoItem.defaultTodos)
  let (stTtem, _) = React.useState(() => selectItems)
  let (idx, setIdx) = React.useState(() => "1")
  let (value, setValue) = React.useState(_ => "")
  let addItem = todoItem => setTodos(item => item->Belt.Array.concat([todoItem]))
  let deleteItem = id => setTodos(item => item->Js.Array2.filter(i => i.id !== id))
  let chanceChecked = id =>
    setTodos(item =>
      item->Js.Array2.map(i => {
        if i.id === id {
          {
            ...i,
            check: !i.check,
          }
        } else {
          i
        }
      })
    )
  <div className="initBox ">
    <Header />
    <div className="iptbox">
      <input
        type_="text"
        className="ipt"
        placeholder="请输入待办事项！"
        value={value}
        onChange={event => {
          let value = ReactEvent.Form.target(event)["value"]
          setValue(_ => value)
        }}
      />
      <button
        className={"btn"}
        onClick={_ =>
          switch value {
          | "" => Js.log("请输入待办事项！！！")
          | _ =>
            addItem({
              id: Belt.Int.toString(Js.Math.random_int(0, 1000000)),
              text: value,
              check: false,
            })
            setValue(_ => "")
          }}>
        {"添加"->React.string}
      </button>
    </div>
    <ul className="selectBox">
      {React.array(
        stTtem->Js.Array2.map(s =>
          <li
            key={s.id}
            className={if s.id == idx {
              "active"
            } else {
              ""
            }}
            onClick={_ => {
              switch s.id {
              | "2" => setIdx(_ => s.id)
              | "3" => setIdx(_ => s.id)
              | _ => setIdx(_ => "1")
              }
            }}>
            {s.text->React.string}
          </li>
        ),
      )}
    </ul>
    <div className="content">
      {todos
      ->Belt.Array.keep(({check}) => {
        switch idx {
        | "2" => !check
        | "3" => check
        | _ => true
        }
      })
      ->Js.Array2.map(item => <TodoItem key={item.id} item deleteItem chanceChecked />)
      ->React.array}
    </div>
  </div>
}
