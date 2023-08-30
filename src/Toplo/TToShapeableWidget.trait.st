Trait {
	#name : #TToShapeableWidget,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidget >> shaping: aShaping [

	self skinDo: [ :s | s changeShapingWith: aShaping in: self ]
]

{ #category : #'t - shapeable  - accessing' }
TToShapeableWidget >> sizing: aSizing [

	self skinDo: [ :s | s changeSizingWith: aSizing in: self ]
]
