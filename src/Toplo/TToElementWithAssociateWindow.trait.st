Trait {
	#name : #TToElementWithAssociateWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - element with associate window - accessing' }
TToElementWithAssociateWindow >> associateWindow [

	^ self explicitRequirement
]

{ #category : #'t - element with associate window - accessing' }
TToElementWithAssociateWindow >> associateWindow: aWindowElement [

	^ self explicitRequirement
]
