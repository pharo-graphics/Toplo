Class {
	#name : #ToMenuWindow,
	#superclass : #ToAnchoredWindow,
	#traits : 'TToMenuItemContainer',
	#classTraits : 'TToMenuItemContainer classTrait',
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'t - inline window element - accessing' }
ToMenuWindow >> correctedPositionWithinAnchorRoot [

	| t rect rootRect parentMenu parentMenuBounds rootMenuOrMenuPane |
	rect := self measuredBounds inSpace bounds asRectangle.
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

{ #category : #accessing }
ToMenuWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : #testing }
ToMenuWindow >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #initialization }
ToMenuWindow >> initialize [

	super initialize.
	self addEventHandler: ToMenuWindowEventHandler new
]

{ #category : #testing }
ToMenuWindow >> isInline [

	^ self anchorElement isInline
]

{ #category : #accessing }
ToMenuWindow >> itemBar [

	^ self anchorElement itemBar
]

{ #category : #accessing }
ToMenuWindow >> itemContainer [

	^ self anchorElement
]

{ #category : #accessing }
ToMenuWindow >> itemList [


	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #accessing }
ToMenuWindow >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToMenuWindow >> menuWindow [

	^ self
]

{ #category : #skin }
ToMenuWindow >> newRawSkin [ 

	^ ToMenuWindowSkin new
]

{ #category : #enumerating }
ToMenuWindow >> withAllSubwindowsDo: aBlock [

	self items do: [ :i |
		i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]
