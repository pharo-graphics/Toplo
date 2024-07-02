Trait {
	#name : #TToListElementDecorator,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - infinite scrolled event' }
TToListElementDecorator >> disableScrolledEvent [

	self next disableScrolledEvent
]

{ #category : #'t - infinite scrolled event' }
TToListElementDecorator >> enableScrolledEvent [

	self next enableScrolledEvent
]

{ #category : #'t - children - accessing' }
TToListElementDecorator >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> innerContainer [

	^ self next innerContainer
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> layoutPositionsRange [

	^ self next layoutPositionsRange
]

{ #category : #'t - accessing constraints' }
TToListElementDecorator >> maxHeight: aHeight [

	self next maxHeight: aHeight
]

{ #category : #'t - accessing constraints' }
TToListElementDecorator >> minHeight: aHeight [

	self next minHeight: aHeight
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> next [

	^ self explicitRequirement
]

{ #category : #'t - children - accessing' }
TToListElementDecorator >> nodeAt: anIndex [

	^ self next nodeAt: anIndex
]

{ #category : #'t - children - accessing' }
TToListElementDecorator >> nodes [

	^ self next nodes
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToDataSourcePosition: anIndex [

	self next scrollToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndex: anIndex [
	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndex: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndexAtTop: anIndex [

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndexAtTop: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.
	self scrollToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollTowardEndToDataSourcePosition: anIndex [

	self next scrollTowardEndToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollTowardStartToDataSourcePosition: anIndex [

	self next scrollTowardStartToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> smoothScrollToDataSourcePosition: anIndex [

	self next smoothScrollToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> stopScroll [

	self next stopScroll 
]
