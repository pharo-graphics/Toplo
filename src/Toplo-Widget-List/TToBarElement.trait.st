Trait {
	#name : #TToBarElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'uniformNodeWidth',
		'uniformNodeHeight'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - bar element' }
TToBarElement >> autoDistribute [

	^ nodeAutoDistribution ifNil: [ nodeAutoDistribution := false ] 
]

{ #category : #'t - bar element' }
TToBarElement >> autoDistribute: aBoolean [

	nodeAutoDistribution = aBoolean ifTrue: [ ^ self ].
	nodeAutoDistribution := aBoolean.
	" notify dataSource changed to renew all nodes "
	self notifyDataSourceChanged.
	self requestNewConfigurationPass 
]

{ #category : #'t - bar element' }
TToBarElement >> checkFullyVisibleNodes [ 

	self innerElement checkFullyVisibleNodes 
]

{ #category : #'t - bar element' }
TToBarElement >> defaultInnerElement [

	^ ToInnerBarElement onBarElement: self
]

{ #category : #'t - bar element' }
TToBarElement >> fakeNode [

	^ self innerElement fakeNode
]

{ #category : #'t - bar element' }
TToBarElement >> hasUniformNodeHeight [

	^ uniformNodeHeight ifNil: [ uniformNodeHeight := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> hasUniformNodeHeight: aBoolean [

	uniformNodeHeight = aBoolean ifTrue: [ ^ self ].
	uniformNodeHeight := aBoolean.
	self requestNewConfigurationPass.
	self notifyDataSourceChanged

]

{ #category : #'t - bar element' }
TToBarElement >> hasUniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> hasUniformNodeWidth: aBoolean [

	uniformNodeWidth = aBoolean ifTrue: [ ^ self ].
	uniformNodeWidth := aBoolean.
	self requestNewConfigurationPass.
	self notifyDataSourceChanged

]

{ #category : #'t - bar element' }
TToBarElement >> installFakeNode [

	self innerElement installFakeNode
]

{ #category : #'t - bar element' }
TToBarElement >> isScrolling [

	^ nodeScrolling ifNil: [ nodeScrolling := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> isScrolling: aBoolean [

	nodeScrolling = aBoolean ifTrue: [ ^ self ].
	nodeScrolling := aBoolean.
	self requestNewConfigurationPass
]

{ #category : #'t - bar element' }
TToBarElement >> isWrapping [

	^ nodeWrapping ifNil: [ nodeWrapping := true ]
]

{ #category : #'t - bar element' }
TToBarElement >> isWrapping: aBoolean [

	nodeWrapping = aBoolean ifTrue: [ ^ self ].
	nodeWrapping := aBoolean.
	self requestNewConfigurationPass
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
TToBarElement >> sample: aDataItem [

	self nodeManager fakeDataItem: aDataItem.
	self reinstallFakeNode.
	self requestLayout
	
]

{ #category : #'t - bar element' }
TToBarElement >> uninstallFakeNode [

	self innerElement uninstallFakeNode
]
