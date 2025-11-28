Class {
	#name : #ToListSelectionWithoutElementOption,
	#superclass : #ToListSelectionRepresentationOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSelectionWithoutElementOption >> isEmbedded [ 

	^ true
]

{ #category : #'nodes collecting' }
ToListSelectionWithoutElementOption >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement nodeContainersSelect: [ :container |
		   | idx |
		   idx := container holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :container |
		  ToSelectionWithoutElement new node: container ]
]

{ #category : #'nodes collecting' }
ToListSelectionWithoutElementOption >> updateSelectionIn: aListElement withSelectionModel: aSelectionModel [

	(super
		 updateSelectionIn: aListElement
		 withSelectionModel: aSelectionModel) ifFalse: [ ^ false ].
	
	self notifyNodesSelectedIn: aListElement.
	^ true

]
