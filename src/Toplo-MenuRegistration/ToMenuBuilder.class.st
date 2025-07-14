"
I'm responsible for the interpretation of menu registrations. 
"
Class {
	#name : #ToMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'collectedItems',
		'pragmaKeywords',
		'conflicts'
	],
	#category : #'Toplo-MenuRegistration-Core'
}

{ #category : #examples }
ToMenuBuilder class >> aLittleMenu: aBuilder [

	<toploWorldMenu1>
	(aBuilder item: #RootWithTwoChildren)
		label: 'Root - Label'; 
		with: [
			(aBuilder item: #Child1) label: 'Child 1 - Label'.
			(aBuilder item: #Child2) label: 'Child 2 - Label' ]
]

{ #category : #examples }
ToMenuBuilder class >> exampleMenu [
	<script>
	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyFirstMenu)
		label: 'GrandParent';
		order: 3;
		groupName: 'aGroup';
		with: [
			(builder item: #MyFirstChild)
				parent: #MyFirstMenu;
				label: 'Uncle';
				order: 9999.
			(builder item: #MyFirstChild2)
				parent: #MyFirstMenu;
				label: 'Parent';
				order: 1;
				with: [ (builder item: #firstChildOfChild) label: 'Child' ] ].
	(builder item: #MySecondMenu)
		label: 'AnotherParent';
		order: 1;
		with: [
			(builder item: #MySecondMenuChild1)
				parent: #MySecondMenu;
				label: 'AnotherChild1';
				order: 1.
			(builder item: #MySecondMenuChild2)
				label: 'AnotherChild2';
				order: 3.
			(builder item: #MySecondMenuChild3)
				parent: 'UnknownParent';
				label: 'AnotherChild3';
				order:  2].
	builder resolve.
	builder accept: ToploVisitor new.
	builder inspect.
]

{ #category : #examples }
ToMenuBuilder class >> exampleMenuWithAction [

	<script>
	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyFirstMenu)
		label: 'Parent';
		order: 3;
		groupName: 'aGroup';
		with: [
			(builder item: #Playground)
				parent: #MyFirstMenu;
				action: [ Smalltalk tools openWorkspace ];
				label: 'Open a playground';
				order: 9999.
			].
	builder resolve.
	builder accept: ToploVisitor new.
	builder inspect
]

{ #category : #examples }
ToMenuBuilder class >> exampleWorldMenu [

	<script>
	| builder |
	builder := (self pragmaKeyword: #worldMenu) collectRegistrations.
	builder resolve.
	builder accept: ToploVisitor new.
	builder inspect
]

{ #category : #accessing }
ToMenuBuilder class >> pragmaKeyword: aPragmaKeyword [
	"Build a builder using aPragmaKeyword as the pragma keyword"
	
	^ self new pragmaKeywords: { aPragmaKeyword }
]

{ #category : #accessing }
ToMenuBuilder class >> pragmaKeywords: aCollection [
	
	^ self new
		pragmaKeywords: aCollection;
		yourself
]

{ #category : #visiting }
ToMenuBuilder >> accept: aVisitor [

	^ aVisitor visitMenuBuilder: self
]

{ #category : #adding }
ToMenuBuilder >> addConflict: aDuplicatedItem [

	conflicts add: aDuplicatedItem 
]

{ #category : #accessing }
ToMenuBuilder >> allNamedItems [

	^ collectedItems collect: [ :item | item name ]
]

{ #category : #editing }
ToMenuBuilder >> arrangeItems [

	| newCollectedItem |
	newCollectedItem := OrderedCollection new.
	collectedItems do: [ :item |
		(item parent isNil or:
			 [ (self allNamedItems includes: item parent) not] ) ifTrue: [
			newCollectedItem add: item ] ].
	collectedItems := newCollectedItem.
	self sortItems.
	collectedItems do: [ :item | self sortedTree: item ]
]

{ #category : #editing }
ToMenuBuilder >> arrangeItemsParameters [

	collectedItems do: [ :item |
		self handleDuplicatedShortcut: item.
		self handleUnknownParent: item.
		self handleAddToParent: item.
		self handleGroupsUsage: item. ]
]

{ #category : #editing }
ToMenuBuilder >> changeParent: aMenuRegistration for: aSymbol [
	"Change the parent for an item, if the item doesn't exist we create one"

	| item |
	item := self itemsNamed: aSymbol.
	item isCollection ifTrue: [ self item: aSymbol ].
	(item parent = aMenuRegistration name or: [ item parent isNil] )
		ifFalse: [ self addConflict: WrongParentPlacement new ].
	item groupName ifNil: [ item groupName: aMenuRegistration groupName ].
	item parent: aMenuRegistration name
]

{ #category : #'spec accessing' }
ToMenuBuilder >> collectRegistrations [
	"Retrieve all pragma methods and evaluate them by passing the
	MenuRegistration class as argument. The result is a list of trees
	stored in my itemList inst var"

	self pragmas do: [ :prg |
		prg methodClass instanceSide perform: prg methodSelector with: self ].
]

{ #category : #accessing }
ToMenuBuilder >> collectedItems [

	^ collectedItems 
]

{ #category : #accessing }
ToMenuBuilder >> collectedItems: anOrderedCollectionOfMenuRegistration [

	collectedItems := anOrderedCollectionOfMenuRegistration 
]

{ #category : #accessing }
ToMenuBuilder >> conflicts [

	^ conflicts
]

{ #category : #accessing }
ToMenuBuilder >> currentRoot [

	^ currentRoot
]

{ #category : #accessing }
ToMenuBuilder >> currentRoot: aMenuRegistration [

	currentRoot := aMenuRegistration
]

{ #category : #'menu protocol' }
ToMenuBuilder >> group: aSymbol [
	"Create a new group"

	| newGroup |
	(self groups includes: aSymbol) ifTrue: [
		^ self groupsNamed: aSymbol ].
	newGroup := (self item: aSymbol) groupName: aSymbol; isGroup: true.
	^ newGroup
]

{ #category : #accessing }
ToMenuBuilder >> groups [

	| groupsNames |
	groupsNames := OrderedCollection new.
	collectedItems do: [ :item |
		item isGroup ifTrue: [
			groupsNames add: item groupName ] ].
	^ groupsNames 
]

{ #category : #accessing }
ToMenuBuilder >> groupsNamed: aSymbol [

	^ self itemsNamed: aSymbol
]

{ #category : #adding }
ToMenuBuilder >> handleAddToParent: aMenuRegistration [

	| parentMenu |
	(aMenuRegistration parent isNil or: [  
		 (self allNamedItems includes: aMenuRegistration parent) not ] )
		ifTrue: [
			currentRoot addChild: aMenuRegistration.
			^ self ].
	((self itemsNamed: aMenuRegistration parent) isGroup)
		ifTrue: [ aMenuRegistration groupName: aMenuRegistration parent ].
	parentMenu := self lookUpForParent: aMenuRegistration parent.
	aMenuRegistration parentMenuItem: parentMenu.
	parentMenu addChild: aMenuRegistration.
	aMenuRegistration
]

{ #category : #'error handling' }
ToMenuBuilder >> handleDuplicatedShortcut: anItem [

	anItem shortcut ifNil: [ ^ self ].
	collectedItems do: [ :item |
		(anItem shortcut = item shortcut and: [ anItem ~= item] ) 
			ifTrue: [ self addConflict: (DuplicatedShortcut new shortcut: anItem shortcut). 
						^ self ] ].
]

{ #category : #'error handling' }
ToMenuBuilder >> handleGroupsUsage: anItem [

	anItem name ifNil: [ ^ self ].
	(self groups includes: anItem name) ifTrue: [ ^ self ].
	anItem parentMenuItem ifNotNil: [
		(anItem groupName isNil and:
			 [ anItem parentMenuItem groupName isNotNil]) ifTrue: [
			anItem groupName: anItem parentMenuItem groupName ] ].
	anItem groupName ifNil: [ ^ self ].
	(self isAnExistingGroup: anItem groupName) ifFalse: [
		self group: anItem groupName ].
	(self groupsNamed: anItem groupName) addChild: anItem
]

{ #category : #'error handling' }
ToMenuBuilder >> handleUnknownParent: anItem [

	| pName |
	pName := anItem parent.
	((self allNamedItems includes: pName) or: [ pName isNil]) 
		ifTrue: [ ^ self ].
	self addConflict: ParentNotFound new.
	anItem parentMenuItem: nil
]

{ #category : #testing }
ToMenuBuilder >> hasConflict [

	^ conflicts isNotEmpty
]

{ #category : #testing }
ToMenuBuilder >> hasNoConflict [

	^ conflicts isEmpty
]

{ #category : #querying }
ToMenuBuilder >> indexOfChildNamed: aSymbol [

	1 to: collectedItems size do: [ :ind |
		(collectedItems at: ind) name = aSymbol ifTrue: [ ^ ind ] ].
	^ 1
]

{ #category : #initialization }
ToMenuBuilder >> initialize [

	super initialize.
	conflicts := OrderedCollection new. 
	currentRoot := ToMenuRegistration new.
	collectedItems := OrderedCollection new.
]

{ #category : #accessing }
ToMenuBuilder >> isAnExistingGroup: aSymbol [

	^ self groups anySatisfy: [ :gName | gName = aSymbol ]
]

{ #category : #accessing }
ToMenuBuilder >> isInItems: aSymbol [

	^ collectedItems anySatisfy: [ :item | item name = aSymbol ]
]

{ #category : #adding }
ToMenuBuilder >> item: aSymbol [

	| newItem |
	(self isInItems: aSymbol) ifTrue: [
		self addConflict: (DuplicatedItem new
				 itemNamed: aSymbol;
				 yourself).
		^ self itemsNamed: aSymbol ].
	newItem := ToMenuRegistration new
		           name: aSymbol;
		           builder: self.
	collectedItems add: newItem.
	^ newItem
]

{ #category : #querying }
ToMenuBuilder >> itemsNamed: aSymbol [

	collectedItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ currentRoot
]

{ #category : #querying }
ToMenuBuilder >> lookUpForParent: aMenuRegistration [
	|item|
	aMenuRegistration ifNil: [ ^ currentRoot ].
	item := self itemsNamed: aMenuRegistration.
	item isGroup ifFalse: [
		^ item ].
	^ self lookUpForParent: item parent
]

{ #category : #querying }
ToMenuBuilder >> onlyItems [

	^ collectedItems select: [ :item | item isGroup not ]
]

{ #category : #accessing }
ToMenuBuilder >> pragmaKeywords [

	^ pragmaKeywords
]

{ #category : #accessing }
ToMenuBuilder >> pragmaKeywords: aCollectionOfSymbol [

	pragmaKeywords := aCollectionOfSymbol
]

{ #category : #'spec accessing' }
ToMenuBuilder >> pragmas [
	"Return all pragmas which keyword is self pragmaKeyword"

	^ (self pragmaKeywords flatCollect: [ :each | Pragma allNamed: each ])
		  select: [ :prg | prg methodSelector numArgs = 1 ]
]

{ #category : #private }
ToMenuBuilder >> resolve [

	self arrangeItemsParameters.
	self arrangeItems
]

{ #category : #sorting }
ToMenuBuilder >> sortItems [

	collectedItems := collectedItems sorted: [ :c1 :c2 |
		                 c1 order <= c2 order ]
]

{ #category : #sorting }
ToMenuBuilder >> sortedTree: aMenuRegistration [

	aMenuRegistration childrenItems ifEmpty: [ ^ self ].
	aMenuRegistration sortChildren.
	aMenuRegistration childrenItems do: [ :child |
		self sortedTree: child ]
]

{ #category : #'spec accessing' }
ToMenuBuilder >> withSeparatorAfter [
	currentRoot withSeparatorAfter
]
