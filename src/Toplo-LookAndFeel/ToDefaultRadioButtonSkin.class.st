Class {
	#name : #ToDefaultRadioButtonSkin,
	#superclass : #ToThemeRadioButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-RadioButton'
}

{ #category : #testing }
ToDefaultRadioButtonSkin class >> type [

	^ #default
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtBackground [ 

	^ self theme colorBgContainer
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtBackgroundHover [ 

	^ self theme colorBgContainer
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtBorder [

	^nil
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtBorderHover [

	^nil
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtCheckedBackground [

	^ self theme colorBgContainer
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtCheckedBackgroundHover [

	^  self theme colorBgContainer
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtCheckedBorder [

	^ (BlBorder paint: self theme colorPrimary width: 5)
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtCheckedBorderHover [

	^ (BlBorder paint: self theme colorPrimary width: 5)
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtCheckedGeometry [

	^ BlCircleGeometry new
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtCheckedMargin [

	^ BlInsets all: 1
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtCheckedSize [ 

	^ 17 asPoint
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtGeometry [

	^ BlCircleGeometry new
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtPadding [ 

	^ BlInsets all: 3
]

{ #category : #built }
ToDefaultRadioButtonSkin >> builtShadow [

	^ BlGaussianShadowEffect
		  color: (self theme colorBorder alphaMixed: 0.233 with: self theme backgroundColor)
		  width: 2
		  offset: 0 @ 2
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedBackground [

	^ self theme colorBgContainer
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedBackgroundHover [

	^  self theme colorBgContainer
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedBorder [

	^ (BlBorder paint: self theme colorBorder width: 1)
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedBorderHover [

	^ (BlBorder paint: self theme colorPrimary width: 1)
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedGeometry [

	^ BlCircleGeometry new
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedMargin [

	^ BlInsets all: 1
]

{ #category : #'private - tokens' }
ToDefaultRadioButtonSkin >> builtUncheckedSize [

	^ 17 asPoint
]

{ #category : #'events - handling' }
ToDefaultRadioButtonSkin >> onInstalledIn: anElement [
	"This method is a hook. Use this method to inject custom or advanced behavior"

	(anElement stateNamed: #checked) whenEnterDo: [ :ann |
		ann widget icon: (ann widget dresser defaultCheckedIconImage: ann widget).
		ann widget isAttachedToSceneGraph ifTrue: [ | op |
			op := ann widget icon innerImage opacity.
			ann widget icon innerImage opacity: 0.1.
			ann widget icon innerImage addAnimation: (BlOpacityAnimation new
					 duration: (ann state counter isZero
							  ifTrue: [ 0 milliSecond ]
							  ifFalse: [ 300 milliSeconds ]);
					 opacity: op;
					 yourself) ] ]
]

{ #category : #'events - handling' }
ToDefaultRadioButtonSkin >> onUninstalledIn: anElement [
	"This method is a hook. Use this method to inject custom or advanced behavior"
]
