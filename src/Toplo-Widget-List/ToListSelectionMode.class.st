Class {
	#name : #ToListSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'requestFocusOnMouseDown',
		'preserveSelectionOnFocused',
		'selectOnMouseDown'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSelectionMode >> allowRequestFocusOnMouseDown [

	| max |
	self isDisabled ifTrue: [ ^ self requestFocusOnMouseDown ].
	max := self maxSelectedIndexesForSelectionPreserving.
	self selectedIndexesCount > max ifTrue: [
		self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ self requestFocusOnMouseDown
]

{ #category : #initialization }
ToListSelectionMode >> initialize [

	super initialize.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true.
	selectOnMouseDown := false
]

{ #category : #testing }
ToListSelectionMode >> maxSelectedIndexesForSelectionPreserving [

	^ self isMultipleSelection
		       ifTrue: [ 1 ]
		       ifFalse: [ 0 ]
]

{ #category : #'event handling' }
ToListSelectionMode >> onClickEvent: anEvent onNode: aNode [
	" implement the default/standard selection/deselection protocol"

	self isDisabled ifTrue: [ ^ self ].

	" Multiple selection "
	self isMultipleSelection ifTrue: [ " SHIFT "
		anEvent sourceEvent modifiers isShift ifTrue: [
			| curr |
			curr := self selecter currentIndex.
			self selecter selectIndex: curr to: aNode holder position.
			^ self ].
		" CMD-CTRL "
		(anEvent sourceEvent modifiers isPrimaryModifier or: [
			 selectOnMouseDown ]) ifTrue: [
			self selectOrDeselectOnNode: aNode.
			^ self ].
		" No modifier"
		self selecter selectOnlyIndex: aNode holder position.
		^ self ].

	" Single selection "
	" CMD-CTRL  "
	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 selectOnMouseDown ]) ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	" No modifier"
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #accessing }
ToListSelectionMode >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToListSelectionMode >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean 
]

{ #category : #accessing }
ToListSelectionMode >> selectOnMouseDown [

	^ selectOnMouseDown
]

{ #category : #accessing }
ToListSelectionMode >> selectOnMouseDown: aBoolean [

	selectOnMouseDown := aBoolean
]

{ #category : #'event handling' }
ToListSelectionMode >> selectOrDeselectOnNode: aNode [

	| index target |
	index := aNode holder position.
	target := aNode holder listElement.
	(target selectionModel containsIndex: index)
		ifTrue: [ self selecter deselectIndex: index ]
		ifFalse: [ self selecter selectIndex: index ]
]
