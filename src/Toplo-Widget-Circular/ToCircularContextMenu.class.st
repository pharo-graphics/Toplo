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

{ #category : #'t - menu window model' }
ToCircularContextMenu >> isTopMenu [

	^ true
]

{ #category : #'t - item list user - accessing' }
ToCircularContextMenu >> itemList [

	^ itemList
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

{ #category : #'t - item list user - adding/removing' }
ToCircularContextMenu >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - menu item list user - double dispatch' }
ToCircularContextMenu >> onAddedMenu: aMenu [

	"super onAddedMenu: aMenu."
	aMenu isSubmenu: true
]

{ #category : #layout }
ToCircularContextMenu >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToCircularContextMenu >> onMeasure: anExtentMeasurementSpec [

	self measureWithExtentMeasurementSpec: anExtentMeasurementSpec onEvent: self lastPopupEvent.
	super onMeasure: anExtentMeasurementSpec
]

{ #category : #'t - annulus sector layout user' }
ToCircularContextMenu >> stateHolder [

	^ self itemList 
]
