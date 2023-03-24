Trait {
	#name : #TToListElementDecorator,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - accessing context menu' }
TToListElementDecorator >> contextMenuFactory: aValuable [

	self next contextMenuFactory: aValuable
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> data [

	^ self next data
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> deselectAll [

	self next deselectAll
]

{ #category : #'t - children - accessing' }
TToListElementDecorator >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> infinite [

	^ self next infinite
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> isSelectedAtIndex: anIndex [

	^ self next isSelectedAtIndex: anIndex
]

{ #category : #'t - accessing constraints' }
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

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeFactory: aNodeFactory [

	self next nodeFactory: aNodeFactory
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> primarySelection [

	^ self next primarySelection
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectAll [

	self next selectAll
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectIndex: anInteger [

	self next selectIndex: anInteger
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectedIndexes [

	^ self next selectedIndexes
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withRowNumbers [ 

	self next withRowNumbers 
]
