Class {
	#name : #ToListNoneSelection,
	#superclass : #ToListSelectionOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'nodes collecting' }
ToListNoneSelection >> currentSelectionGroupsFrom: aListElement [

	^ #(  )
]

{ #category : #testing }
ToListNoneSelection >> isNone [ 

	^ true
]

{ #category : #accessing }
ToListNoneSelection >> selectionElements [

	^ #(  )
]
