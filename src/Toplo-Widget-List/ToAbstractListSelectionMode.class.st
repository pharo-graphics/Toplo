Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'beneathOption',
		'overOption',
		'selecter',
		'primary',
		'enabled'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToAbstractListSelectionMode class >> new [

	^ self shouldNotImplement
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode class >> primary [

	| primary |
	primary := self basicNew.
	primary primary: true.
	primary initialize.
	^ primary
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode class >> secondary [

	| secondary |
	secondary := self basicNew.
	secondary primary: false.
	secondary initialize.
	^ secondary
]

{ #category : #accessing }
ToAbstractListSelectionMode >> benathElementClass: aSelectionElementClass [

	beneathOption elementClass: aSelectionElementClass
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathOption [

	^ beneathOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathOption: aListSelectionOption [

	beneathOption := aListSelectionOption.
	beneathOption selectionMode: self.
]

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultElementClass [

	^ primary
		  ifTrue: [ ToListPrimarySelectionElement ]
		  ifFalse: [ ToListSecondarySelectionElement ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> disable [

	self enabled: false
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

{ #category : #private }
ToAbstractListSelectionMode >> forgetPreviousSelectionState [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder forgetPreviousState.
	overOption groupHolder forgetPreviousState.
]

{ #category : #configuring }
ToAbstractListSelectionMode >> groupedBeneathSelection [

	beneathOption := ToListSelectionOption groupedForMode: self
]

{ #category : #configuring }
ToAbstractListSelectionMode >> groupedOverSelection [

	overOption := ToListSelectionOption groupedForMode: self
]

{ #category : #initialization }
ToAbstractListSelectionMode >> initialize [

	super initialize.
	beneathOption := ToListSelectionOption groupedForMode: self.
	overOption := ToListSelectionOption noneForMode: self.
	enabled := true
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
ToAbstractListSelectionMode >> isPrimarySelectionMode [

	^ primary
]

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #configuring }
ToAbstractListSelectionMode >> noneBeneathSelection [

	beneathOption := ToListSelectionOption noneForMode: self
]

{ #category : #configuring }
ToAbstractListSelectionMode >> noneOverSelection [

	overOption := ToListSelectionOption noneForMode: self
]

{ #category : #accessing }
ToAbstractListSelectionMode >> onAddedNode: aNode [

	aNode clickEventHandlerClasses do: [ :cls |
		aNode addEventHandler: cls new ]
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: anElement [

	selecter := self isPrimarySelectionMode
		            ifTrue: [
			            ToPrimarySelecter
				            selectionModel: anElement newPrimarySelectionModel
				            operator: ToStandardSelectionModelOperator primary ]
		            ifFalse: [
			            ToSecondarySelecter
				            selectionModel: anElement newSecondarySelectionModel
				            operator: ToStandardSelectionModelOperator secondary ].

	selecter
		onInstalledIn: anElement;
		enabled: self enabled
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

{ #category : #accessing }
ToAbstractListSelectionMode >> overOption: aListSelectionOption [

	overOption := aListSelectionOption.
	beneathOption selectionMode: self.
]

{ #category : #accessing }
ToAbstractListSelectionMode >> primary: aBoolean [

	selecter ifNotNil: [ Error signal: 'The selecter kind can''t be changed' ].
	primary := aBoolean

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

{ #category : #private }
ToAbstractListSelectionMode >> selectionElementsFrom: aListElement [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder checkSelectionFrom: aListElement.
	overOption groupHolder checkSelectionFrom: aListElement.

	^ Array streamContents: [ :stream |
		  stream nextPutAll:
			  (beneathOption groupHolder collectSelectionElementsFrom:
				   aListElement).
		  stream nextPutAll:
			  (overOption groupHolder collectSelectionElementsFrom:
				   aListElement) ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #configuring }
ToAbstractListSelectionMode >> separateBeneathSelection [

	beneathOption := ToListSelectionOption separateForMode: self
]

{ #category : #configuring }
ToAbstractListSelectionMode >> separateOverSelection [

	overOption := ToListSelectionOption separateForMode: self
]

{ #category : #private }
ToAbstractListSelectionMode >> updateSelectionFrom: aListElement [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder updateSelectionFrom: aListElement.
	overOption groupHolder updateSelectionFrom: aListElement
]
