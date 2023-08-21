Trait {
	#name : #TToDataToElementConverter,
	#category : #'Toplo-Core'
}

{ #category : #'t - data to element converter - converting' }
TToDataToElementConverter >> asToDataToElementConverter [

	^ self
]

{ #category : #'t - data to element converter - evaluating' }
TToDataToElementConverter >> cull: aData cull: anObject [

	" A conerter creates an element from a data and another object "

	^ self explicitRequirement
]
