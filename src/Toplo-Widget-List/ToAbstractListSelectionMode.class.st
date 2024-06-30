Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listEventHandlers',
		'selecter',
		'enabled',
		'elementClass',
		'beneathOption',
		'overOption',
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToAbstractListSelectionMode >> beMultipleSelection [

	self multiple: true
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beSingleSelection [

	self multiple: false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathOption [

	^ beneathOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> disable [

	self enabled: false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> elementClass [

	^ elementClass 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> elementClass: aSelectionElementClass [

	elementClass := aSelectionElementClass
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enable [

	self enabled: true
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enabled [

	^ enabled
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enabled: aBoolean [
 
	enabled = aBoolean ifTrue: [ ^ self ].
	enabled := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter enabled: aBoolean
]

{ #category : #initialization }
ToAbstractListSelectionMode >> initialize [

	super initialize.
	listEventHandlers := #().
	enabled := true.
	multiple := true
]

{ #category : #testing }
ToAbstractListSelectionMode >> isDisabled [

	^ self enabled not
]

{ #category : #testing }
ToAbstractListSelectionMode >> isEnabled [

	^ self enabled
]

{ #category : #testing }
ToAbstractListSelectionMode >> isMultipleSelection [

	^ multiple
]

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> listEventHandlers: anEventHandlerArray [

	listEventHandlers := anEventHandlerArray
]

{ #category : #accessing }
ToAbstractListSelectionMode >> multiple [

	^ multiple
]

{ #category : #accessing }
ToAbstractListSelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #configuring }
ToAbstractListSelectionMode >> noneBeneathSelection [

	beneathOption := (ToListSelectionOption noneForMode: self)
		                 selectionContainer:
			                 beneathOption selectionContainer;
		                 yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> noneOverSelection [

	overOption := (ToListSelectionOption noneForMode: self)
		                 selectionContainer:
			                 overOption selectionContainer;
		                 yourself
]

{ #category : #accessing }
ToAbstractListSelectionMode >> onAddedNode: aNode [

	aNode clickEventHandlerClasses do: [ :cls |
		aNode addEventHandler: cls new ]
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: anElement [

	beneathOption := (ToListSelectionOption groupedForMode: self)
		                 selectionContainer: anElement beneathContainer;
		                 yourself.
	overOption := (ToListSelectionOption noneForMode: self)
		              selectionContainer: anElement overContainer;
		              yourself.
	selecter
		onInstalledIn: anElement;
		enabled: self enabled;
		multiple: multiple.
	listEventHandlers do: [ :h | anElement addEventHandler: h ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 aNode clickEventHandlerClasses anySatisfy: [ :cls |
			 handler class = cls ] ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: anElement [

	listEventHandlers do: [ :h | anElement removeEventHandler: h ].
	selecter onUninstalledIn: anElement.
	selecter := nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overElementClass: aSelectionElementClass [

	overOption elementClass: aSelectionElementClass
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overOption [

	^ overOption
]

{ #category : #private }
ToAbstractListSelectionMode >> refreshSelectionIn: aListElement [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder refreshSelectionIn: aListElement.
	overOption groupHolder refreshSelectionIn: aListElement.
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selecter [

	^ selecter 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selecter: aSelecter [

	selecter := aSelecter
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #configuring }
ToAbstractListSelectionMode >> separateBeneathSelection [

	
	beneathOption := (ToListSelectionOption separateForMode: self)
		              selectionContainer: beneathOption selectionContainer;
		              yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> separateOverSelection [

	overOption := (ToListSelectionOption separateForMode: self)
		              selectionContainer: overOption selectionContainer;
		              yourself
]

{ #category : #private }
ToAbstractListSelectionMode >> updateSelectionIn: aListElement [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder updateSelectionIn: aListElement.
	overOption groupHolder updateSelectionIn: aListElement
]
