Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self ensureHaveSkinManager.
	self addEventHandler: ToSkinStateGenerator new.
	self addEventHandler: ToElementInitializeEventHandler new
]
