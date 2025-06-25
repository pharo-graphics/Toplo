Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> asFloatElement [

	| holder |
	holder := ToFloatHolder new.
	holder addChild: self.
	^ holder
]

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self ensureCanManageSkin
]
