Class {
	#name : #ToListAbstractSelectionMode,
	#superclass : #Object,
	#instVars : [
		'selectionModel',
		'selecter',
		'requestFocusOnMouseDown',
		'selectOnMouseDown'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListAbstractSelectionMode >> allowRequestFocusOnMouseDown [

	^ self requestFocusOnMouseDown 
]

{ #category : #initialization }
ToListAbstractSelectionMode >> initialize [ 

	super initialize.
	requestFocusOnMouseDown := true.
	selectOnMouseDown := false

]

{ #category : #testing }
ToListAbstractSelectionMode >> isMultipleSelection [

	^ self subclassResponsibility 
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
ToListAbstractSelectionMode >> selectOnMouseDown [

	^ selectOnMouseDown
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectOnMouseDown: aBoolean [

	selectOnMouseDown := aBoolean
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToListAbstractSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #accessing }
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

{ #category : #shortcuts }
ToListAbstractSelectionMode >> shortcutsIn: anElement [

	^ {  }
]
