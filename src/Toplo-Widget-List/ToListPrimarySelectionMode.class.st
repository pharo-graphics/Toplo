Class {
	#name : #ToListPrimarySelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'requestFocusOnMouseDown',
		'preserveSelectionOnFocused',
		'selectOnMouseDown',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListPrimarySelectionMode >> allowRequestFocusOnMouseDown [

	| max |
	self isDisabled ifTrue: [ ^ self requestFocusOnMouseDown ].
	max := self maxSelectedIndexesForSelectionPreserving.
	self selectedIndexesCount > max ifTrue: [
		self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ self requestFocusOnMouseDown
]

{ #category : #accessing }
ToListPrimarySelectionMode >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListPrimarySelectionMode >> beSingleSelection [

	self multiple: false
]

{ #category : #initialization }
ToListPrimarySelectionMode >> defaultListEventHandlerClass [

	^ ToListPrimarySelectionElementEventHandler 
]

{ #category : #initialization }
ToListPrimarySelectionMode >> initialize [

	super initialize.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true.
	selectOnMouseDown := false.
	multiple := true
]

{ #category : #'api - hooks' }
ToListPrimarySelectionMode >> installOptionsIn: anElement [

	super installOptionsIn: anElement.
	beneathOption triggerSelectionState: true
	
]

{ #category : #testing }
ToListPrimarySelectionMode >> isMultipleSelection [

	^ multiple
]

{ #category : #testing }
ToListPrimarySelectionMode >> isPrimary [ 

	^ true
]

{ #category : #testing }
ToListPrimarySelectionMode >> isSelectableNode: aNode [

	^ aNode holder isSelectable and:
		  (self selectionModel containsIndex: aNode holder position)
]

{ #category : #testing }
ToListPrimarySelectionMode >> maxSelectedIndexesForSelectionPreserving [

	^ self isMultipleSelection
		       ifTrue: [ 1 ]
		       ifFalse: [ 0 ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListPrimarySelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #accessing }
ToListPrimarySelectionMode >> onAddedNode: aNode [

	aNode clickEventHandlerClasses do: [ :cls |
		aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListPrimarySelectionMode >> onClickEvent: anEvent onNode: aNode [
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
ToListPrimarySelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 aNode clickEventHandlerClasses anySatisfy: [ :cls |
			 handler class = cls ] ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListPrimarySelectionMode >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #accessing }
ToListPrimarySelectionMode >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToListPrimarySelectionMode >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean 
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnMouseDown [

	^ selectOnMouseDown
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnMouseDown: aBoolean [

	selectOnMouseDown := aBoolean
]

{ #category : #'event handling' }
ToListPrimarySelectionMode >> selectOrDeselectOnNode: aNode [

	| index target |
	index := aNode holder position.
	target := aNode holder listElement.
	(target selectionModel containsIndex: index)
		ifTrue: [ self selecter deselectIndex: index ]
		ifFalse: [ self selecter selectIndex: index ]
]
