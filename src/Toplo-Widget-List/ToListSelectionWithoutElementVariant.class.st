Class {
	#name : #ToListSelectionWithoutElementVariant,
	#superclass : #ToListSelectionRepresentationVariant,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> checkRepresentationIn: aListElement withSelectionModel: aSelectionModel forceUpdate: aBoolean [

	super
		checkRepresentationIn: aListElement
		withSelectionModel: aSelectionModel
		forceUpdate: aBoolean.
	representationChanged ifFalse: [ ^ self ].
	self notifyNodesSelectedIn: aListElement
]

{ #category : #testing }
ToListSelectionWithoutElementVariant >> isEmbedded [ 

	^ true
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (self
		   selectedNodeContainersFrom: aListElement
		   withSelectionModel: aSelectionModel) collect: [ :container |
		  ToSelectionWithoutElement new node: container ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> selectedNodeContainersFrom: aListElement withSelectionModel: aSelectionModel [

	^ aListElement nodeContainersSelect: [ :container |
			  | idx |
			  idx := container holder position.
			  (aSelectionModel containsIndex: idx) and: [
				  aSelectionModel isVisibleIndex: idx ] ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> updateRepresentationIn: aListElement withSelectionModel: aSelectionModel [

	super
		updateRepresentationIn: aListElement
		withSelectionModel: aSelectionModel.
	self notifyNodesSelectedIn: aListElement
]
