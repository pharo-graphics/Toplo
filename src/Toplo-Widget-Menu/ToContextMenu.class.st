Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToOrientable + TToItemListHolder + TToMenuItemListHolder + TToMenuWindowModel',
	#classTraits : 'TToOrientable classTrait + TToItemListHolder classTrait + TToMenuItemListHolder classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #accessing }
ToContextMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #'t - menu window model' }
ToContextMenu >> close [

	super close
]

{ #category : #'t - menu window model' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : #'api - displaying' }
ToContextMenu >> correctedPositionWithinAnchorRoot [

	| t rect rootRect |
	rect := self bounds inSpace bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	" just translate the position to remain (if possible) within the root bounds "
	t := rect amountToTranslateWithin: rootRect.
	^ self position + t
]

{ #category : #initialization }
ToContextMenu >> initialize [ 

	super initialize.
	self fitContent.
	self root addChild: self itemList
]

{ #category : #testing }
ToContextMenu >> isInline [ 

	^ false
]

{ #category : #testing }
ToContextMenu >> isMenu [

	^ true
]

{ #category : #'t - menu window model' }
ToContextMenu >> isOpened [

	^ super isOpened
]

{ #category : #testing }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu window model' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #accessing }
ToContextMenu >> itemContainer [

	^ self 
]

{ #category : #'t - orientable - accessing' }
ToContextMenu >> layoutStrategy [

	^ self layout 

	
]

{ #category : #accessing }
ToContextMenu >> menuBar [ 
	" a context menu can't be in a menubar "
	^ nil
]

{ #category : #'t - menu window model' }
ToContextMenu >> menuWindow [

	^ super menuWindow
]

{ #category : #'t - item list holder - accessing' }
ToContextMenu >> newItemList [

	^ ToMenuItemListElement new
]

{ #category : #'t - menu window model' }
ToContextMenu >> popupEvent: anEvent [

	^ super popupEvent: anEvent
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
