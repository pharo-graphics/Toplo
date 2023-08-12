Class {
	#name : #ToToggleTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'switchBar',
		'checked'
	],
	#category : #'Toplo-Widget-Toggle'
}

{ #category : #accessing }
ToToggleTrackElement >> checked [

	^ checked
]

{ #category : #accessing }
ToToggleTrackElement >> checked: aBoolean [

	checked := aBoolean.
	self switchBar checked: aBoolean
]

{ #category : #sliding }
ToToggleTrackElement >> deltaToLeft [
	
	^ (self requestedWidth - self padding width - self switchButton requestedWidth - self switchButton margin left ) negated
]

{ #category : #sliding }
ToToggleTrackElement >> deltaToRight [

	^ self switchButton margin right 
]

{ #category : #initialization }
ToToggleTrackElement >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	switchBar := ToToggleSwitchBarElement new.
	self addChild: switchBar.
	self updateWidth.
	self vFitContent
]

{ #category : #testing }
ToToggleTrackElement >> isChecked [ 

	^ self checked
]

{ #category : #sliding }
ToToggleTrackElement >> slideToLeft [

	| p |
	p := self deltaToLeft.
	self switchBar transformDo: [ :aTransform |
		aTransform translateBy: p @ 0 ]
]

{ #category : #sliding }
ToToggleTrackElement >> slideToRight [

	| p |
	p := self deltaToRight.
	self switchBar transformDo: [ :aTransform |
		aTransform translateBy: p @ 0 ]
]

{ #category : #accessing }
ToToggleTrackElement >> switchBar [

	^ switchBar
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOffContainer [

	^ self switchBar offContainer
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOffElement: anElement [

	self switchBar offElement: anElement.
	self updateWidth
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOnContainer [

	^ self switchBar onContainer
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOnElement [

	^ self switchBar onElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOnElement: anElement [

	self switchBar onElement: anElement.
	self updateWidth
]

{ #category : #accessing }
ToToggleTrackElement >> switchButton [

	^ self switchBar button
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOffElement [

	^ self switchButton offElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOffElement: anElement [

	self switchButton offElement: anElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOnElement [

	^ self switchButton onElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOnElement: anElement [

	self switchButton onElement: anElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonWidth: anInteger [

	self switchButton width: anInteger.
	self updateWidth
]

{ #category : #sliding }
ToToggleTrackElement >> switchOff [

	self slideToLeft.
	self switchButton switchOff
]

{ #category : #sliding }
ToToggleTrackElement >> switchOn [

	self slideToRight.
	self switchButton switchOn
]

{ #category : #initialization }
ToToggleTrackElement >> updateWidth [

	self width: (self switchBar sideWidth + self switchButton requestedWidth + self switchButton margin width + self padding width)
]
