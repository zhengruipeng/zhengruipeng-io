let JSONParserEvent = class extends Object{
    key;
    value;
    json;
    jsonParser;
    cancelBubble = false;
    constructor({key,value,json,jsonParser}) {
        super();
        this.key = key;
        this.value = value;
        this.json = json;
        this.jsonParser = jsonParser;
    }
}
JSONParserEvent.prototype.stopPropagation = function (){
    this.cancelBubble = true;
};

/*private*/let defaultInputEvent = function (ev,that){
    // let tdValue = this.parent;
    // that.cellToJson.set(tdValue,this.value);
    // console.log(that.json)

    //自动转化数字类型
    let temp = Number.isNaN(this.value - 0)?this.value:this.value - 0;

    //自动转化布尔类型
    (temp === "true" || temp === "false") &&
    (temp = (temp === "true"));


    that.json[this.name] = temp;
    // console.log(that.json)

    that.onJsonChange && that.onJsonChange(new JSONParserEvent({
        json:that.json,
        value:temp,
        key:this.name,
        jsonParser:that
    }));
};


let JSONParser = class extends Object{

    json = {};
    // jsonToCell = new Map();
    valueToJson = new Map();
    cellToJson = new Map();
    children = [];
    parent = null;

    constructor(json) {
        super();
        this.json = json;
    };

    initTable(outside = document.body){
        let container = document.createElement("section");
        container.className = "table-container";

        container.innerHTML = `
            <table>
                <thead>
                    <tr>
                        <th>key</th>
                        <th>value</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
        `;

        const tbody = container.querySelector("tbody");

        for(let name in this.json){
            this.valueToJson.set(this.json[name],name);

            let tr = document.createElement("tr");

            let tdName = document.createElement("td");
            tdName.innerHTML = name;
            // this.jsonToCell.set(name,tdName);
            this.cellToJson.set(tdName,name);

            let tdValue = document.createElement("td");


                //当json值为对象的时候就再建一张表
            if(this.json[name] instanceof Object){
                const jsonParser = new JSONParser(this.json[name]);
                jsonParser.initTable(tdValue);

                jsonParser.parent = this;

                let that = this;
                //冒泡
                jsonParser.onJsonChange = function  (ev){
                    // debugger;
                    let that2 = this;

                    that.jsonChange(ev);

                    //如果不是祖先对象的话则触发事件
                    if(!ev.cancelBubble && this === ev.jsonParser)
                        that.jsonChange(new JSONParserEvent({
                            json:that2.parent.json,
                            key: name,
                            value: ev.json,
                            jsonParser:that
                        }));
                };

                this.children.push({jsonParser,json:this.json[name]})
            }
            //当json值为字符串的时候按照输入框进行显示
            else{
                /*//自动转化数字类型
                let temp = Number.isNaN(this.json[name] - 0)?this.json[name]:this.json[name] - 0;

                //自动转化布尔类型
                (temp === "true" || temp === "false") &&
                (temp = (temp === "true"));*/

               /* if(typeof this.json[name] === "number"){
                    tdValue.innerHTML = `
                        <input type="number" value="${this.json[name]}" name="${name}"
                         class="json-input" id="${this.json[name]}" />
                    `;
                }else if(typeof this.json[name] === "boolean"){
                    tdValue.innerHTML = `
                        <input type="radio" value="true" name="${name}"
                         class="json-input" id="${this.json[name]}1" />
                         <input type="radio" value="false" name="${name}"
                         class="json-input" id="${this.json[name]}2" />
                    `;
                }else{
                    tdValue.innerHTML = `
                        <input type="text" value="${this.json[name]}" name="${name}"
                         class="json-input" id="${this.json[name]}" />
                    `;
                }*/

                tdValue.innerHTML = `
                        <input type="text" value="${this.json[name]}" name="${name}"
                         class="json-input" id="${this.json[name]}" />
                    `;

                let that = this;
                tdValue.children[0].addEventListener("input",function (ev){
                    defaultInputEvent.call(this,ev,that);

                });
            }


            this.cellToJson.set(tdValue,this.json[name]);

            tr.appendChild(tdName);
            tr.appendChild(tdValue);

            tbody.appendChild(tr);
        }

        outside.appendChild(container);
    };

    onJsonChange(ev){

    };

    import(href){
        let linkEle = document.createElement("link");
        linkEle.href = href;
        linkEle.rel = "stylesheet";
        linkEle.type = "text/css";
        document.head.appendChild(linkEle);
    };

    jsonChange(ev){
        this.onJsonChange(ev||new JSONParserEvent({json:this.json,jsonParse:this}));
    }
};

export {JSONParser}