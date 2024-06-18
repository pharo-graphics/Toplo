Trait {
	#name : #TToProgress,
	#instVars : [
		'progressBar',
		'remainingBar',
		'valueInPercentage'
	],
	#category : #'Toplo-Widget-ProgressBar'
}

{ #category : #'t - accessing' }
TToProgress >> isInfinite: aBoolean [
]

{ #category : #'t - accessing' }
TToProgress >> progressBar [

	^ progressBar
]

{ #category : #'t - accessing' }
TToProgress >> progressBar: anObject [

	progressBar := anObject
]

{ #category : #'t - accessing' }
TToProgress >> remainingBar [

	^ remainingBar
]

{ #category : #'t - accessing' }
TToProgress >> remainingBar: anObject [

	remainingBar := anObject
]

{ #category : #'t - resizeable' }
TToProgress >> resizeProgressBar [

	^ self explicitRequirement 
]

{ #category : #'t - accessing' }
TToProgress >> valueInPercentage [

	^ valueInPercentage
]

{ #category : #'t - accessing' }
TToProgress >> valueInPercentage: aFloat [

	valueInPercentage := aFloat.
	self resizeProgressBar
]
