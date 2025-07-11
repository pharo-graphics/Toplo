Trait {
	#name : #TToListElementDecorator,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> cleanUpRecyclerAt: anIndex [

	self next cleanUpRecyclerAt: anIndex

]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> customRecycler [

	^ self next customRecycler
]

{ #category : #'t - list element decorator - infinite scrolled event' }
TToListElementDecorator >> disableScrolledEvent [

	self next disableScrolledEvent
]

{ #category : #'t - list element decorator - infinite scrolled event' }
TToListElementDecorator >> enableScrolledEvent [

	self next enableScrolledEvent
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> innerElement [

	^ self next innerElement
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> layoutPositionsRange [

	^ self next layoutPositionsRange
]

{ #category : #'t - list element decorator - accessing constraints' }
TToListElementDecorator >> maxHeight: aHeight [

	self next maxHeight: aHeight
]

{ #category : #'t - list element decorator - accessing constraints' }
TToListElementDecorator >> minHeight: aHeight [

	self next minHeight: aHeight
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> next [

	^ self explicitRequirement
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodeAt: anIndex [

	^ self next nodeAt: anIndex
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodes [

	^ self next nodes
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodesDetect: aValuable [

	^ self next nodesDetect: aValuable
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodesDo: aValuable [

	self next nodesDo: aValuable
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodesSelect: aValuable [

	^ self next nodesSelect: aValuable
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> scrollToDataSourcePosition: anIndex [

	self next scrollToDataSourcePosition: anIndex
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> scrollToIndex: anIndex [
	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndex: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> scrollToIndexAtTop: anIndex [

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndexAtTop: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.
	self scrollToDataSourcePosition: anIndex
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> scrollTowardEndToDataSourcePosition: anIndex [

	self next scrollTowardEndToDataSourcePosition: anIndex
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> scrollTowardStartToDataSourcePosition: anIndex [

	self next scrollTowardStartToDataSourcePosition: anIndex
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> smoothScrollToDataSourcePosition: anIndex [

	self next smoothScrollToDataSourcePosition: anIndex
]

{ #category : #'t - list element decorator - infinite accessing' }
TToListElementDecorator >> stopScroll [

	self next stopScroll 
]
