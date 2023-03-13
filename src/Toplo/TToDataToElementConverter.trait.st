Trait {
	#name : #TToDataToElementConverter,
	#category : #'Toplo-Core'
}

{ #category : #'t - converting' }
TToDataToElementConverter >> asToDataToElementConverter [

	^ self
]

{ #category : #evaluating }
TToDataToElementConverter >> cull: aData cull: anObject [

	" A conerter creates an element from a data and another object "

	^ self explicitRequirement
]
