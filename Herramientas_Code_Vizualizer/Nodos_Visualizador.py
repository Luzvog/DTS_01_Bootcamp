

from json import dumps
from random import randint

graph = {
    "kind": {"graph": True},
    "nodes": [
        {"id": "1", "label": "1"}
    ],
    "edges": []
}



i = 2

# add a node
id = str(i)
graph["nodes"].append({"id": id, "label": id})
# connects the node to a random edge
targetId = str(randint(1, i - 1))
graph["edges"].append({"from": id, "to": targetId})
print("i is " + str(i))
# try setting a breakpoint right above
# then put graph into the visualization console and press enter
# when you step through the code each time you hit the breakpoint
# the graph should automatically refresh!


i = 3

id = str(i)
graph["nodes"].append({"id": id, "label": id})
targetId = str(1)
graph["edges"].append({"from": id, "to": targetId})
print("i is " + str(i))
