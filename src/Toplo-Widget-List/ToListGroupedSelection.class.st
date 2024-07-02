Class {
	#name : #ToListGroupedSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListGroupedSelection >> currentSelectionGroupsFrom: aListElement [

	^ (aListElement innerContainer nodeGroupsSatisfying: [ :node |
		   selectionMode isSelectableNode: node ]) collect: [ :arr |
		  ToNeighboringSelection new
			  option: self;
			  nodes: arr ]
]

{ #category : #testing }
ToListGroupedSelection >> isGrouped [ 

	^ true
]
