Class {
	#name : #ToToggleSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Button-Toggle-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> barWidthFromTrack: aToggleTrack [

	| but onw offw bw |
	
	onw := 0.
	offw := 0.
	but := aToggleTrack switchButton.
	bw := but width + but margin left + but margin right.
	aToggleTrack switchBarOnElement ifNotNil: [ :o | onw := o width ].
	aToggleTrack switchBarOffElement ifNotNil: [ :o | offw := o width ].
	^ bw + (onw max: offw) max: bw * 1.6
]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> buttonIconChanged: anEvent [

	anEvent currentTarget icon ifNil: [ ^ self ].

]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> buttonLabelChanged: anEvent [

	anEvent currentTarget label ifNil: [ ^ self ].

]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> onSkinInstalledIn: anElement [

	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: (self trackBorderRadiusIn: anElement)).
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
	self setupTrackElementIn: anElement.
	super onSkinInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> setupTrackElementIn: anElement [

	" setup the track "
	anElement switchButton size: (self switchButtonSizeIn: anElement).
	anElement switchButton background: Color white.
	anElement switchButton margin: (BlInsets top: 1 left: 3 bottom: 1 right: 3).
	anElement track geometry: (BlRoundedRectangleGeometry cornerRadius: (self trackBorderRadiusIn: anElement)).
	anElement track padding: (BlInsets all: 1).
	anElement track withSkin: (ToToggleTrackSkin new toggleButton: anElement).
	anElement whenLayoutedDoOnce: [ 
		anElement track width: (self barWidthFromTrack: anElement track)].

]

{ #category : #accessing }
ToToggleSkin >> switchButtonSizeIn: anElement [

	^ 14 asPoint
]

{ #category : #accessing }
ToToggleSkin >> trackBorderRadiusIn: anElement [

	^ 26
]
