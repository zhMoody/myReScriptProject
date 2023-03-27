// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";

var defaultTodos = [];

function TodoItem(Props) {
  var item = Props.item;
  var deleteItem = Props.deleteItem;
  var chanceChecked = Props.chanceChecked;
  var className = item.check ? "item reminder" : "item";
  return React.createElement("div", {
              className: "item font_Style animate__animated animate__bounceIn",
              onClick: (function (param) {
                  Curry._1(chanceChecked, item.id);
                })
            }, React.createElement("h4", {
                  className: className
                }, item.text), React.createElement("span", {
                  onClick: (function (param) {
                      Curry._1(deleteItem, item.id);
                    })
                }, "x"));
}

var make = TodoItem;

export {
  defaultTodos ,
  make ,
}
/* react Not a pure module */