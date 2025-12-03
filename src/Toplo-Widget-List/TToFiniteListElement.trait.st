Trait {
	#name : #TToFiniteListElement,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> addFakeNodeContainer: aNodeContainer [

	self addChild: aNodeContainer at: 1
]

{ #category : #'t - bar element' }
TToFiniteListElement >> defaultInnerElementClass [

	^ ToInnerFiniteListElement 
]

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> fakeNodeContainer [

	^ (self hasChildren and: [ self firstChild isFake ])
		  ifTrue: [ self firstChild ]
		  ifFalse: [ ]
]

{ #category : #'t - bar element' }
TToFiniteListElement >> initializeAsBarElement [

	self installFakeNodeContainer
]

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> installFakeNodeContainer [
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
TToFiniteListElement >> reinstallFakeNodeContainer [

	self uninstallFakeNodeContainer.
	self installFakeNodeContainer
]

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> removeFakeNodeContainer [

	self fakeNodeContainer ifNil: [ Error signal: 'Fake node container not present' ].
	self fakeNodeContainer removeFromParent
]

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> sample [

	^ self nodeManager fakeDataItem
]

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> sample: aDataItem [

	self nodeManager fakeDataItem: aDataItem.
	self reinstallFakeNodeContainer.
	self requestLayout
	
]

{ #category : #'t - bar element' }
TToFiniteListElement >> trackElement [

	^ self innerElement trackElement
]

{ #category : #'t - bar element - fake container' }
TToFiniteListElement >> uninstallFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self removeFakeNodeContainer
]
