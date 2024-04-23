Class {
	#name : #ToListSeparateSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'nodes collecting' }
ToListSeparateSelection >> nextPutNodeGroupsFrom: aListElement selectionModel: aSelectionModel in: aStream [

	aStream nextPutAll:
		((aListElement infinite children select: [ :node |
			  (aSelectionModel containsIndex: node holder position) and: [
				  node height > 0 ] ]) collect: [ :node | Array with: node ])
]
