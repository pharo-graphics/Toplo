Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToOrientable + TToItemListOwner + TToMenuItemListUser + TToMenuWindowModel + TToItemListUser',
	#classTraits : 'TToOrientable classTrait + TToItemListOwner classTrait + TToMenuItemListUser classTrait + TToMenuWindowModel classTrait + TToItemListUser classTrait',
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'t - menu window model' }
ToContextMenu >> close [

	super close
]

{ #category : #'t - menu window model' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : #'t - relayoutable window element - accessing' }
ToContextMenu >> correctedPositionAccordingToAnchorRoot [

	| t rect rootRect |
	rect := (self measuredBounds inSpace inChild: self anchorRoot) bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	" just translate the position to remain (if possible) within the root bounds "
	t := rect amountToTranslateWithin: rootRect.
	^ self measuredPosition + t
]

{ #category : #initialization }
ToContextMenu >> initialize [

	super initialize.
	self fitContent.
	self closeOnPicking: true.
	self initializeAsItemListOwner.
	self initializeAsMenuItemListUser.
	self root addChild: self itemList
]

{ #category : #'t - menu window model' }
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
ToContextMenu >> isOutsideEvent: anEvent [

	| windows |
	windows := Array streamContents: [ :stream |
			           self manager currentWindowDo: [ :w |
				           w allSubwindowsDo: [ :sub | stream nextPut: sub ] ] ].
	(windows allSatisfy: [ :w | w isOutsideEvent: anEvent ]) ifFalse: [
		^ false ].
	(self items allSatisfy: [ :it | it isOutsideEvent: anEvent ])
		ifFalse: [ ^ false ].
	^ super isOutsideEvent: anEvent
]

{ #category : #'t - menu window model' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #accessing }
ToContextMenu >> itemContainer [

	^ self 
]

{ #category : #'t - item list user - accessing' }
ToContextMenu >> itemList [

	^ itemList
]

{ #category : #accessing }
ToContextMenu >> menuPane [ 
	" a context menu can't be in a menupane "
	^ nil
]

{ #category : #'t - menu window model' }
ToContextMenu >> menuWindow [

	^ self 
]

{ #category : #'t - item list owner - initializing' }
ToContextMenu >> newItemList [

	^ ToMenuItemListElement new
]

{ #category : #'t - menu item list user - double dispatch' }
ToContextMenu >> onAddedMenu: aMenu [

	aMenu isSubmenu: true
]

{ #category : #'t - menu item list user - double dispatch' }
ToContextMenu >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
