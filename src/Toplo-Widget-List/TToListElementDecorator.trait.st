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
TToListElementDecorator >> innerElementDo: aBlock [

	^ aBlock value: self innerElement
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
TToListElementDecorator >> nodeContainerAt: anIndex [

	^ self next nodeContainerAt: anIndex
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodeContainers [

	^ self next nodeContainers
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodeContainersDetect: aValuable [

	^ self next nodeContainersDetect: aValuable
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodeContainersDo: aValuable [

	self innerElementDo: [ :inner | inner nodeContainersDo: aValuable ]
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodeContainersReject: aValuable [

	^ self next nodeContainersReject: aValuable
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodeContainersSelect: aValuable [

	^ self next nodeContainersSelect: aValuable
]

{ #category : #'t - list element decorator - children - accessing' }
TToListElementDecorator >> nodes [

	^ self nodeContainers collect: [ :container | container node ]
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

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withDecoration: aDecorationClass [

	self next withDecoration: aDecorationClass
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withRowNumbers [

	self toConfiguration rowNumbers: true
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withoutRowNumbers [

	self toConfiguration rowNumbers: false
]
