Class {
	#name : #ToListNoneSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListNoneSelection >> isNone [ 

	^ true
]

{ #category : #'nodes collecting' }
ToListNoneSelection >> nextPutSelectionGroupsFrom: aListElement in: aStream [
]
