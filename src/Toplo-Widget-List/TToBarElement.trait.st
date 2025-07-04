Trait {
	#name : #TToBarElement,
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

{ #category : #'t - bar element' }
TToBarElement >> autoDistribute [

	^ autoDistribute ifNil: [ autoDistribute := false ] 
]

{ #category : #'t - bar element' }
TToBarElement >> autoDistribute: aBoolean [

	autoDistribute = aBoolean ifTrue: [ ^ self ].
	autoDistribute := aBoolean.
	" notify dataSource changed to renew all nodes "
	self notifyDataSourceChanged.
	self requestNewConfiguration
]

{ #category : #'t - bar element' }
TToBarElement >> checkFullyVisibleNodes [ 

	self innerElement checkFullyVisibleNodes 
]

{ #category : #'t - bar element' }
TToBarElement >> defaultInnerElement [

	^ ToInnerBarElement onBarElement: self
]

{ #category : #accessing }
TToBarElement >> exactNodeHeight [

	^ exactNodeHeight
]

{ #category : #accessing }
TToBarElement >> exactNodeHeight: aNumberOrNil [

	exactNodeHeight = aNumberOrNil ifTrue:[ ^ self ].
	exactNodeHeight := aNumberOrNil.
	self requestNewConfiguration.
	self notifyDataSourceChanged.
	self requestLayout
]

{ #category : #accessing }
TToBarElement >> exactNodeWidth [

	^ exactNodeWidth
]

{ #category : #accessing }
TToBarElement >> exactNodeWidth: aNumberOrNil [

	exactNodeWidth = aNumberOrNil ifTrue:[ ^ self ].
	exactNodeWidth := aNumberOrNil.
	self requestNewConfiguration.
	self notifyDataSourceChanged.
	self requestLayout
]

{ #category : #'t - bar element' }
TToBarElement >> fakeNode [

	^ self innerElement fakeNode
]

{ #category : #'t - bar element' }
TToBarElement >> installFakeNode [

	self innerElement installFakeNode
]

{ #category : #'t - bar element' }
TToBarElement >> isFlowable [

	^ isFlowable ifNil: [ isFlowable := true ]
]

{ #category : #'t - bar element' }
TToBarElement >> isFlowable: aBoolean [

	isFlowable = aBoolean ifTrue: [ ^ self ].
	isFlowable := aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - bar element' }
TToBarElement >> isScrollable [

	^ isScrollable ifNil: [ isScrollable := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> isScrollable: aBoolean [

	isScrollable = aBoolean ifTrue: [ ^ self ].
	isScrollable := aBoolean.
	self requestLayout.
	self requestNewConfiguration
]

{ #category : #'t - bar element' }
TToBarElement >> isScrolling [

	self
		deprecated: 'Use #isScrollable'
		transformWith: '`@r isScrolling' -> '`@r isScrollable'.
	^ self isScrollable
]

{ #category : #'t - bar element' }
TToBarElement >> isScrolling: aBoolean [

	self
		deprecated: 'Use #isScrollable:'
		transformWith: '`@r isScrolling: `@a' -> '`@r isScrollable: `@a'.
	self isScrollable: aBoolean
]

{ #category : #'t - bar element' }
TToBarElement >> isWrapping [

	self
		deprecated: 'Use #isFlowable'
		transformWith: '`@r isWrapping' -> '`@r isFlowable'.
	^ self isFlowable
]

{ #category : #'t - bar element' }
TToBarElement >> isWrapping: aBoolean [

	self
		deprecated: 'Use #isFlowable:'
		transformWith: '`@r isWrapping: `@a' -> '`@r isFlowable: `@a'.
	self isFlowable: aBoolean
]

{ #category : #'t - bar element' }
TToBarElement >> maxMeasuredNodeSize [

	^ self innerElement maxMeasuredNodeSize
]

{ #category : #'t - bar element' }
TToBarElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [

	
]

{ #category : #'t - bar element' }
TToBarElement >> reinstallFakeNode [

	self uninstallFakeNode.
	self installFakeNode
]

{ #category : #'t - bar element' }
TToBarElement >> sample [

	^ self nodeManager fakeDataItem
]

{ #category : #'t - bar element' }
TToBarElement >> sample: aDataItem [

	self nodeManager fakeDataItem: aDataItem.
	self reinstallFakeNode.
	self requestLayout
	
]

{ #category : #'t - bar element' }
TToBarElement >> uniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> uniformNodeHeight: aBoolean [

	uniformNodeHeight = aBoolean ifTrue: [ ^ self ].
	uniformNodeHeight := aBoolean.
	self requestNewConfiguration.
	self notifyDataSourceChanged.
	self requestLayout
]

{ #category : #'t - bar element' }
TToBarElement >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> uniformNodeWidth: aBoolean [

	uniformNodeWidth = aBoolean ifTrue: [ ^ self ].
	uniformNodeWidth := aBoolean.
	self requestNewConfiguration.
	self notifyDataSourceChanged.
	self requestLayout
]

{ #category : #'t - bar element' }
TToBarElement >> uninstallFakeNode [

	self innerElement uninstallFakeNode
]
