Class {
	#name : #ToScrollbarElement,
	#superclass : #BlScrollbarElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'isHorizontal',
		'thumbWeight',
		'thumbTop',
		'thumbLeft'
	],
	#category : #'Toplo-Core-Scrollbar'
}

{ #category : #factory }
ToScrollbarElement class >> horizontal: aBoolean [

	^ self new
		  horizontal: aBoolean;
		  yourself
]

{ #category : #initialization }
ToScrollbarElement class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme addTokenNamed: #'scrollbar-breadth' withValue: 12.

	aTheme
		addTokenNamed: #'scrollbar-background'
		withValue: (Color gray alpha: 0.1).

	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :e |
					e isHorizontal
						ifTrue: [
								e constraintsDo: [ :c |
										c ignoreByLayout.
										c anchors add:
											(c anchors bottomAnchor on: c anchors parent bottomAnchor).
										c anchors add:
											(c anchors leftAnchor on: c anchors parent leftAnchor).
										c anchors add:
											(c anchors widthAnchor on: c anchors parent widthAnchor) ].
								e padding: (BlInsets vertical: 2).
								e vFitContent ]
						ifFalse: [
								e constraintsDo: [ :c |
										c ignoreByLayout.
										c anchors add:
											(c anchors topAnchor on: c anchors parent topAnchor).
										c anchors add:
											(c anchors rightAnchor on: c anchors parent rightAnchor).
										c anchors add:
											(c anchors heightAnchor on: c anchors parent heightAnchor) ].
								e padding: (BlInsets horizontal: 2).
								e hFitContent ] ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #background)
				with: [ :e | e valueOfTokenNamed: #'scrollbar-background' ] ]
]

{ #category : #factory }
ToScrollbarElement class >> vertical: aBoolean [

	^ self horizontal: aBoolean not
]

{ #category : #configuration }
ToScrollbarElement >> applyConfiguration [

	super applyConfiguration.
	track horizontal: self isHorizontal.
	thumb horizontal: self isHorizontal.
	pullHandler horizontal: self isHorizontal.
	self updateThumbPosition
]

{ #category : #initialization }
ToScrollbarElement >> defaultPullHandler [

	^ BlPullHandler new
		  disallowOutOfBounds;
		  yourself
]

{ #category : #'t - orientable' }
ToScrollbarElement >> horizontal: aBoolean [

	isHorizontal = aBoolean ifTrue: [ ^ self ].
	isHorizontal := aBoolean.
	self requestConfiguration
]

{ #category : #initialization }
ToScrollbarElement >> initialize [ 

	super initialize.
	self initializeForToplo.
	self horizontal: false
]

{ #category : #'t - orientable' }
ToScrollbarElement >> isHorizontal [

	^ isHorizontal ifNil: [ isHorizontal := false ]
]

{ #category : #initialization }
ToScrollbarElement >> newDefaultThumb [

	^ ToScrollbarThumbElement new
]

{ #category : #initialization }
ToScrollbarElement >> newDefaultTrack [

	^ ToScrollbarTrackElement new
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> onDraggedThumbBy: aPoint [

	self isHorizontal
		ifTrue: [ self onDraggedThumbHorizontallyBy: aPoint ]
		ifFalse: [ self onDraggedThumbVerticallyBy: aPoint ]
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> onDraggedThumbHorizontallyBy: aPoint [

	| scrollableDelta |
	scrollableDelta := self
		scrollableDeltaFromThumbDelta: aPoint x - dragPosition x
		range: scrollable computeHorizontalScrollRange
		length: self width.

	scrollableDelta isZero ifTrue: [ ^ self ].

	scrollable scrollBy: scrollableDelta negated @ 0.
	dragPosition := aPoint
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> onDraggedThumbVerticallyBy: aPoint [

	| scrollableDelta |
	scrollableDelta := self
		scrollableDeltaFromThumbDelta: aPoint y - dragPosition y
		range: scrollable computeVerticalScrollRange
		length: self height.

	scrollableDelta isZero ifTrue: [ ^ self ].

	scrollable scrollBy: 0 @ scrollableDelta.
	dragPosition := aPoint
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> updateThumbPosition [

	self isHorizontal
		ifTrue: [ self updateThumbPositionHorizontally ]
		ifFalse: [ self updateThumbPositionVertically ]
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> updateThumbPositionHorizontally [

	| contentLength scrollOffset scrollExtent tw tl |
	contentLength := scrollable computeHorizontalScrollRange.
	scrollOffset := scrollable computeHorizontalScrollOffset.
	scrollExtent := scrollable computeHorizontalScrollExtent.

	self visibility: (contentLength <= scrollExtent
			 ifTrue: [ BlVisibility gone ]
			 ifFalse: [ BlVisibility visible ]).

	contentLength isZero ifTrue: [ ^ self ].

	tw := (scrollExtent / contentLength) asFloat.
	tl := (scrollOffset / contentLength) asFloat.
	(thumbWeight = tw and: [ thumbLeft = tl ]) ifTrue: [ ^ self ].
	thumbWeight := tw.
	thumbLeft := tl.
	thumb constraintsDo: [ :c |
			c horizontal matchParent.
			c frame horizontal
				alignLeftAt: thumbLeft;
				weight: thumbWeight ]
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> updateThumbPositionVertically [

	| contentLength scrollOffset scrollExtent tw tt |
	contentLength := scrollable computeVerticalScrollRange.
	scrollOffset := scrollable computeVerticalScrollOffset.
	scrollExtent := scrollable computeVerticalScrollExtent.

	self visibility: (contentLength <= scrollExtent
			 ifTrue: [ BlVisibility gone ]
			 ifFalse: [ BlVisibility visible ]).

	contentLength isZero ifTrue: [ ^ self ].

	tw := (scrollExtent / contentLength) asFloat.
	tt := (scrollOffset / contentLength) asFloat.
	(thumbWeight = tw and: [ thumbTop = tt ]) ifTrue: [ ^ self ].
	thumbWeight := tw.
	thumbTop := tt.
	thumb constraintsDo: [ :c |
			c vertical matchParent.
			c frame vertical
				alignTopAt: thumbTop;
				weight: thumbWeight ]
]
