Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToMenuWindow >> correctedPositionWithinAnchorRoot [

	| t rect rootRect parentMenu parentMenuBounds |
	rect := self bounds inSpace bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	t := rect amountToTranslateWithin: rootRect.
	" the parent menu is the element of my window manager "
	parentMenu := self manager element.
	" in case of a root menu (including context menu), just keep the computed position "
	(t x isZero or: [ parentMenu isSubmenu not ]) ifTrue: [
		^ super correctedPositionWithinAnchorRoot + t ].
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

{ #category : #accessing }
ToMenuWindow >> itemContainer [

	^ self element
]

{ #category : #accessing }
ToMenuWindow >> itemList [ 

	^ self element itemList
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
