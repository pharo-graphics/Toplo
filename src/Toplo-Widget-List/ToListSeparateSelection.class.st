Class {
	#name : #ToListSeparateSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListSeparateSelection >> currentSelectionGroupsFrom: aListElement [

	^ (aListElement innerContainer partlyVisibleNodesSelect: [ :node |
		   selectionMode isSelectableNode: node ]) collect: [ :node |
		  ToSeparateSelection new
			  option: self;
			  node: node ]
]

{ #category : #testing }
ToListSeparateSelection >> isSeparate [ 

	^ true
]
