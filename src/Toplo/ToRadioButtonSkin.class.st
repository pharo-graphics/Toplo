Class {
	#name : #ToRadioButtonSkin,
	#superclass : #ToClickableSkin,
	#traits : 'TToCheckableSkin',
	#classTraits : 'TToCheckableSkin classTrait',
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #accessing }
ToRadioButtonSkin >> checkedImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   border: (BlBorder paint: anElement toTheme colorPrimary width: 6);
			   margin: (BlInsets all: 0);
			   background: anElement toTheme colorBgContainer;
			   geometry: BlCircleGeometry new;
			   yourself)
]

{ #category : #accessing }
ToRadioButtonSkin >> defaultType [

	^ ToButtonDefaultType new
]

{ #category : #accessing }
ToRadioButtonSkin >> disabledImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   border: (BlBorder paint: anElement toTheme colorBorderDisabled width: 6);
			   margin: (BlInsets all: 0);
			   geometry: BlCircleGeometry new;
			   background: anElement toTheme colorBgContainer;
			   yourself)
]

{ #category : #accessing }
ToRadioButtonSkin >> iconSkinIn: aButton [

	^ self type radioButtonIconSkinIn: aButton
]

{ #category : #accessing }
ToRadioButtonSkin >> indeterminateImageIn: anElement [

	| bar im |
	bar := BlElement new
		       constraintsDo: [ :c |
			       c horizontal matchParent.
			       c vertical exact: 4.
			       c frame horizontal alignCenter.
			       c frame vertical alignCenter ];
		       border: BlBorder empty;
		       background: anElement toTheme colorPrimary.
	im := BlElement new
		      size: 12 @ 12;
		      margin: (BlInsets all: 2);
				background: (anElement toTheme colorBgContainer alpha: 0);
		      yourself.
	im layout: BlFrameLayout new.
	im addChild: bar.
	^ (ToImage inner: im) 
			geometry: BlCircleGeometry new;
		  	yourself
]

{ #category : #accessing }
ToRadioButtonSkin >> uncheckedImageIn: anElement [

	^ ToImage inner: (BlElement new
			   size: (anElement toTheme controlHeight / 2) asPoint;
			   margin: (BlInsets all: 0);
			   background: (anElement toTheme colorBgContainer alpha: 0);
			   geometry: BlCircleGeometry new;
			   yourself)
]
