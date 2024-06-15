Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'beneathOption',
		'overOption',
		'elementClass',
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
ToAbstractListSelectionMode >> overOption [

	^ overOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overOption: aListSelectionOption [

	overOption := aListSelectionOption
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

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]
