Trait {
	#name : #TToListElementDecorator,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #resolution }
TToListElementDecorator >> clearSelection [

	self next clearSelection
]

{ #category : #'t - accessing context menu' }
TToListElementDecorator >> contextMenuFactory: aValuable [

	self next contextMenuFactory: aValuable
]

{ #category : #accessing }
TToListElementDecorator >> data [

	^ self next data
]

{ #category : #'children - accessing' }
TToListElementDecorator >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> infinite [

	^ self next infinite
]

{ #category : #accessing }
TToListElementDecorator >> maxHeight: aHeight [

	self next maxHeight: aHeight
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> next [

	^ next
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> next: aDecoratorOrInfinite [

	next := aDecoratorOrInfinite
]

{ #category : #accessing }
TToListElementDecorator >> nodeFactory: aNodeFactory [

	self next nodeFactory: aNodeFactory
]

{ #category : #api }
TToListElementDecorator >> selectIndex: anInteger [

	self next selectIndex: anInteger
]

{ #category : #'api - selection' }
TToListElementDecorator >> selectedIndexes [

	^ self next selectedIndexes
]

{ #category : #accessing }
TToListElementDecorator >> selectedNodeFactory: aNodeFactory [

	self next selectedNodeFactory: aNodeFactory
]

{ #category : #'selection strategy' }
TToListElementDecorator >> selectionStrategy [

	^ self next selectionStrategy
]

{ #category : #'t - infinite editor view - configuration' }
TToListElementDecorator >> withRowNumbers [ 

	self next withRowNumbers 
]
