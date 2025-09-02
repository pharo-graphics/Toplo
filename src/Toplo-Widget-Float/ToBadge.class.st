Class {
	#name : #ToBadge,
	#superclass : #ToBaseBadge,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme addTokenNamed: #'badge-horizontal-gap' withValue: 4.
	aTheme addTokenNamed: #'badge-font-size' withValue: 12.
	aTheme addTokenNamed: #'badge-text-foreground' withValue: Color white.

	aTheme
		select: (self asTypeSelector exact: false)
		style: [ " install the font and the text foreground for a label in a badge "
				aTheme when: ToInstallSkinEvent do: [ :e |
						e
							addTokenNamed: #'font-size'
							withValue: (e valueOfTokenNamed: #'badge-font-size').
						e
							addTokenNamed: #'color-text'
							withValue: (e valueOfTokenNamed: #'badge-text-foreground') ].
				aTheme
					when: ToInstallSkinEvent
					write: (aTheme property: #padding)
					with: [ :e |
						BlInsets horizontal:
							(e valueOfTokenNamed: #'badge-horizontal-gap') ] ]
]

{ #category : #initialization }
ToBadge >> defaultBackground [

	^ Color red
]

{ #category : #initialization }
ToBadge >> defaultMinWidth [

	^ 16
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	self minWidth: self defaultMinWidth.
	self background: self defaultBackground 
]

{ #category : #layout }
ToBadge >> onMeasure: anExtentMeasurementSpec [

	| prevHeight |
	prevHeight := self measuredHeight.
	super onMeasure: anExtentMeasurementSpec.
	prevHeight ~= self measuredHeight ifFalse: [ ^ self ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 self measuredHeight - self margin height / 2)
]
