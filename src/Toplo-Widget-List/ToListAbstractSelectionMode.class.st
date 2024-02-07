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

{ #category : #initialization }
ToListAbstractSelectionMode >> defaultSelectionCommandChecker [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToListAbstractSelectionMode >> hasSelectionAt: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #testing }
ToListAbstractSelectionMode >> hasWholeSelection [

	^ self selectionModel isWholeSelectionModel
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

{ #category : #accessing }
ToListAbstractSelectionMode >> nodeEventHandlerClasses [ 

	^ self subclassResponsibility 

]

{ #category : #accessing }
ToListAbstractSelectionMode >> onAddedNode: aNode [

	self nodeEventHandlerClasses do: [ :cls | aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListAbstractSelectionMode >> onClickOnNode: aNode event: anEvent [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToListAbstractSelectionMode >> onInstalledIn: anElement [

	self selectionModel: anElement selectionModel.
	selecter := ToSelectionModelSelecter new.
	selecter onInstalledIn: anElement.
	selecter checker: self defaultSelectionCommandChecker.

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