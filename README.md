# binary-search-tree
Build a balanced Binary Search Tree (BST)

Node class
- has data(numerical value) attribute
- has two children, left and right

Tree class
- accepts array when initialized
- has a root attribute

Methods within the tree class
* **build_tree method**: takes an array and builds a balanced BST
* **insert**: inserts a new node as a leaf of the current tree
* **delete**: deletes a node, for nodes:
	* with no children: simply deletes the node
	* with 1 child: deletes the node and replaces it with it's child
	* with 2 children: replaces the node with the node with the next largest
			 numerical value, then deletes that node
* **find**: accepsts a value and returns the node with that value
* **level_order**: can accept a block, searches the tree using
	      breadth first search, returns an array
* **preorder**, **inorder**, **postorder**: can accept a block, searches the
		tree using depth first search, returns an array
* **height**: returns the height of the tree
* **depth**: returns depth of the tree
* **balanced?**: returns true if tree is balanced, else false	
* **rebalance**: rebalances an unbalanced tree
