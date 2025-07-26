Class {
	#name : #ToMenuContainer,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #configuration }
ToMenuContainer >> applyUpwardConfiguration [ 

	super applyUpwardConfiguration.
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

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> correctedPositionWithinAnchorRoot [

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
		ifTrue: [ ^ super correctedPositionWithinAnchorRoot + t ].
	" If a translation is necessary, then open on the parent menu left "
	parentMenuBounds := parentMenu bounds inParent: self anchorRoot.
	^ parentMenuBounds topLeft - (self width @ t y negated)
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #initialization }
ToMenuContainer >> initialize [

	super initialize.
	self addEventHandler: ToMenuContainerEventHandler new
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> isInline [

	^ self anchorElement isInline
]

{ #category : #testing }
ToMenuContainer >> isScrollable [ 

	^ self itemBar isScrollable
]

{ #category : #accessing }
ToMenuContainer >> isScrollable: aBoolean [

	self itemBar isScrollable: aBoolean.
	self requestConfiguration
]

{ #category : #accessing }
ToMenuContainer >> itemBar [ 

	^ self subclassResponsibility 
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> itemContainer [

	^ self anchorElement
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> itemList [


	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> menuWindow [

	^ self
]

{ #category : #skin }
ToMenuContainer >> newRawSkin [ 

	^ ToMenuContainerSkin new
]

{ #category : #'t - anchored window element - private layout' }
ToMenuContainer >> newStartLayoutStep [ 

	^ ToMenuContainerOpeningStartStep new
]

{ #category : #'t - anchored window element - accessing' }
ToMenuContainer >> withAllSubwindowsDo: aBlock [

	self items do: [ :i |
		i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]
