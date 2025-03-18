Trait {
	#name : #TToBarLayout,
	#instVars : [
		'uniformNodeHeight',
		'uniformNodeWidth',
		'minNodeHeight',
		'minNodeWidth'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar layout' }
TToBarLayout >> minNodeHeight [

	^ minNodeHeight 
]

{ #category : #'t - bar layout' }
TToBarLayout >> minNodeHeight: aNumber [

	minNodeHeight := aNumber
]

{ #category : #'t - bar layout' }
TToBarLayout >> minNodeWidth [

	^ minNodeWidth 
]

{ #category : #'t - bar layout' }
TToBarLayout >> minNodeWidth: aNumber [

	minNodeWidth := aNumber
]

{ #category : #'t - bar layout' }
TToBarLayout >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - bar layout' }
TToBarLayout >> uniformNodeHeight: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeHeight := aBoolean
]

{ #category : #'t - bar layout' }
TToBarLayout >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - bar layout' }
TToBarLayout >> uniformNodeWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeWidth := aBoolean
]
