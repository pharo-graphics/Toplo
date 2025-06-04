Class {
	#name : #ToMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'collectedItems',
		'hasNoConflict',
		'groups',
		'pragmaKeywords',
		'conflicts'
	],
	#category : #'Toplo-MenuRegistration-NewCreate'
}

{ #category : #'menu declaring' }
ToMenuBuilder class >> aLittleMenu: aBuilder [

	<toploWorldMenu1>
	(aBuilder item: #Im) with: [
		aBuilder item: #aSuperMenu.
		aBuilder item: #anUglyMenu ]
]

{ #category : #accessing }
ToMenuBuilder class >> pragmaKeyword: aPragmaKeyword [
	"Build a builder using aPragmaKeyword as the pragma keyword "
	
	^ self new pragmaKeywords: {aPragmaKeyword}
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

	^ collectedItems collect: [ :item | item name].
]

{ #category : #editing }
ToMenuBuilder >> arrangeItems [

	| newCollectedItem |
	newCollectedItem := OrderedCollection new.
	collectedItems do: [ :item |
		(item parent isNil or:
			 (self allNamedItems includes: item parent) not) ifTrue: [
			newCollectedItem add: item ] ].
	collectedItems := newCollectedItem.
	self sortItems.
	collectedItems do: [ :item | self sortedTree: item ]
]

{ #category : #editing }
ToMenuBuilder >> arrangeItemsParameters [

	collectedItems do: [ :item |
		self handleDuplicatedShortcut: item.
		self handleGroupsUsage: item.
		self handleUnknownParent: item.
		self handleAddToParent: item ]
]

{ #category : #editing }
ToMenuBuilder >> changeParent: aMenuRegistration for: aSymbol [
	"Change the parent for an item, if the item doesn't exist we create one"

	| item |
	item := self itemsNamed: aSymbol.
	item isCollection ifTrue: [ self item: aSymbol ].
	(item parent = aMenuRegistration name or: item parent isNil) ifFalse: [
 		self addConflict: WrongParentPlacement new. 	
	].
	item parent: aMenuRegistration name.
		item groupName: aMenuRegistration groupName.
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
	newGroup := ToMenuRegistration new
		            groupName: aSymbol;
		            builder: self.
	collectedItems add: newGroup.
	^ newGroup
]

{ #category : #accessing }
ToMenuBuilder >> groups [
	|groupsNames|
	groupsNames := OrderedCollection new. 
	collectedItems do: [ :item |
		  item name ifNil: [ groupsNames add: item groupName ] ].
	^ groupsNames
]

{ #category : #accessing }
ToMenuBuilder >> groupsNamed: aSymbol [

	collectedItems do: [ :item |
		(item groupName = aSymbol and: item name isNil) ifTrue: [ ^ item ] ].
	^ currentRoot
]

{ #category : #adding }
ToMenuBuilder >> handleAddToParent: aMenuRegistration [

	| parentMenu |
	(aMenuRegistration parent isNil or:
		 (self allNamedItems includes: aMenuRegistration parent) not)
		ifTrue: [
			currentRoot addChild: aMenuRegistration.
			^ self ].
	parentMenu := self itemsNamed: aMenuRegistration parent.
	aMenuRegistration parentMenuItem: parentMenu.
	parentMenu addChild: aMenuRegistration
]

{ #category : #'error handling' }
ToMenuBuilder >> handleDuplicatedShortcut: anItem [

	(anItem shortcut isNil) ifTrue: [ ^ self ].
	collectedItems do: [ :item |
		(anItem shortcut = item shortcut and: anItem ~= item) ifTrue: [ self addConflict: (DuplicatedShortcut new shortcut: anItem shortcut). ^ self ] ].
]

{ #category : #'error handling' }
ToMenuBuilder >> handleGroupsUsage: anItem [

	(anItem groupName isNil or: anItem name isNil) ifTrue: [ ^ self ].
	(self isAnExistingGroup: anItem groupName) ifFalse: [
		self group: anItem groupName ].
	(self groupsNamed: anItem groupName) addChild: anItem
]

{ #category : #'error handling' }
ToMenuBuilder >> handleUnknownParent: anItem [

	| pName |
	pName := anItem parent.
	((self allNamedItems includes: pName) or: pName isNil) ifTrue: [
		^ self ].
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

{ #category : #initialization }
ToMenuBuilder >> initialize [

	super initialize.
	conflicts := OrderedCollection new. 
	currentRoot := ToMenuRegistration new.
	collectedItems := OrderedCollection new.
	groups := Dictionary new
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

{ #category : #accessing }
ToMenuBuilder >> itemsNamed: aSymbol [

	collectedItems do: [ :item | item name = aSymbol ifTrue: [ ^ item ] ].
	^ currentRoot
]

{ #category : #accessing }
ToMenuBuilder >> pragmaKeywords [
	^ pragmaKeywords
]

{ #category : #accessing }
ToMenuBuilder >> pragmaKeywords: aCollectionOfSymbol [
	pragmaKeywords := aCollectionOfSymbol.
]

{ #category : #'as yet unclassified' }
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
	aMenuRegistration childrenItems do: [ :child | self sortedTree: child ].
]
