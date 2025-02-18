Class {
	#name : #ToListSelectionWithSeparateElementOption,
	#superclass : #ToListSelectionWithElementOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListSelectionWithSeparateElementOption >> currentSelectionRepresentationsFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement innerElement nodesSelect: [ :node |
		   | idx |
		   idx := node holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :node |
		  ToSeparateSelection new node: node ]
]

{ #category : #testing }
ToListSelectionWithSeparateElementOption >> isSeparate [

	^ true
]
