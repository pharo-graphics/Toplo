Trait {
	#name : #TToBarElement,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

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
TToBarElement >> installFakeNode [

	self innerElement installFakeNode
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
TToBarElement >> uninstallFakeNode [

	self innerElement uninstallFakeNode
]
