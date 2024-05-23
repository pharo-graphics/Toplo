Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionOption class >> grouped [ 

	^ ToListGroupedSelection new
]

{ #category : #'instance creation' }
ToListSelectionOption class >> none [ 

	^ ToListNoneSelection new
]

{ #category : #'instance creation' }
ToListSelectionOption class >> separate [

	^ ToListSeparateSelection new
]

{ #category : #testing }
ToListSelectionOption >> isGrouped [

	^ false
]

{ #category : #testing }
ToListSelectionOption >> isNone [

	^ false
]

{ #category : #testing }
ToListSelectionOption >> isSeparate [

	^ false
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> nextPutNodeGroupsFrom: aListElement selectionModel: aSelectionModel in: aStream [

	self subclassResponsibility 
]
