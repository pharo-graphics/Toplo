Class {
	#name : #ToListSelectionWithNeighboringElementVariant,
	#superclass : #ToListSelectionWithElementVariant,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSelectionWithNeighboringElementVariant >> isGrouped [ 

	^ true
]

{ #category : #'private - selection updating' }
ToListSelectionWithNeighboringElementVariant >> newSelectionRepresentationArrayFrom: aListElement [ 

	^ (self
		   selectedNodeContainersFrom: aListElement) collect: [ :arr |
			  ToNeighboringSelection new
				  nodes: arr asArray;
				  yourself ]
]

{ #category : #'private - selection updating' }
ToListSelectionWithNeighboringElementVariant >> selectedNodeContainersFrom: aListElement [ 

	^ aListElement innerElement nodeGroupsSatisfying: [ :node |
			  | idx |
			  idx := node holder position.
			  (self selectionModel containsIndex: idx) and: [
				  self selectionModel isVisibleIndex: idx ] ]
]
