Class {
	#name : #ToAbstractButtonSkin,
	#superclass : #ToClickableSkin,
	#traits : 'TToReshapeableWidgetSkin',
	#classTraits : 'TToReshapeableWidgetSkin classTrait',
	#instVars : [
		'type',
		'labelFirst',
		'trux'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'instance creation' }
ToAbstractButtonSkin class >> type: aButtonType [

	^ self new type: aButtonType 
]

{ #category : #'private children updating' }
ToAbstractButtonSkin >> adaptNextChildrenArray: anArray in: anElement [
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
ToAbstractButtonSkin >> applyCircleShaping: aShaping on: anElement [
 
	anElement strategy: ToTripletCenterStrategy new.
	anElement padding: BlInsets empty.
	anElement size: (aShaping sizing heightOn: anElement) asPoint.
	anElement geometry: BlCircleGeometry new
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkin >> applyDefaultShaping: aShaping on: anElement [
 
	| radius |
	self applyRectShaping: aShaping on: anElement.
	radius := aShaping sizing shapingRadiusIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkin >> applyLargeSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkin >> applyMiddleSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkin >> applyRoundShaping: aShaping on: anElement [
 
	| radius |
	self applyRectShaping: aShaping on: anElement.	
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'private - shaping/sizing' }
ToAbstractButtonSkin >> applySizing: aSizing on: anElement [
 
	anElement hFitContent.
	anElement layout isOrientable ifTrue: [
		anElement isHorizontal ifFalse: [ ^ anElement vFitContent ] ].
	anElement height: (aSizing heightOn: anElement).

]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToAbstractButtonSkin >> applySmallSizing: aSizing on: anElement [
 
	self applySizing: aSizing on: anElement
]

{ #category : #accessing }
ToAbstractButtonSkin >> changeTypeWith: aSkinType in: anElement [
 
	"DefaultType, PrimaryType, LinkType or TextType "
	self type: aSkinType.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - accessing' }
ToAbstractButtonSkin >> childSkinsToHandle [
 
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
ToAbstractButtonSkin >> danger [

	^ self type danger
]

{ #category : #accessing }
ToAbstractButtonSkin >> danger: aBoolean [
 
	self type danger: aBoolean
]

{ #category : #accessing }
ToAbstractButtonSkin >> dashed [
 
	^ self type dashed
]

{ #category : #accessing }
ToAbstractButtonSkin >> dashed: aBoolean [
 
	self type dashed: aBoolean
]

{ #category : #'t - reshapeable - initialization' }
ToAbstractButtonSkin >> defaultSizing [
 
	^ ToMiddleSizing new
]

{ #category : #accessing }
ToAbstractButtonSkin >> defaultType [
 
	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractButtonSkin >> elementLayoutChangedEvent: anEvent [
 
	anEvent currentTarget checkOrientableLayout
	
]

{ #category : #'api - accessing' }
ToAbstractButtonSkin >> eventsToHandle [
 
	^ super eventsToHandle , { BlElementLayoutChangedEvent }
]

{ #category : #accessing }
ToAbstractButtonSkin >> iconLookIn: anElement [
 
	^ self type iconLookIn: anElement
]

{ #category : #accessing }
ToAbstractButtonSkin >> iconSkinIn: aButton [
 
	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractButtonSkin >> initialize [ 
 
	super initialize.
	labelFirst := false.
	self intializeShapingSkin
]

{ #category : #accessing }
ToAbstractButtonSkin >> labelLookIn: anElement [
 
	^ self type labelLookIn: anElement
]

{ #category : #accessing }
ToAbstractButtonSkin >> labelSkinIn: aButton [
 
	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractButtonSkin >> layoutOrientationChangedEvent: anEvent [
 
	super layoutOrientationChangedEvent: anEvent.
	self applySizingAndShapingOn: anEvent target
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonSkin >> onSkinInstalledIn: anElement [
 
	super onSkinInstalledIn: anElement.
	self onShapingSkinInstalledIn: anElement.
	self type onSkinInstalled: self in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonSkin >> onSkinUninstalledIn: anElement [
 
	self type onSkinUninstalled: self in: anElement.
	self onShapingSkinUninstalledIn: anElement.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToAbstractButtonSkin >> type [

	"#default, #primary, #link or #text"
	^ type ifNil: [ type := self defaultType ]
]

{ #category : #accessing }
ToAbstractButtonSkin >> type: aSkinType [
 
	"DefaultType, PrimaryType, LinkType or TextType "
	type := aSkinType
]
