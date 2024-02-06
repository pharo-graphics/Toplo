Class {
	#name : #ToListAbstractSelectionManager,
	#superclass : #Object,
	#instVars : [
		'selectionModel',
		'selectionMode',
		'selecter',
		'requestFocusOnMouseDown'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToListAbstractSelectionManager >> defaultSelectionMode [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToListAbstractSelectionManager >> hasSelectionAt: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #testing }
ToListAbstractSelectionManager >> hasWholeSelection [

	^ self selectionModel isWholeSelectionModel
]

{ #category : #initialization }
ToListAbstractSelectionManager >> initialize [ 

	super initialize.
	requestFocusOnMouseDown := true.

]

{ #category : #accessing }
ToListAbstractSelectionManager >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToListAbstractSelectionManager >> nodeEventHandlerClasses [ 

	^ self subclassResponsibility 

]

{ #category : #accessing }
ToListAbstractSelectionManager >> onAddedNode: aNode [

	self nodeEventHandlerClasses do: [ :cls | aNode addEventHandler: cls new ]
]

{ #category : #'event handling' }
ToListAbstractSelectionManager >> onClickOnNode: aNode event: anEvent [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToListAbstractSelectionManager >> onInstalledIn: anElement [

	self selectionMode: self defaultSelectionMode.
	self selectionModel: anElement selectionModel.
	selecter := self selectionModel newSelecter on: anElement
]

{ #category : #accessing }
ToListAbstractSelectionManager >> onRemovedNode: aNode [

	(aNode eventDispatcher handlers select: [ :handler |
		 self nodeEventHandlerClasses anySatisfy: [ :cls |
			 cls == handler class ] ]) do: [ :handler |
		aNode removeEventHandler: handler ]
]

{ #category : #'api - hooks' }
ToListAbstractSelectionManager >> onUninstalledIn: anElement [

	selecter eventTarget: nil.
	selecter := nil.
	self selectionModel: nil.
	self selectionMode: nil
]

{ #category : #accessing }
ToListAbstractSelectionManager >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToListAbstractSelectionManager >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean 
]

{ #category : #accessing }
ToListAbstractSelectionManager >> selectedIndexes [

	^ self selectionModel indices
]

{ #category : #accessing }
ToListAbstractSelectionManager >> selectedIndexesCount [

	^ self selectionModel selectedItemCount
]

{ #category : #'accessing - operator' }
ToListAbstractSelectionManager >> selecter [

	^ selecter 
]

{ #category : #accessing }
ToListAbstractSelectionManager >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToListAbstractSelectionManager >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]

{ #category : #accessing }
ToListAbstractSelectionManager >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListAbstractSelectionManager >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
