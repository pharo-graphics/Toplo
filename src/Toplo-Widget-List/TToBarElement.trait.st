Trait {
	#name : #TToBarElement,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - bar element - fake container' }
TToBarElement >> addFakeNodeContainer: aNodeContainer [

	self addChild: aNodeContainer at: 1
]

{ #category : #'t - bar element' }
TToBarElement >> defaultInnerElementClass [

	^ ToInnerFiniteListElement 
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> fakeNodeContainer [

	^ (self hasChildren and: [ self firstChild isFake ])
		  ifTrue: [ self firstChild ]
		  ifFalse: [ ]
]

{ #category : #'t - bar element' }
TToBarElement >> initializeAsBarElement [

	self installFakeNodeContainer
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> installFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeContainer |
	fakeContainer := self nodeManager newFakeNodeContainerIn: self.

	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self addFakeNodeContainer: fakeContainer.
	self nodeManager buildNode: fakeContainer node.
	self requestConfiguration
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> reinstallFakeNodeContainer [

	self uninstallFakeNodeContainer.
	self installFakeNodeContainer
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> removeFakeNodeContainer [

	self fakeNodeContainer ifNil: [ Error signal: 'Fake node container not present' ].
	self fakeNodeContainer removeFromParent
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> sample [

	^ self nodeManager fakeDataItem
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> sample: aDataItem [

	self nodeManager fakeDataItem: aDataItem.
	self reinstallFakeNodeContainer.
	self requestLayout
	
]

{ #category : #'t - bar element' }
TToBarElement >> trackElement [

	^ self innerElement trackElement
]

{ #category : #'t - bar element - fake container' }
TToBarElement >> uninstallFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self removeFakeNodeContainer
]
