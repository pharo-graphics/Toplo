Class {
	#name : #ToBaseBadge,
	#superclass : #ToAnchoredElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBaseBadge class >> initializeToRawTheme: aTheme [

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

{ #category : #'attaching  / detaching' }
ToBaseBadge >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	anElement addEventHandler: (ToBadgedElementEventHandler new
			 badge: self;
			 yourself)
]

{ #category : #accessing }
ToBaseBadge >> builder: aValuable [

	aValuable value: self
]

{ #category : #initialization }
ToBaseBadge >> defaultOffset [

	^ 10 @ 10
]

{ #category : #initialization }
ToBaseBadge >> defaultPlacement [ 

	^ ToAnchoredAtTopRight new
]

{ #category : #'attaching  / detaching' }
ToBaseBadge >> detachFromElement [

	self referenceElement dispatchEvent: (ToBadgeDetachedEvent new
			 badge: self;
			 yourself).
	self constraintsDo: [ :c | c accountByLayout ]. 

]

{ #category : #'attaching  / detaching' }
ToBaseBadge >> isAttached [

	^ self referenceElement notNil
]
