Class {
	#name : #ToListAbstractSelectionMode,
	#superclass : #Object,
	#instVars : [
		'selectionModel',
		'selecter',
		'requestFocusOnMouseDown'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListAbstractSelectionMode >> allowNodeSelectionOnMouseDown [

	^ self requestFocusOnMouseDown 
]

{ #category : #testing }
ToListAbstractSelectionMode >> hasSelectionAt: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #initialization }
ToListAbstractSelectionMode >> initialize [ 

	super initialize.
	requestFocusOnMouseDown := true.

]

{ #category : #accessing }
ToListAbstractSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #'instance creation' }
ToListAbstractSelectionMode >> newSelecterIn: anElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToListAbstractSelectionMode >> nodeEventHandlerClasses [ 

	^ self subclassResponsibility 

]

{ #category : #accessing }
ToListAbstractSelectionMode >> onAddedNode: aNode [

	self nodeEventHandlerClasses do: [ :cls | aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListAbstractSelectionMode >> onClickEvent: anEvent onNode: aNode [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToListAbstractSelectionMode >> onInstalledIn: anElement [

	self selectionModel: anElement selectionModel.
	selecter := self newSelecterIn: anElement.
	selecter onInstalledIn: anElement
]

{ #category : #accessing }
ToListAbstractSelectionMode >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 self nodeEventHandlerClasses anySatisfy: [ :cls |
			 cls == handler class ] ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #'api - hooks' }
ToListAbstractSelectionMode >> onUninstalledIn: anElement [

	selecter onUninstalledIn: anElement.
	selecter := nil.
	self selectionModel: nil
]

{ #category : #accessing }
ToListAbstractSelectionMode >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToListAbstractSelectionMode >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean 
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #'accessing - operator' }
ToListAbstractSelectionMode >> selecter [

	^ selecter 
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
