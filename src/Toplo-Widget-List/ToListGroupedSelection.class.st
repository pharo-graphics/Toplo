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
ToListGroupedSelection >> nextPutSelectionGroupsFrom: aListElement in: aStream [

	aStream nextPutAll:
		((aListElement innerContainer nodeGroupsSatisfying: [ :n |
			  (selectionMode selectionModel containsIndex: n holder position) and: [
				  n height > 0 ] ]) collect: [ :arr |
			 ToNeighboringSelection new
				 option: self;
				 nodes: arr ])
]
