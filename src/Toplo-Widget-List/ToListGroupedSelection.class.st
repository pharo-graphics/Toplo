Class {
	#name : #ToListGroupedSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListGroupedSelection >> currentSelectionGroupsFrom: aListElement [

	^ (aListElement innerContainer nodeGroupsSatisfying: [ :node |
		   selectionModel containsIndex: node holder position ]) collect: [ :arr |
		  ToNeighboringSelection new
			  nodes: arr ]
]

{ #category : #testing }
ToListGroupedSelection >> isGrouped [ 

	^ true
]
