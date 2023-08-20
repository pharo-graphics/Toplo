Class {
	#name : #ToAbstractButtonSkinNew,
	#superclass : #ToClickableSkin,
	#traits : 'TToReshapeableWidgetSkin',
	#classTraits : 'TToReshapeableWidgetSkin classTrait',
	#instVars : [
		'type',
		'labelFirst'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'instance creation' }
ToAbstractButtonSkinNew class >> type: aButtonType [

	^ self new type: aButtonType 
]

{ #category : #'private children updating' }
ToAbstractButtonSkinNew >> adaptNextChildrenArray: anArray in: anElement [
	" the skin can setup future children here "
 
	" in a button, children are centered whatever the layout (Linear or Frame)"
	anArray do: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter.
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].

	^ self shaping adaptNextChildrenArray: anArray in: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkinNew >> applyCircleShaping: aShaping on: anElement [
 
	anElement strategy: ToTripletCenterStrategy new.
	anElement padding: BlInsets empty.
	anElement size: (aShaping sizing heightOn: anElement) asPoint.
	anElement geometry: BlCircleGeometry new
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkinNew >> applyDefaultShaping: aShaping on: anElement [
 
	| radius |
	self applyRectShaping: aShaping on: anElement.
	radius := aShaping sizing shapingRadiusIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkinNew >> applyLargeSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkinNew >> applyMiddleSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkinNew >> applyRoundShaping: aShaping on: anElement [
 
	| radius |
	self applyRectShaping: aShaping on: anElement.	
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'private - shaping/sizing' }
ToAbstractButtonSkinNew >> applySizing: aSizing on: anElement [
 
	anElement hFitContent.
	anElement layout isOrientable ifTrue: [
		anElement isHorizontal ifFalse: [ ^ anElement vFitContent ] ].
	anElement height: (aSizing heightOn: anElement).

]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkinNew >> applySmallSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> changeTypeWith: aSkinType in: anElement [
 
	"DefaultType, PrimaryType, LinkType or TextType "
	self type: aSkinType.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - accessing' }
ToAbstractButtonSkinNew >> childSkinsToHandle [
 
	^ {
		  (ToChildSkin new
			   slotName: #icon;
			   skinBuilder: [ :e | self iconSkinIn: e ];
			   yourself).
		  (ToChildSkin new
			   slotName: #label;
			   skinBuilder: [ :e | self labelSkinIn: e ];
			   yourself) }
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> danger [

	^ self type danger
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> danger: aBoolean [
 
	self type danger: aBoolean
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> dashed [
 
	^ self type dashed
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> dashed: aBoolean [
 
	self type dashed: aBoolean
]

{ #category : #'t - reshapeable - initialization' }
ToAbstractButtonSkinNew >> defaultShaping [

	^ ToDefaultShaping new 
]

{ #category : #'t - reshapeable - initialization' }
ToAbstractButtonSkinNew >> defaultSizing [
 
	^ ToMiddleSizing new
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #'event handling' }
ToAbstractButtonSkinNew >> elementLayoutChangedEvent: anEvent [
 
	anEvent currentTarget checkOrientableLayout
	
]

{ #category : #'api - accessing' }
ToAbstractButtonSkinNew >> eventsToHandle [
 
	^ super eventsToHandle , { BlElementLayoutChangedEvent }
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> iconSkinIn: aButton [
 
	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractButtonSkinNew >> initialize [ 
 
	super initialize.
	labelFirst := false.
	self intializeShapingSkin
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> labelSkinIn: aButton [
 
	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractButtonSkinNew >> layoutOrientationChangedEvent: anEvent [
 
	super layoutOrientationChangedEvent: anEvent.
	self applySizingAndShapingOn: anEvent target
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonSkinNew >> onSkinInstalledIn: anElement [
 
	| borderLook backgroundLook |
	super onSkinInstalledIn: anElement.
	self onShapingSkinInstalledIn: anElement.
	" remove the background and the border in case the button type is changing "
	anElement background: Color transparent.
	anElement border: BlBorder empty.
	backgroundLook := self type backgroundLookIn: anElement.
	backgroundLook ifNotNil: [ self addLook: backgroundLook ].
	borderLook := self type borderLookIn: anElement.
	borderLook ifNil: [ ^ self ].
	self addLook: borderLook
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonSkinNew >> onSkinUninstalledIn: anElement [
 
	self onShapingSkinUninstalledIn: anElement.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> type [

	"#default, #primary, #link or #text"
	^ type ifNil: [ type := self defaultType ]
]

{ #category : #accessing }
ToAbstractButtonSkinNew >> type: aSkinType [
 
	"DefaultType, PrimaryType, LinkType or TextType "
	type := aSkinType
]
