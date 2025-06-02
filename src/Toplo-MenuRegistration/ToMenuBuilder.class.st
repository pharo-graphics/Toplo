Class {
	#name : #ToMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'collectedItems',
		'hasNoConflict',
		'groups',
		'pragmaKeywords'
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

{ #category : #'as yet unclassified' }
ToMenuBuilder >> allNamedItems [

	^ collectedItems collect: [ :item | item name].
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> arrangeItems [

	| newCollectedItem |
	newCollectedItem := OrderedCollection new.
	collectedItems do: [ :item |
		item parentName ifNil: [ newCollectedItem add: item ] ].
	collectedItems := newCollectedItem.
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> arrangeItemsParameters [

	collectedItems do: [ :item |
		self handleGroupsUsage: item.
		self handleUnknownParent: item.
		self handleAddToParent: item ]
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> changeParent: aMenuRegistration for: aSymbol [
	"Change the parent for an item, if the item doesn't exist we create one"

	| item |
	item := self findInCollectedItems: aSymbol.
	item isCollection ifTrue: [ self item: aSymbol ].
	(item parentName = aMenuRegistration name or:
		 item parentName isNil) ifTrue: [
			item parentName: aMenuRegistration name.
			^ self
		].
	hasNoConflict := false.
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
ToMenuBuilder >> currentRoot [
	^ currentRoot
]

{ #category : #accessing }
ToMenuBuilder >> currentRoot: aMenuRegistration [
	currentRoot := aMenuRegistration
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> findInCollectedItems: aSymbol [
	collectedItems do: [ :item | (item name = aSymbol) ifTrue: [^ item]].
	^ currentRoot
]

{ #category : #'menu protocol' }
ToMenuBuilder >> group: aSymbol [
	"Create a new group"
	groups at: aSymbol put: OrderedCollection new
]

{ #category : #accessing }
ToMenuBuilder >> groups [
	^ groups
]

{ #category : #accessing }
ToMenuBuilder >> groups: aDictionnary [
	groups := aDictionnary
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> handleAddToParent: aMenuRegistration [

	| parentMenu |
	aMenuRegistration parentName ifNil: [ currentRoot addChild: aMenuRegistration. ^ self ].
	parentMenu := self findInCollectedItems: aMenuRegistration parentName.
	aMenuRegistration parent: parentMenu.
	parentMenu addChild: aMenuRegistration
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> handleGroupsUsage: anItem [

	anItem groupName ifNil: [ ^ self ].
	(self isAnExistingGroup: anItem groupName) ifFalse: [
		self group: anItem groupName ].
	(groups at: anItem groupName) add: anItem
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> handleUnknownParent: anItem [

	| pName |
	pName := anItem parentName.
	((self allNamedItems includes: pName) or: pName isNil) ifTrue: [
		^ self ].
	hasNoConflict := false.
	anItem parentName: nil.
	anItem parent: nil.
]

{ #category : #accessing }
ToMenuBuilder >> hasNoConflict [
	^ hasNoConflict
]

{ #category : #accessing }
ToMenuBuilder >> hasNoConflict: aBoolean [
	hasNoConflict := aBoolean
]

{ #category : #initialization }
ToMenuBuilder >> initialize [

	super initialize.
	hasNoConflict := true.
	currentRoot := ToMenuRegistration new.
	collectedItems := OrderedCollection new.
	groups := Dictionary new.
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> isAnExistingGroup: aSymbol [
	^ groups keys anySatisfy: [ :key | key = aSymbol ]
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> isInCollectedItems: aSymbol [

	^ collectedItems anySatisfy: [ :item | item name = aSymbol ]
]

{ #category : #'as yet unclassified' }
ToMenuBuilder >> item: aSymbol [

	| newItem |
	(self isInCollectedItems: aSymbol) ifTrue: [
		hasNoConflict := false.
		^ self findInCollectedItems: aSymbol ].
	newItem := ToMenuRegistration new name: aSymbol; builder: self.
	collectedItems add: newItem.
	^ newItem
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
