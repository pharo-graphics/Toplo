Trait {
	#name : #TToListElementWithDecoration,
	#category : #'Toplo-Widget-List-Core-ListElement'
}

{ #category : #'t - infinite accessing' }
TToListElementWithDecoration >> withDecoration: aDecorationClass [

	self next withDecoration: aDecorationClass
]

{ #category : #'t - infinite accessing' }
TToListElementWithDecoration >> withRowNumbers [

	self next withRowNumbers.
	self updateAllSelections
]
