Class {
	#name : #ToProgressBar,
	#superclass : #ToElement,
	#traits : 'TToProgress',
	#classTraits : 'TToProgress classTrait',
	#instVars : [
		'icon',
		'label',
		'container'
	],
	#category : #'Toplo-Widget-ProgressBar'
}

{ #category : #example }
ToProgressBar class >> example_LinearProgressBarFinite [

	| p |
	p := ToProgressBar new.
	p matchParent.
	p valueInPercentage: 0.75.
	p openInSpace.
	^ p
	
]

{ #category : #example }
ToProgressBar class >> example_LinearProgressBarFiniteWithIcon [

	| p |
	p := ToProgressBar new.
	p matchParent.
	p icon: (ToImage new innerImage: (self iconNamed: #glamorousAccept)).
	p valueInPercentage: 0.75.
	p openInSpace.
	^ p
	
]

{ #category : #example }
ToProgressBar class >> example_LinearProgressBarFiniteWithLabel [

	| p |
	p := ToProgressBar new.
	p matchParent.
	p label: (ToLabel text: '75%').
	p valueInPercentage: 0.75.
	p openInSpace.
	^ p
]

{ #category : #accessing }
ToProgressBar >> container [

	^ container
]

{ #category : #accessing }
ToProgressBar >> container: anObject [

	container := anObject
]

{ #category : #initialization }
ToProgressBar >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #testing }
ToProgressBar >> hasIcon [

	^ self icon notNil
]

{ #category : #testing }
ToProgressBar >> hasLabel [

	^ self label notNil 
]

{ #category : #accessing }
ToProgressBar >> icon [

	^ icon
]

{ #category : #accessing }
ToProgressBar >> icon: anElement [

	anElement = icon ifTrue: [ ^ self ].
	self label: nil.
	icon ifNotNil: [ :s | s removeFromParent].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self addChild: anElement
]

{ #category : #initialization }
ToProgressBar >> initialize [

	super initialize.
	self layout verticalAlignment: BlElementAlignment vertical center.

	progressBar := ToElement new matchParent.
	remainingBar := ToElement new matchParent.
	
	progressBar constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter].
	remainingBar constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter].

	container := ToElement new matchParent.
	container layout: BlFrameLayout new.
	
	container addChild: progressBar.
	container addChild: remainingBar.

	progressBar
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :e | self resizeProgressBar ].

	self addChild: container
]

{ #category : #accessing }
ToProgressBar >> label [

	^ label
]

{ #category : #accessing }
ToProgressBar >> label: anElement [

	anElement = label ifTrue: [ ^ self ].
	self icon: nil.
	label ifNotNil: [ :s | s removeFromParent].
	label := anElement.
	anElement ifNil: [ ^ self ].
	self addChild: anElement
]

{ #category : #skin }
ToProgressBar >> newRawSkin [

	^ ToProgressBarSkin new
]

{ #category : #'t - resizeable' }
ToProgressBar >> resizeProgressBar [

	| w |
	self valueInPercentage ifNil: [ ^ self ].
	w := remainingBar extent x * self valueInPercentage.
	progressBar width: w
]
