Class {
	#name : #ToScrollbarElement,
	#superclass : #BlScrollbarElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'isHorizontal'
	],
	#category : #'Toplo-Core-Scrollbar'
}

{ #category : #factory }
ToScrollbarElement class >> horizontal [

	^ self new
		  horizontal: true;
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
						ifTrue: [ e padding: (BlInsets vertical: 2) ]
						ifFalse: [ e padding: (BlInsets horizontal: 2) ] ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #background)
				with: [ :e | e valueOfTokenNamed: #'scrollbar-background' ] ]
]

{ #category : #factory }
ToScrollbarElement class >> vertical [

	^ self new
		  horizontal: false;
		  yourself
]

{ #category : #configuration }
ToScrollbarElement >> applyConfiguration [

	super applyConfiguration.
	self isHorizontal
		ifTrue: [
				self hMatchParent.
				self vFitContent ]
		ifFalse: [
				self vMatchParent.
				self hFitContent ].
	track horizontal: self isHorizontal.
	thumb horizontal: self isHorizontal.
	pullHandler horizontal: self isHorizontal
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

	| contentLength scrollOffset scrollExtent thumbWeight thumbLeft |
	contentLength := scrollable computeHorizontalScrollRange.
	contentLength isZero ifTrue: [ ^ self ].
	scrollOffset := scrollable computeHorizontalScrollOffset.
	scrollExtent := scrollable computeHorizontalScrollExtent.
	
	self visibility: (contentLength <= scrollExtent 
		ifTrue: [ BlVisibility hidden ]
		ifFalse: [ BlVisibility visible ]).
	
	thumbWeight := (scrollExtent / contentLength) asFloat.
	thumbLeft := (scrollOffset / contentLength) asFloat.
	
	thumb constraintsDo: [ :c | 
		c horizontal matchParent.
		c frame horizontal
			alignLeftAt: thumbLeft;
			weight: thumbWeight ]
]

{ #category : #'private - scrolling' }
ToScrollbarElement >> updateThumbPositionVertically [

	| contentLength scrollOffset scrollExtent thumbWeight thumbTop |
	contentLength := scrollable computeVerticalScrollRange.
	contentLength isZero ifTrue: [ ^ self ].
	scrollOffset := scrollable computeVerticalScrollOffset.
	scrollExtent := scrollable computeVerticalScrollExtent.
	
	contentLength <= scrollExtent 
		ifTrue: [ self visibility: BlVisibility hidden ]
		ifFalse: [ self visibility: BlVisibility visible ].
	
	thumbWeight := (scrollExtent / contentLength) asFloat.
	thumbTop := (scrollOffset / contentLength) asFloat.
	
	thumb constraintsDo: [ :c | 
		c vertical matchParent.
		c frame vertical
			alignTopAt: thumbTop;
			weight: thumbWeight ]
]
