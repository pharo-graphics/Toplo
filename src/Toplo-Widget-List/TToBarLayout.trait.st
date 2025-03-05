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
TToBarLayout >> hasUniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - bar layout' }
TToBarLayout >> hasUniformNodeHeight: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeHeight := aBoolean
]

{ #category : #'t - bar layout' }
TToBarLayout >> hasUniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - bar layout' }
TToBarLayout >> hasUniformNodeWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeWidth := aBoolean
]

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
