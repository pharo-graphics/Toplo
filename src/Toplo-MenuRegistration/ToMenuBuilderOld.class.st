"
I'm responsible for the interpretation of menu registrations. 
"
Class {
	#name : #ToMenuBuilderOld,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'collectedItems',
		'pragmaKeywords',
		'conflicts'
	],
	#category : #'Toplo-MenuRegistration-Old'
}

{ #category : #examples }
ToMenuBuilderOld class >> aLittleMenu: aBuilder [

	<toploWorldMenu1>
	(aBuilder item: #RootWithTwoChildren)
		label: 'Root - Label'; 
		with: [
			(aBuilder item: #Child1) label: 'Child 1 - Label'.
			(aBuilder item: #Child2) label: 'Child 2 - Label' ]
]

{ #category : #examples }
ToMenuBuilderOld class >> exampleMenu [
	<script>
	| builder menuPane |
	builder := ToMenuBuilderOld new.

	(builder item: #MyFirstMenu)
		label: 'GrandParent';
		order: 3;
		groupName: 'aGroup';
		with: [
			(builder item: #MyFirstChild)
				parent: #MyFirstMenu;
				label: 'Uncle';
				order: 9999;
				withSeparatorAfter.
			(builder item: #MyFirstChild2)
				parent: #MyFirstMenu;
				label: 'Parent';
				order: 1;
				with: [ (builder item: #firstChildOfChild) label: 'Child' ] ];
				withSeparatorAfter.
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
	menuPane := builder accept: ToploVisitor new.
	menuPane openInSpace.
	builder inspect.
	
]

{ #category : #examples }
ToMenuBuilderOld class >> exampleMenuWithAction [

	<script>
	| builder |
	builder := ToMenuBuilderOld new.

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
ToMenuBuilderOld class >> exampleWorldMenu [
	<script>
	
	| builder menuPane |
	builder := (self pragmaKeyword: #worldMenu) collectRegistrations.
	builder resolve.
	"builder should accept the visitor it should kick the visitor."
	menuPane := builder accept: ToploVisitor new.
	menuPane openInSpace.
	menuPane inspect.
	builder inspect.
	
]

{ #category : #accessing }
ToMenuBuilderOld class >> pragmaKeyword: aPragmaKeyword [
	"Build a builder using aPragmaKeyword as the pragma keyword"
	
	^ self new pragmaKeywords: { aPragmaKeyword }
]

{ #category : #accessing }
ToMenuBuilderOld class >> pragmaKeywords: aCollection [
	
	^ self new
		pragmaKeywords: aCollection;
		yourself
]

{ #category : #visiting }
ToMenuBuilderOld >> accept: aVisitor [

	^ aVisitor visitMenuBuilder: self
]

{ #category : #adding }
ToMenuBuilderOld >> addConflict: aDuplicatedItem [

	conflicts add: aDuplicatedItem 
]

{ #category : #accessing }
ToMenuBuilderOld >> allNamedItems [

	^ collectedItems collect: [ :item | item name ]
]

{ #category : #editing }
ToMenuBuilderOld >> arrangeItems [

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
ToMenuBuilderOld >> arrangeItemsParameters [

	collectedItems do: [ :item |
		self handleDuplicatedShortcut: item.
		self handleUnknownParent: item.
		self handleAddToParent: item.
		self handleGroupsUsage: item. ]
]

{ #category : #editing }
ToMenuBuilderOld >> changeParent: aMenuRegistration for: aSymbol [
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
ToMenuBuilderOld >> collectRegistrations [
	"Retrieve all pragma methods and evaluate them by passing the
	MenuRegistration class as argument. The result is a list of trees
	stored in my itemList inst var"

	self pragmas do: [ :prg |
		prg methodClass instanceSide perform: prg methodSelector with: self ].
]

{ #category : #accessing }
ToMenuBuilderOld >> collectedItems [

	^ collectedItems 
]

{ #category : #accessing }
ToMenuBuilderOld >> collectedItems: anOrderedCollectionOfMenuRegistration [

	collectedItems := anOrderedCollectionOfMenuRegistration 
]

{ #category : #accessing }
ToMenuBuilderOld >> conflicts [

	^ conflicts
]

{ #category : #accessing }
ToMenuBuilderOld >> currentRoot [

	^ currentRoot
]

{ #category : #accessing }
ToMenuBuilderOld >> currentRoot: aMenuRegistration [

	currentRoot := aMenuRegistration
]

{ #category : #'menu protocol' }
ToMenuBuilderOld >> group: aSymbol [
	"Create a new group"

	| newGroup |
	(self groups includes: aSymbol) ifTrue: [
		^ self groupsNamed: aSymbol ].
	newGroup := (self item: aSymbol) groupName: aSymbol; isGroup: true.
	^ newGroup
]

{ #category : #accessing }
ToMenuBuilderOld >> groups [

	| groupsNames |
	groupsNames := OrderedCollection new.
	collectedItems do: [ :item |
		item isGroup ifTrue: [
			groupsNames add: item groupName ] ].
	^ groupsNames 
]

{ #category : #accessing }
ToMenuBuilderOld >> groupsNamed: aSymbol [

	^ self itemsNamed: aSymbol
]

{ #category : #adding }
ToMenuBuilderOld >> handleAddToParent: aMenuRegistration [

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
ToMenuBuilderOld >> handleDuplicatedShortcut: anItem [

	anItem shortcut ifNil: [ ^ self ].
	collectedItems do: [ :item |
		(anItem shortcut = item shortcut and: [ anItem ~= item] ) 
			ifTrue: [ self addConflict: (DuplicatedShortcut new shortcut: anItem shortcut). 
						^ self ] ].
]

{ #category : #'error handling' }
ToMenuBuilderOld >> handleGroupsUsage: anItem [

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
ToMenuBuilderOld >> handleUnknownParent: anItem [

	| pName |
	pName := anItem parent.
	((self allNamedItems includes: pName) or: [ pName isNil]) 
		ifTrue: [ ^ self ].
	self addConflict: (ParentNotFound new name: pName; itemName: anItem name).
	anItem parentMenuItem: nil
]

{ #category : #testing }
ToMenuBuilderOld >> hasConflict [

	^ conflicts isNotEmpty
]

{ #category : #testing }
ToMenuBuilderOld >> hasNoConflict [

	^ conflicts isEmpty
]

{ #category : #querying }
ToMenuBuilderOld >> indexOfChildNamed: aSymbol [

	1 to: collectedItems size do: [ :ind |
		(collectedItems at: ind) name = aSymbol ifTrue: [ ^ ind ] ].
	^ 1
]

{ #category : #initialization }
ToMenuBuilderOld >> initialize [

	super initialize.
	conflicts := OrderedCollection new. 
	currentRoot := ToMenuRegistrationOld new.
	collectedItems := OrderedCollection new.
]

{ #category : #accessing }
ToMenuBuilderOld >> isAnExistingGroup: aSymbol [

	^ self groups anySatisfy: [ :gName | gName = aSymbol ]
]

{ #category : #accessing }
ToMenuBuilderOld >> isInItems: aSymbol [

	^ collectedItems anySatisfy: [ :item | item name = aSymbol ]
]

{ #category : #adding }
ToMenuBuilderOld >> item: aSymbol [

	| newItem |
	(self isInItems: aSymbol) ifTrue: [
		self addConflict: (DuplicatedItem new
				 itemNamed: aSymbol;
				 yourself).
		^ self itemsNamed: aSymbol ].
	newItem := ToMenuRegistrationOld new
		           name: aSymbol;
		           builder: self.
	collectedItems add: newItem.
	^ newItem
]

{ #category : #querying }
ToMenuBuilderOld >> itemsNamed: aSymbol [

	collectedItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ currentRoot
]

{ #category : #querying }
ToMenuBuilderOld >> lookUpForParent: aMenuRegistration [
	|item|
	aMenuRegistration ifNil: [ ^ currentRoot ].
	item := self itemsNamed: aMenuRegistration.
	item isGroup ifFalse: [
		^ item ].
	^ self lookUpForParent: item parent
]

{ #category : #querying }
ToMenuBuilderOld >> onlyItems [

	^ collectedItems select: [ :item | item isGroup not ]
]

{ #category : #accessing }
ToMenuBuilderOld >> pragmaKeywords [

	^ pragmaKeywords
]

{ #category : #accessing }
ToMenuBuilderOld >> pragmaKeywords: aCollectionOfSymbol [

	pragmaKeywords := aCollectionOfSymbol
]

{ #category : #'spec accessing' }
ToMenuBuilderOld >> pragmas [
	"Return all pragmas which keyword is self pragmaKeyword"

	^ (self pragmaKeywords flatCollect: [ :each | Pragma allNamed: each ])
		  select: [ :prg | prg methodSelector numArgs = 1 ]
]

{ #category : #private }
ToMenuBuilderOld >> resolve [

	self arrangeItemsParameters.
	self arrangeItems
]

{ #category : #sorting }
ToMenuBuilderOld >> sortItems [

	collectedItems := collectedItems sorted: [ :c1 :c2 |
		                 c1 order <= c2 order ]
]

{ #category : #sorting }
ToMenuBuilderOld >> sortedTree: aMenuRegistration [

	aMenuRegistration childrenItems ifEmpty: [ ^ self ].
	aMenuRegistration sortChildren.
	aMenuRegistration childrenItems do: [ :child |
		self sortedTree: child ]
]

{ #category : #'spec accessing' }
ToMenuBuilderOld >> withSeparatorAfter [
	currentRoot withSeparatorAfter
]
