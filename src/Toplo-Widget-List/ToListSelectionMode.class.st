Class {
	#name : #ToListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'selectionModel',
		'operator',
		'selecter',
		'multiple',
		'requestFocusOnMouseDown',
		'preserveSelectionOnFocused',
		'selectOnMouseDown',
		'enabled',
		'primary'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionMode class >> primaryOn: anElement [

	| primary |
	primary := self new.
	primary
		operator: (ToPrimarySelectionModelOperator on: anElement);
		selectionModel: (anElement newPrimarySelectionModel onInstalledIn: anElement).
	primary primary: true.
	^ primary
]

{ #category : #'instance creation' }
ToListSelectionMode class >> secondaryOn: anElement [

	| secondary |
	secondary := self new.
	secondary
		operator: (ToSecondarySelectionModelOperator on: anElement);
		selectionModel: (anElement newSecondarySelectionModel onInstalledIn: anElement).
	secondary primary: false.
	^ secondary
]

{ #category : #testing }
ToListSelectionMode >> allowRequestFocusOnMouseDown [

	| max |
	self isDisabled ifTrue: [ ^ self requestFocusOnMouseDown ].
	max := self isMultipleSelection
		       ifTrue: [ 1 ]
		       ifFalse: [ 0 ].
	self selectedIndexesCount > max ifTrue: [
		self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ self requestFocusOnMouseDown
]

{ #category : #accessing }
ToListSelectionMode >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToListSelectionMode >> beSingleSelection [

	self multiple: false
]

{ #category : #accessing }
ToListSelectionMode >> disable [

	self enabled: false
]

{ #category : #accessing }
ToListSelectionMode >> enable [

	self enabled: true
]

{ #category : #accessing }
ToListSelectionMode >> enabled [

	^ enabled
]

{ #category : #accessing }
ToListSelectionMode >> enabled: aBoolean [

	enabled := aBoolean.
	selecter := nil
]

{ #category : #initialization }
ToListSelectionMode >> initialize [ 

	super initialize.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true.
	selectOnMouseDown := false.
	multiple := true.
	enabled := true

]

{ #category : #testing }
ToListSelectionMode >> isDisabled [

	^ self enabled not
]

{ #category : #testing }
ToListSelectionMode >> isEnabled [

	^ self enabled
]

{ #category : #testing }
ToListSelectionMode >> isMultipleSelection [

	^ self multiple
]

{ #category : #testing }
ToListSelectionMode >> isPrimarySelectionMode [

	^ primary
]

{ #category : #accessing }
ToListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToListSelectionMode >> multiple [

	^ multiple
]

{ #category : #accessing }
ToListSelectionMode >> multiple: aBoolean [

	multiple := aBoolean
]

{ #category : #'instance creation' }
ToListSelectionMode >> newSelecter [

	^ self isDisabled
		  ifTrue: [ ToNoneSelecter new ]
		  ifFalse: [
			  (ToPredefinedSelecter
				   selectionModel: self selectionModel
				   operator: self operator)
				  multiple: self isMultipleSelection;
				  yourself ]
]

{ #category : #accessing }
ToListSelectionMode >> nodeEventHandlerClasses [

	^ self isMultipleSelection
		  ifTrue: [ { ToListNodeMultiSelectionClickEventHandler } ]
		  ifFalse: [ { ToListNodeSingleSelectionClickEventHandler } ]
]

{ #category : #accessing }
ToListSelectionMode >> onAddedNode: aNode [

	self nodeEventHandlerClasses do: [ :cls | aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListSelectionMode >> onClickEvent: anEvent onNode: aNode [

	self isDisabled ifTrue: [ ^ self ].
	self isMultipleSelection ifTrue: [
		self onMultiSelectionClickEvent: anEvent onNode: aNode.
		^ self ].
	self onSingleSelectionClickEvent: anEvent onNode: aNode
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onInstalledIn: anElement [
]

{ #category : #'event handling' }
ToListSelectionMode >> onMultiSelectionClickEvent: anEvent onNode: aNode [

	anEvent sourceEvent modifiers isShift ifTrue: [
		| curr |
		curr := self selecter currentIndex.
		self selecter selectIndex: curr to: aNode holder position.
		^ self ].
	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 self selectOnMouseDown ]) ifTrue: [
		self selectOrDeselectOnNode: aNode.
		^ self ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #accessing }
ToListSelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 self nodeEventHandlerClasses anySatisfy: [ :cls |
			 cls == handler class ] ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #'event handling' }
ToListSelectionMode >> onSingleSelectionClickEvent: anEvent onNode: aNode [

	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 self selectOnMouseDown ]) ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onUninstalledIn: anElement [

	selecter := nil.
	selectionModel onUninstalledIn: anElement.
	selectionModel := nil.
	operator onUninstalledIn: anElement.
	operator := nil
]

{ #category : #accessing }
ToListSelectionMode >> operator [

	^ operator
]

{ #category : #accessing }
ToListSelectionMode >> operator: aSelectionOperator [

	operator := aSelectionOperator
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
ToListSelectionMode >> primary [

	^ primary

]

{ #category : #accessing }
ToListSelectionMode >> primary: aBoolean [

	primary := aBoolean

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

{ #category : #accessing }
ToListSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToListSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #accessing }
ToListSelectionMode >> selecter [

	^ selecter ifNil: [ selecter := self newSelecter ]
]

{ #category : #accessing }
ToListSelectionMode >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionMode >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
