Trait {
	#name : #TToListElementDecorator,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - selection mode changing' }
TToListElementDecorator >> beMultipleSelection [

	self next beMultipleSelection
]

{ #category : #'t - selection mode changing' }
TToListElementDecorator >> beSingleSelection [

	self next beSingleSelection
]

{ #category : #'t - selection mode changing' }
TToListElementDecorator >> beWithoutSelection [

	self next beWithoutSelection
]

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

{ #category : #'t - selection testing' }
TToListElementDecorator >> hasSelection [

	^ self next hasSelection
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

{ #category : #'t - children - accessing' }
TToListElementDecorator >> nodeAt: anIndex [

	^ self next nodeAt: anIndex
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
TToListElementDecorator >> primarySelectionDo: aBlock [

	^ self next primarySelectionDo: aBlock
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> primarySelectionIndexes [

	^ self next primarySelectionIndexes
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> scrollToIndex: anIndex [

	self next scrollToIndex: anIndex
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> secondarySelection [

	^ self next secondarySelection
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> secondarySelectionDo: aBlock [

	^ self next secondarySelectionDo: aBlock
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> secondarySelectionIndexes [

	^ self next secondarySelectionIndexes
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
TToListElementDecorator >> selectIndexes: aCollection [

	self next selectIndexes: aCollection
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectedIndexes [

	^ self next selectedIndexes
]

{ #category : #'t - accessing selection' }
TToListElementDecorator >> selectionDo: aBlock [

	self next selectionDo: aBlock
]

{ #category : #'t - infinite accessing' }
TToListElementDecorator >> withRowNumbers [ 

	self next withRowNumbers 
]
