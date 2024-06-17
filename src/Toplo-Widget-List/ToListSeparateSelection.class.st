Class {
	#name : #ToListSeparateSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSeparateSelection >> isSeparate [ 

	^ true
]

{ #category : #'nodes collecting' }
ToListSeparateSelection >> nextPutSelectionGroupsFrom: aListElement in: aStream [

	aStream nextPutAll:
		((aListElement innerContainer partlyVisibleNodesSelect: [ :node |
			  (selectionMode selectionModel containsIndex: node holder position) and: [
				  node height > 0 ] ]) collect: [ :node |
			 ToSeparateSelection new
				 selectionOption: self;
				 node: node ])
]
