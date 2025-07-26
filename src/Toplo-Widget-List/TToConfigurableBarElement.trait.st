Trait {
	#name : #TToConfigurableBarElement,
	#instVars : [
		'exactNodeWidth',
		'exactNodeHeight',
		'uniformNodeWidth',
		'uniformNodeHeight',
		'autoDistribute',
		'isFlowable',
		'isScrollable'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> autoDistribute [

	^ autoDistribute ifNil: [ autoDistribute := false ] 
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> autoDistribute: aBoolean [

	autoDistribute = aBoolean ifTrue: [ ^ self ].
	autoDistribute := aBoolean.
	self requestConfiguration
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> exactNodeHeight [

	^ exactNodeHeight
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> exactNodeHeight: aNumberOrNil [

	exactNodeHeight = aNumberOrNil ifTrue:[ ^ self ].
	exactNodeHeight := aNumberOrNil.
	self requestConfiguration.
	self requestLayout
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> exactNodeWidth [

	^ exactNodeWidth
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> exactNodeWidth: aNumberOrNil [

	exactNodeWidth = aNumberOrNil ifTrue:[ ^ self ].
	exactNodeWidth := aNumberOrNil.
	self requestConfiguration.
	self requestLayout
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> isFlowable [

	^ isFlowable ifNil: [ isFlowable := true ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> isFlowable: aBoolean [

	isFlowable = aBoolean ifTrue: [ ^ self ].
	isFlowable := aBoolean.
	self requestConfiguration
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> isScrollable [

	^ isScrollable ifNil: [ isScrollable := false ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> isScrollable: aBoolean [

	isScrollable = aBoolean ifTrue: [ ^ self ].
	isScrollable := aBoolean.
	self requestLayout.
	self requestConfiguration
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> maxMeasuredNodeSize [

	^ self innerElement maxMeasuredNodeSize
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> uniformNodeHeight: aBoolean [

	uniformNodeHeight = aBoolean ifTrue: [ ^ self ].
	uniformNodeHeight := aBoolean.
	self requestConfiguration.
	self requestLayout
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - configurable bar element' }
TToConfigurableBarElement >> uniformNodeWidth: aBoolean [

	uniformNodeWidth = aBoolean ifTrue: [ ^ self ].
	uniformNodeWidth := aBoolean.
	self requestConfiguration.
	self requestLayout
]
