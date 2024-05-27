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
ToListSeparateSelection >> nextPutNodeGroupsFrom: aListElement selectionModel: aSelectionModel in: aStream [

	aStream nextPutAll:
		((aListElement innerContainer partlyVisibleNodesSelect: [ :node | 
			  (aSelectionModel containsIndex: node holder position) and: [
				  node height > 0 ] ]) collect: [ :node | Array with: node ])
]
