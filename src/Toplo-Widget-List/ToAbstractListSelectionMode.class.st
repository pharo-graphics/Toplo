Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'beneathOption',
		'overOption',
		'elementClass',
		'selecter',
		'primary',
		'requestFocusOnMouseDown',
		'preserveSelectionOnFocused',
		'selectOnMouseDown',
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

{ #category : #testing }
ToAbstractListSelectionMode >> allowRequestFocusOnMouseDown [

	| max |
	self isDisabled ifTrue: [ ^ self requestFocusOnMouseDown ].
	max := self maxSelectedIndexesForSelectionPreserving.
	self selectedIndexesCount > max ifTrue: [
		self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ self requestFocusOnMouseDown
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathOption [

	^ beneathOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathOption: aListSelectionOption [

	beneathOption := aListSelectionOption
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
	beneathOption := ToListSelectionOption grouped.
	overOption := ToListSelectionOption none.
	elementClass := self defaultElementClass.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true.
	selectOnMouseDown := false.
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

{ #category : #testing }
ToAbstractListSelectionMode >> maxSelectedIndexesForSelectionPreserving [

	^ 0
]

{ #category : #accessing }
ToAbstractListSelectionMode >> onAddedNode: aNode [

	aNode clickEventHandlerClasses do: [ :cls |
		aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToAbstractListSelectionMode >> onClickEvent: anEvent onNode: aNode [
	" implement the default/standard selection/deselection protocol"

	self subclassResponsibility 
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
ToAbstractListSelectionMode >> overOption [

	^ overOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overOption: aListSelectionOption [

	overOption := aListSelectionOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToAbstractListSelectionMode >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #accessing }
ToAbstractListSelectionMode >> primary: aBoolean [

	selecter ifNotNil: [ Error signal: 'The selecter kind can''t be changed' ].
	primary := aBoolean

]

{ #category : #accessing }
ToAbstractListSelectionMode >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToAbstractListSelectionMode >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectOnMouseDown [

	^ selectOnMouseDown
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectOnMouseDown: aBoolean [

	selectOnMouseDown := aBoolean
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
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]
