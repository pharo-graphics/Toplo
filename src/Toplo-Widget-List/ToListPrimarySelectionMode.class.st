Class {
	#name : #ToListPrimarySelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'requestFocusOnMouseDown',
		'preserveSelectionOnFocused',
		'selectOnMouseDown',
		'deselectOnMouseDown',
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
ToListPrimarySelectionMode >> defaultSelectionElementOption [

	^ ToListSelectionElementOption new
		  grouped: true;
		  beneath: true;
		  triggerSelectionState: true;
		  elementFactory: [
			  ToListBasicSelectionElement new defaultSkin:
					  ToListPrimarySelectionElementSkin new ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> deselectOnMouseDown [

	^ deselectOnMouseDown
]

{ #category : #accessing }
ToListPrimarySelectionMode >> deselectOnMouseDown: aBoolean [

	deselectOnMouseDown := aBoolean
]

{ #category : #initialization }
ToListPrimarySelectionMode >> initialize [

	super initialize.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true.
	selectOnMouseDown := false.
	deselectOnMouseDown := true.
	multiple := true
]

{ #category : #testing }
ToListPrimarySelectionMode >> isMultipleSelection [

	^ multiple
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

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> newSelecter [

	^ ToPrimarySelecter new
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListPrimarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> newSelectionModelIn: aListElement [

	^ ToPrimarySelectionModel new
]

{ #category : #accessing }
ToListPrimarySelectionMode >> onAddedNode: aNode [

	aNode clickEventHandlerClasses do: [ :cls |
		aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListPrimarySelectionMode >> onClickEvent: anEvent onNode: aNode [
	" implement the default/standard selection/deselection protocol"

	| index modifiers |
	self isDisabled ifTrue: [ ^ self ].
	index := aNode holder position.
	modifiers := anEvent sourceEvent modifiers.

	" Multiple selection "
	self isMultipleSelection ifTrue: [ " SHIFT "
		modifiers isShift ifTrue: [
			| curr |
			curr := self selecter currentIndex.
			self selecter selectIndex: curr to: index.
			^ self ].
		" CMD-CTRL "
		(modifiers isPrimaryModifier or: [ selectOnMouseDown ]) ifTrue: [
			(self selectionModel containsIndex: index)
				ifTrue: [
				(modifiers isPrimaryModifier or: [ deselectOnMouseDown ]) ifTrue: [ self selecter deselectIndex: index ] ]
				ifFalse: [ self selecter selectIndex: index ].
			^ self ].
		" No modifier"
		self selecter selectOnlyIndex: index.
		^ self ].

	" Single selection "
	" CMD-CTRL  "
	(modifiers isPrimaryModifier or: [ selectOnMouseDown ]) ifTrue: [
		(deselectOnMouseDown and: [
			 self selectionModel containsIndex: index ]) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	" No modifier"
	self selecter selectOnlyIndex: index
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

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> selectionChangedEventClass [ 

	^ ToListPrimarySelectionChangedEvent
]
