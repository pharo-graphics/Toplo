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
ToListSelectionWithNeighboringElementVariant >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement innerElement nodeGroupsSatisfying: [ :node |
		   | idx |
		   idx := node holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :arr |
		  ToNeighboringSelection new
			  nodes: arr asArray;
			  yourself ]
]
