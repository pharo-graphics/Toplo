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
ToListSelectionWithoutElementVariant >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement nodeContainersSelect: [ :container |
		   | idx |
		   idx := container holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :container |
		  ToSelectionWithoutElement new node: container ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithoutElementVariant >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	super
		updateSelectionIn: aListElement
		withSelectionModel: aSelectionModel.
	self notifyNodesSelectedIn: aListElement
]
