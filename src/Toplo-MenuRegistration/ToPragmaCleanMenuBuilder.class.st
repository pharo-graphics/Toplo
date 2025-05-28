"
For the impatients, see MenuRegistrationExample class methods and try it with:


```
((ToPragmaMenuBuilder pragmaKeyword: ToMenuRegistrationExample pragmaKeyword model: nil) menuEntitled: 'World') popUpInWorld
```


PragmaMenuBuilder is for the dynamic building of menus based on pragmas. A PragmaMenuBuilder instance is the root of a tree of MenuRegistration instances.
The basic principle is that each menu sub-tree is specified by a method which is tagged by a specific pragma. Such methods are dynamically retrieved and then evaluated with a MenuRegistration passed as argument (see #retrieveRegistrations). The result is a tree of MenuRegistration which roots are stored in my itemList inst. var.
After the tree of MenuRegistration has been built, it is re-organized (re-organization is based on the parent declaration) and is re-ordered (based on the MenuRegistration order indications). Then the tree of MenuRegistration can serve as input for the building of a PluggableMenuSpec. The PluggableMenuSpec is itself used in order to build a MenuMorph with the help of the current ToolBuilder. (see MenuRegistration comment for more informations about how to specify menu entries).

The tree of MenuRegistration is built by #buildTree in three steps (1) the  collecting of the MenuRegistration instances (2) the re-organization and (3) the sorting:

1) The first step consists in evaluating all pragma methods by passing a builder (a PragmaMenuBuilder instance) as argument. Each pragma method invocation build a sub-tree which root is added to the builder itemList collection. (see #collectRegistrations).
As an example, this first step could produce a tree as follow (stored in a PragmaMenuBuilder itemList inst var) :
				#Tools						#'Other tool', parentName: #Tools
				/	\										|
	(#Worspace)	(#browser)						(#'Test runner' )

2) The second step consists is re-organizing the tree. A MenuRegistration can be declared with a particular parent name (by sending #parent: to it with a symbol as argument). If the parentName of a MenuRegistration X is the name of another MenuRegistration Z, then it means that X must be placed as a child of Z. This is the goal of this re-arrangement step which moves badly placed nodes at their good place. (see #arrangeRegistrations).
With previous example, the second step produces:
						#Tools								
				/		|			\
	(#Worspace)	(#browser)		#'Other tool' , parentName: #Tools
											|
									(#'Test runner')

2) The third step consists in sorting the tree according to the order inst. var. value of each MenuRegistration. This is done in two passes: the first pass tries to assign as much order inst. var. as possible (If an item is given with a specific order, then, previous and following items order can be automatically computed - see #assignOrderWithBlock: and #orderAssignBlock). The second pass consists in a smple sort according to a sort block given by #itemSortBlock.


Instance Variables
	model:		<Object>
	pragmaCollector:		<PragmaCollection>
	pragmaKeywords:		<Collection of Symbol>
	currentRoot: 			<MenuRegistration>

model
	- Serves as the default target for the menu. Note that a default target can also be declared at menu item level

pragmaKeywords
	- The list of pragma keywords used for the declaring of my menu items

pragmaCollector
	- The PragmaCollector associated with this builder. When a method declared with the same pragma as my pragmaKeyword is updated/added/removed my menu items are recomputed so that the resulting menu is always in sync with currently declared items.
	
currentRoot
	- the current MenuRegistration in which new items are to be added


"
Class {
	#name : #ToPragmaCleanMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'pragmaKeywords',
		'model',
		'currentRoot',
		'itemList',
		'tree',
		'name',
		'parentName',
		'isGroup'
	],
	#category : #'Toplo-MenuRegistration-Clean'
}

{ #category : #private }
ToPragmaCleanMenuBuilder class >> itemSortBlock [
	"The block which is used to sort a menu tree"
	^ [:a :b |
		((a order isNotNil and: [b order isNotNil]) and: [a order ~= b order])
			ifTrue: [a order < b order]
			ifFalse: [((a order isNil and: [b order isNil]) or: [a order = b order])
				ifTrue: [true]
				ifFalse: [a order ifNil: [false] ifNotNil: [true]]]]
]

{ #category : #'instance creation' }
ToPragmaCleanMenuBuilder class >> model: aModel [

	^ self new
		  model: aModel;
		  yourself
]

{ #category : #private }
ToPragmaCleanMenuBuilder class >> orderAssignBlock [
	"The block which is used to set MenuRegistration tree node order inst var (which is used to sort the tree)"

	^ [ :list |
	list
		detect: [ :n | n order isNotNil ]
		ifFound: [ :firstWithOrder |
			| idx order |
			"A menu registration with an order indication hase been found - then compute order of previous and next nodes"
			idx := list indexOf: firstWithOrder.
			order := firstWithOrder order.
			idx > 1
				ifTrue: [
					idx - 1 to: 1 do: [ :pos |
						(list at: pos) order: order - 1.
						order := order - 1 ] ].
			order := firstWithOrder order.
			idx + 1 to: list size do: [ :pos |
				(list at: pos) order ifNil: [ (list at: pos) order: order + 1 ] ifNotNil: [ order := (list at: pos) order ].
				order := order + 1 ].
			list ]
		ifNone: [ list ]	"No order has been set - do not touch anything, the list order is ok" ]
]

{ #category : #'instance creation' }
ToPragmaCleanMenuBuilder class >> pragmaKeyword: aPragmaKeyword model: aModel [
	"Build a builder using aPragmaKeyword as the pragma keyword and aModel a the model of the resulting builder"
	
	^ self pragmaKeywords: {aPragmaKeyword} model: aModel
]

{ #category : #'instance creation' }
ToPragmaCleanMenuBuilder class >> pragmaKeywords: aCollection model: aModel [
	"Build a builder using aPragmaKeyword as the pragma keyword and aModel a the model of the resulting builder"
	
	^ self new
		pragmaKeywords: aCollection;
		model: aModel;
		yourself
]

{ #category : #'registrations handling' }
ToPragmaCleanMenuBuilder >> allMisplacedItems [
	| misplaced |
	self collectMisplacedItemsIn: (misplaced := OrderedCollection new).
	^ misplaced
]

{ #category : #'registrations handling' }
ToPragmaCleanMenuBuilder >> arrangeRegistrations [

	self allMisplacedItems do: [ :item |
		(self itemNamed: item parentName) ifNotNil: [ :newOwner |
			item owner removeItem: item.
			item owner: newOwner.
			newOwner addItem: item ] ]
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> assignOrderWithBlock: aBlock [
	"Compute recursively MenuRegistration order"

	self itemList ifNotNil: [
		self itemList: (aBlock value: self itemList).
		self itemList do: [ :rded | rded assignOrderWithBlock: aBlock ] ]
]

{ #category : #'menu building' }
ToPragmaCleanMenuBuilder >> buildTree [
	"Retrieve all menu registrations with the help of a PragmaCollector then,
	reorganise the tree and sort it  - see class comment for more informations"

	self arrangeRegistrations.
	self sortRegistrations
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> builder [
	^ self
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> collectMisplacedItemsIn: aCollection [

	self itemList do: [ :item |
		item collectMisplacedItemsIn: aCollection ]
]

{ #category : #'registrations handling' }
ToPragmaCleanMenuBuilder >> collectRegistrations [
	"Retrieve all pragma methods and evaluate them by passing the
	MenuRegistration class as argument. The result is a list of trees
	stored in my itemList inst var"

	| aBuilder |
	aBuilder := ToPragmaCleanMenuBuilder new.
	self pragmas do: [ :prg |
		self
			currentRoot: self
			while: [
			prg methodClass instanceSide perform: prg methodSelector with: aBuilder ] ].
	self interpretRegistration: aBuilder
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> currentRoot [
	^ currentRoot
]

{ #category : #'menu building' }
ToPragmaCleanMenuBuilder >> currentRoot: anItem while: aBlock [

	| old |
	old := currentRoot.
	currentRoot := anItem.
	[ aBlock value ] ensure: [ currentRoot := old ].
]

{ #category : #API }
ToPragmaCleanMenuBuilder >> group: aSymbol [
	"Create a group"
	| item |
	item := self newSubItem.
	item group: aSymbol.
	^item
	
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> handOutItems [
	"we don't want to hold a reference to the items after they are hand out to the registration"

	| itemsCopy |
	itemsCopy := itemList copy.
	itemList removeAll.
	^ itemsCopy
]

{ #category : #initialization }
ToPragmaCleanMenuBuilder >> initialize [

	super initialize.
	currentRoot := self.
	pragmaKeywords := OrderedCollection new.
	itemList := OrderedCollection new.
	tree := ToCleanMenuRegistration new owner: self.
	isGroup := true
]

{ #category : #private }
ToPragmaCleanMenuBuilder >> interpretRegistration: aRegistration [

	| root |
	root := MenuRegistration owner: self.
	aRegistration handOutItems do: [ :item |
		| node |
		node := item group
			        ifNil: [ root item: item name ]
			        ifNotNil: [ :grp | root group: grp ].
		item with ifNil: [
			item action
				ifNil: [
					node
						target: item target;
						arguments: item arguments;
						selector: item selector ]
				ifNotNil: [ node action: item action ] ].
		node
			keyText: item keyText;
			help: item help;
			iconFormSet: item iconFormSet;
			order: item order;
			parent: item parent.
		item enabled
			ifNil: [ node enabledBlock: item enabledBlock ]
			ifNotNil: [ :boolean | node enabled: boolean ].
		item label ifNotNil: [ node label: item label ].
		item default ifNotNil: [ :d |
			node label: node label , ' (' , d asString , ')' ].
		item isWithSeparatorAfter ifTrue: [ node withSeparatorAfter ] ]
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> isGroup [
	^ isGroup
]

{ #category : #API }
ToPragmaCleanMenuBuilder >> item: aSymbol [
	"Add an item with name aSymbol as item in the list of item."
	
	^ self newSubItem
		  name: aSymbol;
		  yourself
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> itemList [

	^ itemList
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> itemList: aCollection [
	"Set the list of MenuRegistration"

	itemList := aCollection
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> itemNamed: aName [
	"Return the MenuRegistration named aName or nil if none is found"

	| result |
	self name = aName ifTrue: [ ^ self ].
	result := self itemList
		          detect: [ :item | (item itemNamed: aName) isNotNil ]
		          ifNone: [ ^ nil ].
	^ result itemNamed: aName
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> itemReceiver [
	^ model
]

{ #category : #'public menu building' }
ToPragmaCleanMenuBuilder >> menuSpec [
	"Returns a ToPluggableMenuSpec build from my contents"
	^ self menuSpecAt: nil
]

{ #category : #'public menu building' }
ToPragmaCleanMenuBuilder >> menuSpecAt: aName [
	"returns a PluggableMenuSpec build from my contents starting at
	the inner MenuRegistration named aName or from here if aName is nil"

	| root |
	self buildTree.
	root := ToPluggableMenuSpec withModel: nil.
	(aName ifNil: [ tree ] ifNotNil: [ self itemNamed: aName ])
		ifNotNil: [ :top |
		top precondition value ifTrue: [ top buildMenuSpec: root ] ].
	^ root
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> model [
	^ model
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> name [
	^ name
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> name: aSymbol [
	"set my name (should be unique over all menu items"

	name:= aSymbol
]

{ #category : #'menu building' }
ToPragmaCleanMenuBuilder >> newSubItem [

	| reg |
	reg := ToCleanMenuRegistration owner: currentRoot.
	currentRoot itemList add: reg.
	^ reg
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> parentName [

	^ parentName
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> parentName: aSymbol [

	parentName := aSymbol
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> pragmaKeyword: aString [
	"Set the pragma keyword used to select pragmas"
	pragmaKeywords add: aString asSymbol
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> pragmaKeywords [
	"Returns the pragma keyword used to select pragmas (see #pragmaCollector)"
	^  pragmaKeywords
]

{ #category : #accessing }
ToPragmaCleanMenuBuilder >> pragmaKeywords: aCollection [
	"Returns the pragma keyword used to select pragmas (see #pragmaCollector)"
	pragmaKeywords addAll: (aCollection collect: [:k | k asSymbol])
]

{ #category : #'registrations handling' }
ToPragmaCleanMenuBuilder >> pragmas [
	"Return all pragmas which keyword is self pragmaKeyword"

	^ (self pragmaKeywords flatCollect: [ :each | Pragma allNamed: each ])
		  select: [ :prg | prg methodSelector numArgs = 1 ]
]

{ #category : #removing }
ToPragmaCleanMenuBuilder >> removeItem: anItem [
	"Remove a MenuRegistration"

	self itemList remove: anItem
]

{ #category : #'registrations handling' }
ToPragmaCleanMenuBuilder >> sortRegistrations [
	"Try to update MenuRegistration order inst. var and the sort the trees"

	self assignOrderWithBlock: self class orderAssignBlock.
	tree sort: self class itemSortBlock
]

{ #category : #'as yet unclassified' }
ToPragmaCleanMenuBuilder >> tree [
	^ tree
]

{ #category : #API }
ToPragmaCleanMenuBuilder >> withSeparatorAfter [
	
	self flag: #todo. 
	"why current root is a builder and not a registration."
	currentRoot itemList first withSeparatorAfter
]
