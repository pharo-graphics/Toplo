Class {
	#name : #ToListGroupedSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListGroupedSelection >> isGrouped [ 

	^ true
]

{ #category : #'nodes collecting' }
ToListGroupedSelection >> nextPutNodeGroupsFrom: aListElement selectionModel: aSelectionModel in: aStream [

	aStream nextPutAll:
		(aListElement innerContainer nodeGroupsSatisfying: [ :n |
			 (aSelectionModel containsIndex: n holder position) and: [ n height > 0 ] ])
]
