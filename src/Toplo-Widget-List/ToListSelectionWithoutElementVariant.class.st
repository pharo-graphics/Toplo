Class {
	#name : #ToListSelectionWithoutElementVariant,
	#superclass : #ToListSelectionRepresentationVariant,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSelectionWithoutElementVariant >> isEmbedded [ 

	^ true
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> newSelectionRepresentationArrayFrom: aListElement [

	^ (self selectedNodeContainersFrom: aListElement) collect: [
		  :container | ToSelectionWithoutElement new node: container ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> selectedNodeContainersFrom: aListElement [

	^ aListElement nodeContainersSelect: [ :container |
			  | idx |
			  idx := container holder position.
			  (self selectionModel containsIndex: idx) and: [
				  self selectionModel isVisibleIndex: idx ] ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> updateRepresentationIn: aListElement [

	super updateRepresentationIn: aListElement.
	self notifyNodesSelectedIn: aListElement
]
