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

	self innerConfiguration rowNumbers: true
]

{ #category : #'t - infinite accessing' }
TToListElementWithDecoration >> withoutRowNumbers [

	self innerConfiguration rowNumbers: false
]
