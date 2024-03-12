Trait {
	#name : #TToListElementDecorator,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> dataSourceManager [
	
	^ next dataSourceManager
]

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
TToListElementDecorator >> infinite [

	^ self next infinite
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> layoutCritical: aBlock [

	self next layoutCritical: aBlock
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

	^ next
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> next: aDecoratorOrInfinite [

	next := aDecoratorOrInfinite
]

{ #category : #'t - children - accessing' }
TToListElementDecorator >> nodeAt: anIndex [

	^ self next nodeAt: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeBuilder [

	^ self next nodeBuilder
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeBuilder: aValuable [

	self next nodeBuilder: aValuable
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeClass: aNodeClass [

	self next nodeClass: aNodeClass
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeFactory: aValuable [

	self next nodeFactory: aValuable
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeHolderClass: aNodeHolderClass [

	self next nodeHolderClass: aNodeHolderClass
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeReleaser: aValuable [

	self next nodeReleaser: aValuable
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToDataSourcePosition: anIndex [

	self next scrollToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndex: anIndex [

	self next scrollToIndex: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndexAtTop: anIndex [

	self next scrollToIndexAtTop: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> stopScroll [

	self next stopScroll 
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withRowNumbers [ 

	self next withRowNumbers 
]
