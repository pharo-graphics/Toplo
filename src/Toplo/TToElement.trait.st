Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> constraintsDo: aBlock [

	self sizeConstraintsDo: aBlock
]

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self ensureCanManageSkin
]
