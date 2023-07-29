Trait {
	#name : #TToElementWithState,
	#instVars : [
		'currentState'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - state processing' }
TToElementWithState >> currentSkinState [

	^ currentState
]

{ #category : #'t - state processing' }
TToElementWithState >> currentSkinState: aState [

	currentState := aState
]
