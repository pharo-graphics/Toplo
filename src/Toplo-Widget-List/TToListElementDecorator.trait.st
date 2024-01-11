Trait {
	#name : #TToListElementDecorator,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> data [

	^ self next data
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> dataSource [

	^ self next dataSource
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> deselectAll [

	self
		deprecated: 'Use selection deselectAll instead'
		transformWith: '`@receiver deselectAll' -> '`@receiver selection deselectAll'.
	self selection deselectAll
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> deselectIndex: anIndex [

	self
		deprecated: 'Use selection deselectIndex: instead'
		transformWith: '`@receiver deselectIndex: `@arg' -> '`@receiver selection deselectIndex: `@arg'.
	self selection deselectIndex: anIndex
]

{ #category : #'t - infinite scrolled event' }
TToListElementDecorator >> disableScrolledEvent [

	self next disableScrolledEvent
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> dispatchSelectionChangedAfter: aBlock [

	self next dispatchSelectionChangedAfter: aBlock
]

{ #category : #'t - infinite scrolled event' }
TToListElementDecorator >> enableScrolledEvent [

	self next enableScrolledEvent
]

{ #category : #'t - children - accessing' }
TToListElementDecorator >> findElementHolderForDataSourcePosition: anInteger [

	^ self next findElementHolderForDataSourcePosition: anInteger
]

{ #category : #'t - selection testing' }
TToListElementDecorator >> hasSelection [

	self
		deprecated: 'Use selection isNotEmpty instead'
		transformWith: '`@receiver hasSelection' -> '`@receiver selection isNotEmpty'.	
	^ self next hasSelection
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> infinite [

	^ self next infinite
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
TToListElementDecorator >> nodeBuilder: aNodeFactory [

	self next nodeBuilder: aNodeFactory
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> nodeClass: aNodeClass [

	self next nodeClass: aNodeClass
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> preserveSelectionOnFocused: aBoolean [

	self next preserveSelectionOnFocused: aBoolean
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> requestFocusOnMouseDown [

	^ self next requestFocusOnMouseDown
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> requestFocusOnMouseDown: aBoolean [

	self next requestFocusOnMouseDown: aBoolean
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndex: anIndex [

	self next scrollToIndex: anIndex
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndexAtTop: anIndex [

	self next scrollToIndexAtTop: anIndex
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectAll [

	self
		deprecated: 'Use selection selectAll instead'
		transformWith: '`@receiver selectAll' -> '`@receiver selection selectAll'.

	self selection selectAll
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectIndex: anIndex [

	self
		deprecated: 'Use selection selectIndex: instead'
		transformWith: '`@receiver selectIndex: `@arg' -> '`@receiver selection selectIndex: `@arg'.
	self selection selectIndex: anIndex
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectIndexes: aCollection [

	self
		deprecated: 'Use selection selectIndexes: instead'
		transformWith: '`@receiver selectIndexes: `@arg' -> '`@receiver selection selectIndexes: `@arg'.
	self selection selectIndexes: aCollection
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectOnlyIndex: anIndex [

	self
		deprecated: 'Use selection selectOnlyIndex: instead'
		transformWith: '`@receiver selectOnlyIndex: `@arg' -> '`@receiver selection selectOnlyIndex: `@arg'.
	self selection selectOnlyIndex: anIndex
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectedIndex [

	self
		deprecated: 'Use selection selectedIndex instead'
		transformWith: '`@receiver selectedIndex' -> '`@receiver selection selectedIndex'.
	^ self selection selectedIndex
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectedIndexes [

	self
		deprecated: 'Use selection selectedIndexes instead'
		transformWith: '`@receiver selectedIndexes' -> '`@receiver selection selectedIndexes'.
	^ self selection selectedIndexes
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selection [

	^ self next selection
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selection: aSelectionStrategy [

	^ self next selection: aSelectionStrategy
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> shiftSelectionAfterAddingAt: aStartPosition itemCount: anItemCount [

	self
		deprecated: 'Use selection shiftAfterAddingAt:itemCount: instead'
		transformWith: '`@receiver shiftSelectionAfterAddingAt: `@arg1 itemCount: `@arg2' -> '`@receiver selection shiftAfterAddingAt: `@arg1 itemCount: `@arg2 '.
	self selection
		shiftAfterAddingAt: aStartPosition
		itemCount: anItemCount
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> shiftSelectionAfterRemovingAt: aStartPosition itemCount: anItemCount [

	self
		deprecated: 'Use selection shiftSelectionAfterRemovingAt:itemCount: instead'
		transformWith: '`@receiver shiftSelectionAfterRemovingAt: `@arg1 itemCount: `@arg2' -> '`@receiver selection shiftAfterRemovingAt: `@arg1 itemCount: `@arg2 '.
	self selection
		shiftAfterRemovingAt: aStartPosition
		itemCount: anItemCount
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withRowNumbers [ 

	self next withRowNumbers 
]
