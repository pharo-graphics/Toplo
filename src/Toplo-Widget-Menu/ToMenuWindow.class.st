Class {
	#name : #ToMenuWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #configuration }
ToMenuWindow >> applyConfiguration [ 

	super applyConfiguration.
	self isScrollable 
		ifTrue: [
			self itemBar isVertical
				ifTrue: [
					self itemBar vMatchParent.
					self itemBar hFitContent ]
				ifFalse: [
					self itemBar hMatchParent.
					self itemBar vFitContent ] ]
		ifFalse: [
			self itemBar fitContent ]
]

{ #category : #'t - relayoutable window element - accessing' }
ToMenuWindow >> correctedPositionAccordingToAnchorRoot [

	| t rect rootRect parentMenu parentMenuBounds rootMenuOrMenuPane |
	rect := (self measuredBounds inSpace inChild: self anchorRoot) bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	t := rect amountToTranslateWithin: rootRect.
	" the parent menu is the element of my window manager "
	parentMenu := self manager anchorElement.
	" in case of a root menu (including context menu), just keep the computed position.
	If not, then in case of an horizontal menubar, keep also the computed position.
	In case of a vertical menubar, it may be necessary to also fix the position x "
	rootMenuOrMenuPane := parentMenu rootMenuItemContainer.
	(t x isZero or: [
		 parentMenu isSubmenu not and: [
			 rootMenuOrMenuPane isNil or: [ rootMenuOrMenuPane isHorizontal ] ] ])
		ifTrue: [ ^ super correctedPositionAccordingToAnchorRoot + t ].
	" If a translation is necessary, then open on the parent menu left "
	parentMenuBounds := parentMenu bounds inParent: self anchorRoot.
	^ parentMenuBounds topLeft - (self width @ t y negated)
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #initialization }
ToMenuWindow >> initialize [

	super initialize.
	self addEventHandler: ToMenuContainerEventHandler new
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> isInline [

	^ self anchorElement isInline
]

{ #category : #testing }
ToMenuWindow >> isScrollable [ 

	^ self itemBar isScrollable
]

{ #category : #accessing }
ToMenuWindow >> isScrollable: aBoolean [

	self itemBar isScrollable: aBoolean.
	self requestConfiguration
]

{ #category : #accessing }
ToMenuWindow >> itemBar [ 

	^ self anchorElement itemBar
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> itemContainer [

	^ self anchorElement
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> itemList [


	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> menuItem [

	^ self manager anchorElement
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> menuWindow [

	^ self
]

{ #category : #skin }
ToMenuWindow >> newRawSkin [ 

	^ ToMenuContainerSkin new
]

{ #category : #'t - anchored window element - private layout' }
ToMenuWindow >> newStartLayoutStep [ 

	^ ToMenuContainerOpeningStartStep new
]

{ #category : #'t - anchored window element - accessing' }
ToMenuWindow >> withAllSubwindowsDo: aBlock [

	self items do: [ :i |
		i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]
