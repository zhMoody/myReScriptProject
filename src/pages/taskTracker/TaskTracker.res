type status = [#a | #b | #c]

@react.component
let make = () => {
  let useArray = (arr: array<TodoItem.todo>) => {
    let (item, setItem) = React.useState(_ => arr)
    let addArr = a => {
      setItem(prev => prev->Js.Array2.concat([a]))
    }
    let deleteItem = (idx: int) => {
      setItem(prev => prev->Js.Array2.spliceInPlace(~pos=idx, ~remove=1, ~add=[]))
    }
    let updateItem = id => {
      let tempArr = item->Js.Array2.copy
      setItem(_ =>
        tempArr->Js.Array2.map(i => {
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
    }
    (item, addArr, deleteItem, updateItem)
  }
  let (data, addItem, deleteItem, updateItem) = useArray(TodoItem.defaultTodos)
  let (stTtem, _) = React.useState(() => [#a, #b, #c])
  let (idx, setIdx) = React.useState(() => #a)
  let (value, setValue) = React.useState(_ => "")
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
      {stTtem
      ->Js.Array2.mapi((item, i) => {
        switch item {
        | #a =>
          <li
            key={i->Belt.Int.toString}
            className={idx == #a ? "active" : ""}
            onClick={_ => {
              setIdx(_ => #a)
            }}>
            {"全部"->React.string}
          </li>
        | #b =>
          <li
            key={i->Belt.Int.toString}
            className={idx == #b ? "active" : ""}
            onClick={_ => {
              setIdx(_ => #b)
            }}>
            {"已完成"->React.string}
          </li>
        | #c =>
          <li
            key={i->Belt.Int.toString}
            className={idx == #c ? "active" : ""}
            onClick={_ => {
              setIdx(_ => #c)
            }}>
            {"未完成"->React.string}
          </li>
        }
      })
      ->React.array}
    </ul>
    <div className="content">
      {data
      ->Belt.Array.keep(({check}) => {
        switch idx {
        | #c => !check
        | #b => check
        | _ => true
        }
      })
      ->Js.Array2.mapi((item, i) => <TodoItem key={item.id} item deleteItem updateItem i />)
      ->React.array}
    </div>
  </div>
}
