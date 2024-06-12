Trait {
	#name : #TToListElementWithDecoration,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - infinite accessing' }
TToListElementWithDecoration >> withDecoration: aDecorationClass [

	self next withDecoration: aDecorationClass
]

{ #category : #'t - infinite accessing' }
TToListElementWithDecoration >> withRowNumbers [ 

	self next withRowNumbers.
	self notifyPrimarySelectionDirty.
	self requestLayout
]
