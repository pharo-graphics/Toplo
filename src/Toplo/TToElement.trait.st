Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self ensureCanManageSkin
]

{ #category : #'t - toElement' }
TToElement >> knownMinWidth [

	^ 0.0
]
