Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self addEventHandler: ToSkinStateGenerator new.
	self addEventHandler: ToElementInitializeEventHandler new
]
