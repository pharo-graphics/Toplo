Trait {
	#name : #TToElementWithAssociateWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
TToElementWithAssociateWindow >> associateWindow [

	^ self explicitRequirement
]

{ #category : #accessing }
TToElementWithAssociateWindow >> associateWindow: aWindowElement [

	^ self explicitRequirement
]
