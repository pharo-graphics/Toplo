Trait {
	#name : #TToConfigurableFiniteListElement,
	#instVars : [
		'uniformNodeWidth',
		'uniformNodeHeight',
		'autoDistribute',
		'isFlowable',
		'isScrollable'
	],
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> autoDistribute [

	^ autoDistribute ifNil: [ autoDistribute := false ] 
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> autoDistribute: aBoolean [

	autoDistribute = aBoolean ifTrue: [ ^ self ].
	autoDistribute := aBoolean.
	self requestConfiguration
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> isFlowable [

	^ isFlowable ifNil: [ isFlowable := true ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> isFlowable: aBoolean [

	isFlowable = aBoolean ifTrue: [ ^ self ].
	isFlowable := aBoolean.
	self requestConfiguration
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> isScrollable [

	^ isScrollable ifNil: [ isScrollable := false ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> isScrollable: aBoolean [

	isScrollable = aBoolean ifTrue: [ ^ self ].
	isScrollable := aBoolean.
	self requestLayout.
	self requestConfiguration
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> uniformNodeHeight: aBoolean [

	uniformNodeHeight = aBoolean ifTrue: [ ^ self ].
	uniformNodeHeight := aBoolean.
	self requestConfiguration.
	self requestLayout
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableFiniteListElement >> uniformNodeWidth: aBoolean [

	uniformNodeWidth = aBoolean ifTrue: [ ^ self ].
	uniformNodeWidth := aBoolean.
	self requestConfiguration.
	self requestLayout
]
