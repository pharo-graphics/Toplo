Class {
	#name : #ToClickableSkin,
	#superclass : #ToWidgetSkin,
	#traits : 'TToShapeableWidgetSkin',
	#classTraits : 'TToShapeableWidgetSkin classTrait',
	#instVars : [
		'cursorLook',
		'type'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #'instance creation' }
ToClickableSkin class >> type: aButtonType [

	^ self new type: aButtonType 
]

{ #category : #'t - shapeable - private - shaping/sizing' }
ToClickableSkin >> applyCircleShaping: aShaping on: anElement [
 
	anElement tripletStrategy: ToTripletCenterStrategy new.
	anElement padding: BlInsets empty.
	anElement size: (aShaping sizing heightOn: anElement) asPoint.
	anElement geometry: BlCircleGeometry new
]

{ #category : #'t - shapeable - private - shaping/sizing' }
ToClickableSkin >> applyLargeSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'t - shapeable - private - shaping/sizing' }
ToClickableSkin >> applyMiddleSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'private - shaping/sizing' }
ToClickableSkin >> applyQuadShaping: aShaping on: anElement [

	(anElement layout isKindOf: BlLinearLayout) ifFalse: [
		anElement layout: BlLinearLayout new ].

	anElement verticalRequested
		ifTrue: [
			anElement interspace: anElement toTheme paddingContentVertical / 3 ]
		ifFalse: [
			(anElement isJustified or: [anElement columnWidth > 0]) ifFalse: [
				anElement interspace: anElement toTheme paddingContentHorizontal / 3 ] ].

	anElement padding: (self defaultPaddingIn: anElement)
]

{ #category : #'t - shapeable - private - shaping/sizing' }
ToClickableSkin >> applyRectangleShaping: aShaping on: anElement [
 
	| radius |
	self applyQuadShaping: aShaping on: anElement.
	radius := aShaping radius ifNil: [ aShaping sizing shapingRadiusIn: anElement ].
	radius > 0 ifTrue: [ 
		^ anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius) ].
	anElement geometry: BlRectangleGeometry new
]

{ #category : #'t - shapeable - private - shaping/sizing' }
ToClickableSkin >> applyRoundShaping: aShaping on: anElement [
 
	| radius |
	self applyQuadShaping: aShaping on: anElement.	
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'private - shaping/sizing' }
ToClickableSkin >> applySizing: aSizing on: anElement [
 
	anElement layout isOrientable ifTrue: [
		anElement isHorizontal ifFalse: [ ^ anElement vFitContent ] ].
	anElement height: (aSizing heightOn: anElement).

]

{ #category : #'t - shapeable - private - shaping/sizing' }
ToClickableSkin >> applySmallSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> backgroundLookIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> borderLookIn: anElement [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToClickableSkin >> changeTypeWith: aSkinType in: anElement [
 
	"DefaultType, PrimaryType, LinkType or TextType "
	self type: aSkinType.
	self dispatchChangedEventIn: anElement
]

{ #category : #'private children updating' }
ToClickableSkin >> childAdded: aChild in: anElement [
	" in a button, children are centered whatever the layout (Linear or Frame)"

	aChild constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter.
		c frame vertical alignCenter.
		c frame horizontal alignCenter ]
]

{ #category : #'api - accessing' }
ToClickableSkin >> childSkinsToHandle [
 
	^ {
		  (ToChildSkinBuilder new
			   slotName: #icon;
			   builder: [ :e | self iconSkinIn: e ];
			   yourself).
		  (ToChildSkinBuilder new
			   slotName: #label;
			   builder: [ :e | self labelSkinIn: e ];
			   yourself) }
]

{ #category : #accessing }
ToClickableSkin >> danger [

	^ self type danger
]

{ #category : #accessing }
ToClickableSkin >> danger: aBoolean [
 
	self type danger: aBoolean
]

{ #category : #accessing }
ToClickableSkin >> dashed [
 
	^ self type dashed
]

{ #category : #accessing }
ToClickableSkin >> dashed: aBoolean [
 
	self type dashed: aBoolean
]

{ #category : #'private - shaping/sizing' }
ToClickableSkin >> defaultPaddingIn: anElement [

	^ BlInsets
		  top: anElement toTheme paddingXS / 2
		  left: anElement toTheme paddingContentHorizontal / 2
		  bottom: anElement toTheme paddingXS / 2
		  right: anElement toTheme paddingContentHorizontal / 2
]

{ #category : #'t - shapeable - initialization' }
ToClickableSkin >> defaultShaping [

	^ ToRectangleShaping new 
]

{ #category : #'t - shapeable - initialization' }
ToClickableSkin >> defaultSizing [
 
	^ ToMiddleSizing new
]

{ #category : #accessing }
ToClickableSkin >> defaultType [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToClickableSkin >> elementLayoutChangedEvent: anEvent [
 
	anEvent currentTarget checkOrientableLayout
	
]

{ #category : #'api - accessing' }
ToClickableSkin >> eventsToHandle [
 
	^ super eventsToHandle , { BlElementLayoutChangedEvent }
]

{ #category : #accessing }
ToClickableSkin >> iconSkinIn: aButton [
 
	^ self subclassResponsibility 
]

{ #category : #initialization }
ToClickableSkin >> initialize [ 
 
	super initialize.
	self intializeShapingSkin
]

{ #category : #accessing }
ToClickableSkin >> labelSkinIn: aButton [
 
	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToClickableSkin >> layoutOrientationChangedEvent: anEvent [
 
	super layoutOrientationChangedEvent: anEvent.
	self applySizingAndShapingOn: anEvent target
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> onSkinInstalledIn: anElement [

	| backgroundLook borderLook |
	super onSkinInstalledIn: anElement.
	cursorLook := ToMouseCursorLook new.
	cursorLook hoverCursor: [ :but | but isEnabled ifTrue: [ BlCursor hand ] ifFalse: []].
	self addLook: cursorLook.

	self onShapingSkinInstalledIn: anElement.
	" remove the background and the border in case the button type is changing "
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	backgroundLook := self backgroundLookIn: anElement.
	backgroundLook ifNotNil: [ self addLook: backgroundLook ].
	borderLook := self borderLookIn: anElement.
	borderLook ifNil: [ ^ self ].
	self addLook: borderLook
]

{ #category : #'api - install/uninstall  hook' }
ToClickableSkin >> onSkinUninstalledIn: anElement [

	self removeLook: cursorLook.
	self onShapingSkinUninstalledIn: anElement.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToClickableSkin >> type [

	"#default, #primary, #link or #text"
	^ type ifNil: [ type := self defaultType ]
]

{ #category : #accessing }
ToClickableSkin >> type: aSkinType [
 
	"DefaultType, PrimaryType, LinkType or TextType "
	type := aSkinType
]
