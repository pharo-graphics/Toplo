Trait {
	#name : #TToFiniteListLayout,
	#instVars : [
		'uniformNodeHeight',
		'uniformNodeWidth',
		'minNodeHeight',
		'minNodeWidth'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'t - bar layout' }
TToFiniteListLayout >> minNodeHeight [

	^ minNodeHeight 
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> minNodeHeight: aNumber [

	minNodeHeight := aNumber
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> minNodeWidth [

	^ minNodeWidth 
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> minNodeWidth: aNumber [

	minNodeWidth := aNumber
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> uniformNodeHeight: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeHeight := aBoolean
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - bar layout' }
TToFiniteListLayout >> uniformNodeWidth: aBoolean [
	" an option that set the same width to all elements of a line "
	uniformNodeWidth := aBoolean
]
