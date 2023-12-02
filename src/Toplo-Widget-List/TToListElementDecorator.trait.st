Trait {
	#name : 'TToListElementDecorator',
	#instVars : [
		'next'
	],
	#category : 'Toplo-Widget-List-Core',
	#package : 'Toplo-Widget-List',
	#tag : 'Core'
}

{ #category : 't - selection mode changing' }
TToListElementDecorator >> beMultipleSelection [

	self next beMultipleSelection
]

{ #category : 't - selection mode changing' }
TToListElementDecorator >> beSingleSelection [

	self next beSingleSelection
]

{ #category : 't - selection mode changing' }
TToListElementDecorator >> beWithoutSelection [

	self next beWithoutSelection
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> data [

	^ self next data
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> dataSource [

	^ self next dataSource
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> deselectAll [

	self next deselectAll
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> deselectIndex: anIndex [

	self next deselectIndex: anIndex
]

{ #category : 't - infinite scrolled event' }
TToListElementDecorator >> disableScrolledEvent [

	self next disableScrolledEvent
]

{ #category : 't - infinite scrolled event' }
TToListElementDecorator >> enableScrolledEvent [

	self next enableScrolledEvent
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> ensureSelectIndex: anInteger [

	self next ensureSelectIndex: anInteger
]

{ #category : 't - children - accessing' }
TToListElementDecorator >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : 't - selection testing' }
TToListElementDecorator >> hasSelection [

	^ self next hasSelection
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> infinite [

	^ self next infinite
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> isSelectedAtIndex: anIndex [

	^ self next isSelectedAtIndex: anIndex
]

{ #category : 't - accessing constraints' }
TToListElementDecorator >> maxHeight: aHeight [

	self next maxHeight: aHeight
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> next [

	^ next
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> next: aDecoratorOrInfinite [

	next := aDecoratorOrInfinite
]

{ #category : 't - children - accessing' }
TToListElementDecorator >> nodeAt: anIndex [

	^ self next nodeAt: anIndex
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> nodeBuilder: aNodeFactory [

	self next nodeBuilder: aNodeFactory
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> nodeClass: aNodeClass [

	self next nodeClass: aNodeClass
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> preserveSelectionOnFocused: aBoolean [

	self next preserveSelectionOnFocused: aBoolean
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> scrollToIndex: anIndex [

	self next scrollToIndex: anIndex
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> scrollToIndexAtTop: anIndex [

	self next scrollToIndexAtTop: anIndex
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectAll [

	self next selectAll
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectAndScrollTo: anInteger [

	self next selectAndScrollTo: anInteger
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectIndex: anInteger [

	self next selectIndex: anInteger
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectIndexes: aCollection [

	self next selectIndexes: aCollection
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectedIndex [

	^ self next selectedIndex
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectedIndexes [

	^ self next selectedIndexes
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selection [

	^ self next selection
]

{ #category : 't - accessing selection' }
TToListElementDecorator >> selectionIndexes [

	^ self next selectionIndexes
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> whenChildAttachedDo: aBlock [

	self next whenChildAttachedDo: aBlock
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> whenChildDetachedDo: aBlock [

	self next whenChildDetachedDo: aBlock
]

{ #category : 't - infinite accessing' }
TToListElementDecorator >> withRowNumbers [ 

	self next withRowNumbers 
]
