Trait {
	#name : #TToItemBarElement,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> addAllItems: aCollection [

	self items addAll: aCollection
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - accessing' }
TToItemBarElement >> barOwner [

	^ self userData at: #barOwner ifAbsent: [  ]
]

{ #category : #'t - item bar element - accessing' }
TToItemBarElement >> barOwner: aBarOwner [

	self userData at: #barOwner put: aBarOwner
]

{ #category : #'t - item bar element - accessing' }
TToItemBarElement >> defaultNodeManagerClass [

	^ ToItemNodeManager
]

{ #category : #'t - item bar element - disabled/enabled' }
TToItemBarElement >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - disabled/enabled' }
TToItemBarElement >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemBarElement >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - accessing' }
TToItemBarElement >> initializeAsItemBarElement [ 

	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - item bar element - accessing' }
TToItemBarElement >> items [ 

	^ self dataAccessor
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> onAddedItem: anItem [

	anItem barElement: self
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> onRemovedItem: anItem [

	anItem barElement: nil
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item bar element - adding/removing' }
TToItemBarElement >> removeItem: anItem [

	self items remove: anItem.
	self onRemovedItem: anItem
]

{ #category : #'t - item bar element - unselectable/selectable' }
TToItemBarElement >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - unselectable/selectable' }
TToItemBarElement >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemBarElement >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
