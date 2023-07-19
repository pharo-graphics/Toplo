Class {
	#name : #ToToggleSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> buttonIconChanged: anEvent [

	anEvent currentTarget icon ifNil: [ ^ self ].

]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> buttonLabelChanged: anEvent [

	anEvent currentTarget label ifNil: [ ^ self ].

]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> setupTrackElementIn: anElement [

	" setup the track "

	anElement switchButton size: (self switchButtonSizeIn: anElement).
	anElement switchButton background: Color white.
	anElement switchButton margin: (BlInsets top: 2 left: 3 bottom: 2 right: 3).
	anElement track geometry: (BlRoundedRectangleGeometry cornerRadius: (self trackBorderRadiusIn: anElement)).
	anElement track padding: (BlInsets all: 2).
	anElement track withSkin: (ToToggleTrackSkin new toggleButton: anElement)

]

{ #category : #accessing }
ToToggleSkin >> subElementsIn: anElement [

	^ ((super subElementsIn: anElement), {  anElement track. anElement label }) reject: [ :e | e isNil ]
]

{ #category : #accessing }
ToToggleSkin >> switchButtonSizeIn: anElement [

	^ 16 asPoint
]

{ #category : #accessing }
ToToggleSkin >> trackBorderRadiusIn: anElement [

	^ 12
]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> whenAddedToSpace: anEvent in: anElement [

	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: (self trackBorderRadiusIn: anElement)).
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
	self setupTrackElementIn: anElement.
	super whenAddedToSpace: anEvent in: anElement
]
