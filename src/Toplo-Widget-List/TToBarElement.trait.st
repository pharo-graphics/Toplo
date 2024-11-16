Trait {
	#name : #TToBarElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'uniformNodeWidth'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - bar element' }
TToBarElement >> checkFullyVisibleNodes [ 

	self innerElement checkFullyVisibleNodes 
]

{ #category : #'t - bar element' }
TToBarElement >> configureLayout [

	self innerElement configureLayoutIn: self
]

{ #category : #'t - bar element' }
TToBarElement >> defaultEventHandler [

	^ ToBarElementEventHandler new
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
TToBarElement >> installFakeNode [

	self innerElement installFakeNode
]

{ #category : #'t - bar element' }
TToBarElement >> nodeAutoDistribution [

	^ nodeAutoDistribution ifNil: [ nodeAutoDistribution := false ] 
]

{ #category : #'t - bar element' }
TToBarElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution = aBoolean ifTrue: [ ^ self ].
	nodeAutoDistribution := aBoolean.
	" notify dataSource changed to renew all nodes "
	self notifyDataSourceChanged.
	self configureLayout
]

{ #category : #'t - bar element' }
TToBarElement >> nodeScrolling [

	^ nodeScrolling ifNil: [ nodeScrolling := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self configureLayout
]

{ #category : #'t - bar element' }
TToBarElement >> nodeWrapping [

	^ nodeWrapping ifNil: [ nodeWrapping := true ]
]

{ #category : #'t - bar element' }
TToBarElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self configureLayout
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
	self configureLayout
	
]

{ #category : #'t - bar element' }
TToBarElement >> uniformNodeWidth [

	^ uniformNodeWidth ifNil: [ uniformNodeWidth := false ]
]

{ #category : #'t - bar element' }
TToBarElement >> uniformNodeWidth: aBoolean [

	uniformNodeWidth := aBoolean.
	self configureLayout.
	self notifyDataSourceChanged

]

{ #category : #'t - bar element' }
TToBarElement >> uninstallFakeNode [

	self innerElement uninstallFakeNode
]
