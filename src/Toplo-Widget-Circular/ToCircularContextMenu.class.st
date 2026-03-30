Class {
	#name : #ToCircularContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuWindowModel + TToItemListOwner + TToMenuItemListUser + TToItemListUser + TToAnnulusSectorLayoutUser + TToAnnulusCircularLayoutUser + TToCircularMenuListUser',
	#classTraits : 'TToMenuWindowModel classTrait + TToItemListOwner classTrait + TToMenuItemListUser classTrait + TToItemListUser classTrait + TToAnnulusSectorLayoutUser classTrait + TToAnnulusCircularLayoutUser classTrait + TToCircularMenuListUser classTrait',
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #enumerating }
ToCircularContextMenu >> allParentMenusOrMenuPaneDo: aBlock [
]

{ #category : #configuration }
ToCircularContextMenu >> applyConfiguration [

	super applyConfiguration.
	self geometry: BlCircleGeometry new.
	self padding: BlInsets empty.
	self extent: (self layoutRadius * 2) asPoint
]

{ #category : #'t - menu window model' }
ToCircularContextMenu >> closeWindow [

	self close
]

{ #category : #'t - relayoutable window element - accessing' }
ToCircularContextMenu >> correctedPositionAccordingToAnchorRoot [

	| t rect rootRect |
	rect := (self measuredBounds inSpace inChild: self anchorRoot) bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	" just translate the position to remain (if possible) within the root bounds "
	t := rect amountToTranslateWithin: rootRect.
	^ self measuredPosition + t
]

{ #category : #initialization }
ToCircularContextMenu >> initialize [ 

	super initialize.
	self closeOnPicking: true.
	self layout: BlFrameLayout new.
	self initializeAsItemListOwner.
	self initializeAsMenuItemListUser.
	self root addChild: self itemList.
	self itemList constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self fitContent
]

{ #category : #testing }
ToCircularContextMenu >> isOutsideEvent: anEvent [

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
ToCircularContextMenu >> isTopMenu [

	^ true
]

{ #category : #'t - item list user - accessing' }
ToCircularContextMenu >> itemList [

	^ itemList
]

{ #category : #'t - anchored window element - accessing' }
ToCircularContextMenu >> menuItem [

	^ nil
]

{ #category : #'t - menu item' }
ToCircularContextMenu >> menuPane [ 

	^ nil
]

{ #category : #'t - menu window model' }
ToCircularContextMenu >> menuWindow [

	^ self 
]

{ #category : #'instance creation' }
ToCircularContextMenu >> newItemList [ 

	^ ToCircularMenuList new
]

{ #category : #skin }
ToCircularContextMenu >> newRawSkin [ 

	^ ToCircularMenuWindowSkin new
]

{ #category : #'t - annulus sector layout user' }
ToCircularContextMenu >> stateHolder [

	^ self itemList 
]
