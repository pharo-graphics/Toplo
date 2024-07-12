Class {
	#name : #ToListSeparateSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListSeparateSelection >> currentSelectionGroupsFrom: aListElement [

	^ (aListElement innerContainer partlyVisibleNodesSelect: [ :node |
		   selectionModel containsIndex: node holder position ]) collect: [ :node |
		  ToSeparateSelection new
			  node: node ]
]

{ #category : #testing }
ToListSeparateSelection >> isSeparate [ 

	^ true
]
