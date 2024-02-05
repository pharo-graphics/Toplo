Trait {
	#name : #TToListElementDecorator2,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> data [

	^ self next data
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> dataSource [

	^ self next dataSource
]

{ #category : #'t - infinite scrolled event' }
TToListElementDecorator2 >> disableScrolledEvent [

	self next disableScrolledEvent
]

{ #category : #'t - infinite scrolled event' }
TToListElementDecorator2 >> enableScrolledEvent [

	self next enableScrolledEvent
]

{ #category : #'t - children - accessing' }
TToListElementDecorator2 >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> infinite [

	^ self next infinite
]

{ #category : #'t - accessing constraints' }
TToListElementDecorator2 >> maxHeight: aHeight [

	self next maxHeight: aHeight
]

{ #category : #'t - accessing constraints' }
TToListElementDecorator2 >> minHeight: aHeight [

	self next minHeight: aHeight
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> next [

	^ next
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> next: aDecoratorOrInfinite [

	next := aDecoratorOrInfinite
]

{ #category : #'t - children - accessing' }
TToListElementDecorator2 >> nodeAt: anIndex [

	^ self next nodeAt: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> nodeBuilder: aNodeFactory [

	self next nodeBuilder: aNodeFactory
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> nodeClass: aNodeClass [

	self next nodeClass: aNodeClass
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> scrollToDataSourcePosition: anIndex [

	self next scrollToDataSourcePosition: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> scrollToIndex: anIndex [

	self next scrollToIndex: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> scrollToIndexAtTop: anIndex [

	self next scrollToIndexAtTop: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator2 >> withRowNumbers [ 

	self next withRowNumbers 
]
