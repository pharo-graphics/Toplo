Trait {
	#name : #TToBarElement,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - bar element' }
TToBarElement >> defaultInnerElementClass [

	^ ToInnerBarElement 
]

{ #category : #'t - bar element' }
TToBarElement >> fakeNodeContainer [

	^ self innerElement fakeNodeContainer
]

{ #category : #'t - bar element' }
TToBarElement >> installFakeNodeContainer [

	self innerElement installFakeNodeContainer
]

{ #category : #'t - bar element' }
TToBarElement >> reinstallFakeNodeContainer [

	self uninstallFakeNodeContainer.
	self installFakeNodeContainer
]

{ #category : #'t - bar element' }
TToBarElement >> sample [

	^ self nodeManager fakeDataItem
]

{ #category : #'t - bar element' }
TToBarElement >> sample: aDataItem [

	self nodeManager fakeDataItem: aDataItem.
	self reinstallFakeNodeContainer.
	self requestLayout
	
]

{ #category : #'t - bar element' }
TToBarElement >> trackElement [

	^ self innerElement trackElement
]

{ #category : #'t - bar element' }
TToBarElement >> uninstallFakeNodeContainer [

	self innerElement uninstallFakeNodeContainer
]
