Class {
	#name : #ToListPrimarySelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'requestFocusOnPressed',
		'preserveSelectionOnFocused',
		'selectOnPressed',
		'deselectOnPressed',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListPrimarySelectionMode >> allowRequestFocusOnMouseDown [

	| max |
	self isDisabled ifTrue: [ ^ self requestFocusOnPressed ].
	max := self maxSelectedIndexesForSelectionPreserving.
	self selectedIndexesCount > max ifTrue: [
		self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ self requestFocusOnPressed
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
ToListPrimarySelectionMode >> defaultSelectionOption [

	^ ToListSelectionOption new
		  grouped: true;
		  beneath: true;
		  triggerSelectionState: true;
		  elementFactory: [
			  ToListPrimarySelectionElement new ]
]

{ #category : #accessing }
ToListPrimarySelectionMode >> deselectOnPressed [

	^ deselectOnPressed
]

{ #category : #accessing }
ToListPrimarySelectionMode >> deselectOnPressed: aBoolean [

	deselectOnPressed := aBoolean
]

{ #category : #initialization }
ToListPrimarySelectionMode >> initialize [

	super initialize.
	requestFocusOnPressed := true.
	preserveSelectionOnFocused := true.
	selectOnPressed := false.
	deselectOnPressed := false.
	multiple := true
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

	aNode clickEventHandlerClass ifNotNil: [ :cls |
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
		(modifiers isPrimaryModifier or: [
			 selectOnPressed or: [ deselectOnPressed ] ]) ifTrue: [
			(self selectionModel containsIndex: index)
				ifTrue: [
					(modifiers isPrimaryModifier or: [ deselectOnPressed ])
						ifTrue: [ self selecter deselectIndex: index ] ]
				ifFalse: [ self selecter selectIndex: index ].
			^ self ].
		" No modifier"
		self selecter selectOnlyIndex: index.
		^ self ].

	" Single selection "
	" CMD-CTRL  "
	(modifiers isPrimaryModifier or: [ selectOnPressed ]) ifTrue: [
		(deselectOnPressed and: [
			 self selectionModel containsIndex: index ]) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	" No modifier"
	self selecter selectOnlyIndex: index
]

{ #category : #accessing }
ToListPrimarySelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 handler class = aNode clickEventHandlerClass ]) do: [ :handler |
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
ToListPrimarySelectionMode >> requestFocusOnPressed [

	^ requestFocusOnPressed
]

{ #category : #accessing }
ToListPrimarySelectionMode >> requestFocusOnPressed: aBoolean [

	requestFocusOnPressed := aBoolean 
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnPressed [

	^ selectOnPressed
]

{ #category : #accessing }
ToListPrimarySelectionMode >> selectOnPressed: aBoolean [

	selectOnPressed := aBoolean
]

{ #category : #'instance creation' }
ToListPrimarySelectionMode >> selectionChangedEventClass [ 

	^ ToListPrimarySelectionChangedEvent
]

{ #category : #accessing }
ToListPrimarySelectionMode >> single: aBoolean [

	self multiple: aBoolean not
]
