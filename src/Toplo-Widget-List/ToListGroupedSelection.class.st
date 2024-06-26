Class {
	#name : #ToListGroupedSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListGroupedSelection >> currentSelectionGroupsFrom: aListElement [

	^ (aListElement innerContainer nodeGroupsSatisfying: [ :n |
		   (selectionMode selectionModel containsIndex: n holder position)
			   and: [ n holder isHidden not ] ]) collect: [ :arr |
		  ToNeighboringSelection new
			  option: self;
			  nodes: arr ]
]

{ #category : #testing }
ToListGroupedSelection >> isGrouped [ 

	^ true
]
