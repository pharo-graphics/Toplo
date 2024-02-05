Class {
	#name : #ToListSelectionManager,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'mode',
		'selectionModel',
		'preserveSelectionOnFocused',
		'requestFocusOnMouseDown'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListSelectionManager >> hasSelectionAt: anIndex [

	^ self selectionModel containsIndex: anIndex
]

{ #category : #initialization }
ToListSelectionManager >> initialize [ 

	super initialize.
	requestFocusOnMouseDown := true.
	preserveSelectionOnFocused := true
]

{ #category : #accessing }
ToListSelectionManager >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionManager >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToListSelectionManager >> mode [

	^ mode
]

{ #category : #accessing }
ToListSelectionManager >> mode: aSelectionMode [

	mode := aSelectionMode
]

{ #category : #accessing }
ToListSelectionManager >> onAddedNode: aToNode [

	self flag: 'to do'
]

{ #category : #accessing }
ToListSelectionManager >> onRemovedNode: aToNode [

	self flag: 'to do'
]

{ #category : #accessing }
ToListSelectionManager >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListSelectionManager >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #accessing }
ToListSelectionManager >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown
]

{ #category : #accessing }
ToListSelectionManager >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean
]

{ #category : #'accessing - operator' }
ToListSelectionManager >> selecter [ 

	^  self selectionModel newSelecter on: self listElement.

]

{ #category : #accessing }
ToListSelectionManager >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionManager >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
