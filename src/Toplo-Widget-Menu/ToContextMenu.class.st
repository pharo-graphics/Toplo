Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToOrientable + TToMenuItemBarContainer + TToMenuWindowModel + TToItemBarContainer',
	#classTraits : 'TToOrientable classTrait + TToMenuItemBarContainer classTrait + TToMenuWindowModel classTrait + TToItemBarContainer classTrait',
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

{ #category : #testing }
ToContextMenu >> closeOnPicking [

	^ true
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
	self initializeAsItemBarContainer.
	self initializeAsMenuItemBarContainer.
	self root addChild: self itemBar
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

{ #category : #accessing }
ToContextMenu >> menuPane [ 
	" a context menu can't be in a menupane "
	^ nil
]

{ #category : #'t - menu window model' }
ToContextMenu >> menuWindow [

	^ self 
]

{ #category : #'t - item bar container - initializing' }
ToContextMenu >> newItemBar [

	^ ToMenuItemFiniteListElement new
]

{ #category : #'t - menu item bar container - double dispatch' }
ToContextMenu >> onAddedMenu: aMenu [

	aMenu isSubmenu: true
]

{ #category : #'t - menu item bar container - double dispatch' }
ToContextMenu >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
