Class {
	#name : #ToButtonSkin,
	#superclass : #ToClickableSkin,
	#traits : 'TToReshapeableWidgetSkin',
	#classTraits : 'TToReshapeableWidgetSkin classTrait',
	#instVars : [
		'type',
		'labelFirst'
	],
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'accessing - structure variables' }
ToButtonSkin class >> type: aButtonType [

	^ self new type: aButtonType 
]

{ #category : #'private children updating' }
ToButtonSkin >> adaptNextChildrenArray: anArray in: anElement [
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
ToButtonSkin >> applyCircleShaping: aShaping on: anElement [

	anElement strategy: ToTripletCenterStrategy new.
	anElement padding: BlInsets empty.
	anElement size: (aShaping sizing heightOn: anElement) asPoint.
	anElement geometry: BlCircleGeometry new
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToButtonSkin >> applyDefaultShaping: aShaping on: anElement [

	| radius |
	self applyRectShaping: aShaping on: anElement.
	radius := aShaping sizing shapingRadiusIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToButtonSkin >> applyLargeSizing: aSizing on: anElement [

	self applySizing: aSizing on: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToButtonSkin >> applyMiddleSizing: aSizing on: anElement [

	self applySizing: aSizing on: anElement
]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToButtonSkin >> applyRoundShaping: aShaping on: anElement [

	| radius |
	self applyRectShaping: aShaping on: anElement.	
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]

{ #category : #'private - shaping/sizing' }
ToButtonSkin >> applySizing: aSizing on: anElement [

	anElement hFitContent.
	anElement layout isOrientable ifTrue: [
		anElement isHorizontal ifFalse: [ ^ anElement vFitContent ] ].
	anElement height: (aSizing heightOn: anElement).

]

{ #category : #'t - reshapeable - private - shaping/sizing' }
ToButtonSkin >> applySmallSizing: aSizing on: anElement [

	self applySizing: aSizing on: anElement
]

{ #category : #accessing }
ToButtonSkin >> changeTypeWith: aSkinType in: anElement [

	"DefaultType, PrimaryType, LinkType or TextType "
	self type: aSkinType.
	self dispatchChangedEventIn: anElement
]

{ #category : #'api - accessing' }
ToButtonSkin >> childSkinsToHandle [

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
ToButtonSkin >> danger [

	^ self type danger
]

{ #category : #accessing }
ToButtonSkin >> danger: aBoolean [

	self type danger: aBoolean
]

{ #category : #accessing }
ToButtonSkin >> dashed [

	^ self type dashed
]

{ #category : #accessing }
ToButtonSkin >> dashed: aBoolean [

	self type dashed: aBoolean
]

{ #category : #'t - reshapeable - initialization' }
ToButtonSkin >> defaultShaping [

	^ ToDefaultShaping new 
]

{ #category : #'t - reshapeable - initialization' }
ToButtonSkin >> defaultSizing [

	^ ToMiddleSizing new
]

{ #category : #accessing }
ToButtonSkin >> iconLookIn: anElement [

	^ self type iconLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> iconSkinIn: aButton [

	^ ToButtonIconSkin new buttonType: self type.

]

{ #category : #initialization }
ToButtonSkin >> initialize [ 

	super initialize.
	labelFirst := false.
	self intializeShapingSkin
]

{ #category : #accessing }
ToButtonSkin >> labelLookIn: anElement [

	^ self type labelLookIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> labelSkinIn: aButton [

	^ ToButtonLabelSkin new buttonType: self type.

]

{ #category : #'event handling' }
ToButtonSkin >> layoutOrientationChangedEvent: anEvent [

	super layoutOrientationChangedEvent: anEvent.
	self applySizingAndShapingOn: anEvent target
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self onShapingSkinInstalledIn: anElement.
	self type onSkinInstalled: self in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onSkinUninstalledIn: anElement [

	self type onSkinUninstalled: self in: anElement.
	self onShapingSkinUninstalledIn: anElement.
	super onSkinUninstalledIn: anElement
]

{ #category : #accessing }
ToButtonSkin >> type [

	"#default, #primary, #link or #text"

	^ type ifNil: [ type := ToButtonDefaultType new ]
]

{ #category : #accessing }
ToButtonSkin >> type: aSkinType [

	"DefaultType, PrimaryType, LinkType or TextType "
	type := aSkinType
]
