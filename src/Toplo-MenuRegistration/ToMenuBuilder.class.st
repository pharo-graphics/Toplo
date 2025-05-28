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

	| itemsCopy |
	itemsCopy := collectedItems copy.
	itemsCopy do: [ :item |
		self handleGroupsUsage: item.
		self handleUnknownParent: item.
		item parentName ifNotNil: [ ]].
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
	anItem parentName: nil
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
		^ self findInCollectedItems: self ].
	newItem := ToMenuRegistration new name: aSymbol.
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
	self arrangeItems

	
]
