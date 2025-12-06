Class {
	#name : #NewPragmaMenuBuilder,
	#superclass : #MenuDescription,
	#instVars : [
		'pragmaKeywords',
		'model',
		'currentRoot'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #private }
NewPragmaMenuBuilder class >> itemSortBlock [
	"The block which is used to sort a menu tree"
	^ [:a :b |
		((a order isNotNil and: [b order isNotNil]) and: [a order ~= b order])
			ifTrue: [a order < b order]
			ifFalse: [((a order isNil and: [b order isNil]) or: [a order = b order])
				ifTrue: [true]
				ifFalse: [a order ifNil: [false] ifNotNil: [true]]]]
]

{ #category : #private }
NewPragmaMenuBuilder class >> orderAssignBlock [
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
NewPragmaMenuBuilder class >> pragmaKeyword: aPragmaKeyword model: aModel [
	"Build a builder using aPragmaKeyword as the pragma keyword and aModel a the model of the resulting builder"
	^ self withAllPragmaKeywords: {aPragmaKeyword} model: aModel
]

{ #category : #'instance creation' }
NewPragmaMenuBuilder class >> withAllPragmaKeywords: aCollection model: aModel [
	"Build a builder using aPragmaKeyword as the pragma keyword and aModel a the model of the resulting builder"
	^ self new
		pragmaKeywords: aCollection;
		model: aModel;
		yourself
]

{ #category : #'registrations handling' }
NewPragmaMenuBuilder >> allMisplacedItems [
	| misplaced |
	self collectMisplacedItemsIn: (misplaced := OrderedCollection new).
	^ misplaced
]

{ #category : #'registrations handling' }
NewPragmaMenuBuilder >> arrangeRegistrations [

	self allMisplacedItems do: [ :item |
			(self itemNamed: item parentName) 
				ifNotNil: [ :newOwner |
					item owner removeItem: item.
					item owner: newOwner.
					newOwner addItem: item ] ]
]

{ #category : #'menu building' }
NewPragmaMenuBuilder >> buildTree [
	"Retrieve all menu registrations with the help of a PragmaCollector then,
	reorganise the tree and sort it  - see class comment for more informations"
	itemList := OrderedCollection new.
	self collectRegistrations.
	self arrangeRegistrations.
	self sortRegistrations
]

{ #category : #accessing }
NewPragmaMenuBuilder >> builder [
	^ self
]

{ #category : #'registrations handling' }
NewPragmaMenuBuilder >> collectRegistrations [
	"Retrieve all pragma methods and evaluate them by passing the
	MenuRegistration class as argument. The result is a list of trees
	stored in my itemList inst var"

	| menu |
	menu := MenuDescription new. 
	self pragmas do: [ :prg | 
		self currentRoot: self while: [ prg methodClass instanceSide 
			perform: prg methodSelector with: menu ] ].
	self interpretRegistration: menu
]

{ #category : #'menu building' }
NewPragmaMenuBuilder >> currentRoot: anItem while: aBlock [
	| old |
	old := currentRoot.
	currentRoot := anItem.
	[aBlock value] ensure: [currentRoot := old]
]

{ #category : #'menu building' }
NewPragmaMenuBuilder >> handOutItems [
	"we don't want to hold a reference to the items after they are hand out to the registration"

	"| itemsCopy |
	itemsCopy := itemList copy.
	itemList removeAll.
	^ itemsCopy
	"
	
]

{ #category : #initialization }
NewPragmaMenuBuilder >> initialize [
	super initialize.
	isGroup := true.
	currentRoot := self.
	pragmaKeywords := OrderedCollection new
]

{ #category : #private }
NewPragmaMenuBuilder >> interpretRegistration: aRegistration [

	| root |
	root := NewPragmaMenuBuilder owner: self.
	aRegistration handOutItems do: [ :item |
			| node |
			node := item group 
				ifNil: [ root item: item item ] 
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
			item default 
				ifNotNil: [ :d | node label: node label , ' (' , d asString , ')' ].
			item isWithSeparatorAfter ifTrue: [ node withSeparatorAfter ] ]
]

{ #category : #accessing }
NewPragmaMenuBuilder >> itemReceiver [
	^ model
]

{ #category : #'public menu building' }
NewPragmaMenuBuilder >> menuSpec [
	"returns a PluggableMenuSpec build from my contents"
	^ self menuSpecAt: nil
]

{ #category : #'public menu building' }
NewPragmaMenuBuilder >> menuSpecAt: aName [
	"returns a MenuSpec build from my contents starting at
	the inner MenuDescription named aName or from here if aName is nil"

	| root |
	self buildTree.
	root := SMenuSpec withModel: nil.
	(aName ifNil: [ self ] 
		ifNotNil: [ self itemNamed: aName ]) 
		ifNotNil: [ :top | top precondition value 
			ifTrue: [ top buildMenuSpec: root ] ].
	^ root
]

{ #category : #accessing }
NewPragmaMenuBuilder >> model [
	^ model
]

{ #category : #accessing }
NewPragmaMenuBuilder >> model: anObject [
	model := anObject
]

{ #category : #'menu building' }
NewPragmaMenuBuilder >> newSubItem [

	| reg |
	"may be it should be MenuDescription"
	
	reg := self class owner: currentRoot.
	currentRoot addItem: reg.
	^ reg
]

{ #category : #accessing }
NewPragmaMenuBuilder >> pragmaKeyword: aString [
	"Set the pragma keyword used to select pragmas"
	pragmaKeywords add: aString asSymbol
]

{ #category : #accessing }
NewPragmaMenuBuilder >> pragmaKeywords [
	"Returns the pragma keyword used to select pragmas (see #pragmaCollector)"
	^  pragmaKeywords
]

{ #category : #accessing }
NewPragmaMenuBuilder >> pragmaKeywords: aCollection [
	"Returns the pragma keyword used to select pragmas (see #pragmaCollector)"
	pragmaKeywords addAll: (aCollection collect: [:k | k asSymbol])
]

{ #category : #'registrations handling' }
NewPragmaMenuBuilder >> pragmas [
	"Return all pragmas which keyword is self pragmaKeyword"

	^ (self pragmaKeywords flatCollect: [ :each | Pragma allNamed: each ]) 
		select: [ :prg | prg methodSelector numArgs = 1 ]
]

{ #category : #'registrations handling' }
NewPragmaMenuBuilder >> sortRegistrations [
	"Try to update MenuRegistration order inst. var and the sort the trees"
	self assignOrderWithBlock: self class orderAssignBlock.
	self sort: self class itemSortBlock
]
