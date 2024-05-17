Class {
	#name : #ToListGroupedSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListGroupedSelection >> nextPutNodeGroupsFrom: aListElement selectionModel: aSelectionModel in: aStream [

	aStream nextPutAll:
		(aListElement nodeContainer nodeGroupsSatisfying: [ :n |
			 (aSelectionModel containsIndex: n holder position) and: [ n height > 0 ] ])
]
