Trait {
	#name : #TToPropertyAnimation,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #'t - property animation - accessing' }
TToPropertyAnimation >> duration [

	^ self explicitRequirement 
]

{ #category : #'t - property animation - action handling' }
TToPropertyAnimation >> onFinishedDo: aBlock [

	self explicitRequirement 
]

{ #category : #'t - property animation - accessing' }
TToPropertyAnimation >> property [

	^ self explicitRequirement 
]

{ #category : #'t - property animation - running' }
TToPropertyAnimation >> stop [

	self explicitRequirement 
]

{ #category : #'t - property animation - writing' }
TToPropertyAnimation >> write: anObject to: anElement [

	self explicitRequirement 
]
