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

{ #category : #accessing }
ToToggleSkin >> subElementsIn: anElement [

	^ ((super subElementsIn: anElement), {  anElement track. anElement label }) reject: [ :e | e isNil ]
]

{ #category : #initialization }
ToToggleSkin >> trackElementIn: anElement [

	| bullet track pusher pWidth onWidth offWidth |
	pusher := ToElement new
			           background: Color white;
			           geometry: BlEllipseGeometry new;
			           vExact: 14;
			           hExact: 14;
			           yourself.
	pWidth := pusher width.
	bullet := ToElement new fitContent; layout: BlLinearLayout horizontal.
	track := anElement newTrackElement.
	track bulletElement: bullet.
	
	track onElement ifNotNil: [ :o |
		bullet addChild: o.
		onWidth := o width.
		o constraintsDo: [ :c | c linear vertical alignCenter ] ].

	bullet addChild: pusher.
	pusher constraintsDo: [ :c | c linear vertical alignCenter ].	
		
	track offElement ifNotNil: [ :o |
		bullet addChild: o.
		offWidth := o width.
		o constraintsDo: [ :c | c linear vertical alignCenter ] ].

	bullet constraintsDo: [ :c | c linear vertical alignCenter ].	

	track geometry: (BlRoundedRectangleGeometry cornerRadius: anElement toTheme borderRadius).
	track withSkin: (ToToggleTrackSkin new toggleButton: anElement).
	track padding: (BlInsets all: 1).
	track addChild: bullet.

	^ track
]

{ #category : #'api - install/uninstall  hook' }
ToToggleSkin >> whenAddedToSpace: anEvent in: anElement [

	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: anElement toTheme borderRadius).
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
	anElement track: (self trackElementIn: anElement).
	self addLook: ToToogleLook new.
	super whenAddedToSpace: anEvent in: anElement
]
