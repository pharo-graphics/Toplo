Trait {
	#name : #TToSkinable,
	#category : #'Toplo-Theme-Core'
}

{ #category : #'t - skinable - initialization' }
TToSkinable >> updateSkin [

	self withSkin: self defaultSkin.
	self requestLayout
]
