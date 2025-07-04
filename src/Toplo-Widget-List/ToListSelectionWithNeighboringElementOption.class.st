Class {
	#name : #ToListSelectionWithNeighboringElementOption,
	#superclass : #ToListSelectionWithElementOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSelectionWithNeighboringElementOption >> isGrouped [ 

	^ true
]

{ #category : #'nodes collecting' }
ToListSelectionWithNeighboringElementOption >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement innerElement nodeGroupsSatisfying: [ :node |
		   | idx |
		   idx := node holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :arr |
		  ToNeighboringSelection new
			  nodes: arr;
			  createSelectionElementIn: aListElement option: selectionOption;
			  yourself ]
]
