Class {
	#name : #ToToggleTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'switchBar',
		'checked'
	],
	#category : 'Toplo-Widget-Button-Toggle'
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
	
	^ (self requestedWidth - self padding width - self innerButton requestedWidth - self innerButton margin left ) negated
]

{ #category : #sliding }
ToToggleTrackElement >> deltaToRight [

	^ self innerButton margin right 
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

{ #category : #accessing }
ToToggleTrackElement >> innerButton [

	^ self switchBar innerButton
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
ToToggleTrackElement >> switchButtonOffElement [

	^ self innerButton offElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOffElement: anElement [

	self innerButton offElement: anElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOnElement [

	^ self innerButton onElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonOnElement: anElement [

	self innerButton onElement: anElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchButtonWidth: anInteger [

	self innerButton width: anInteger.
	self updateWidth
]

{ #category : #sliding }
ToToggleTrackElement >> switchOff [

	self slideToLeft.
	self innerButton switchOff
]

{ #category : #sliding }
ToToggleTrackElement >> switchOn [

	self slideToRight.
	self innerButton switchOn
]

{ #category : #initialization }
ToToggleTrackElement >> updateWidth [

	self width: (self switchBar sideWidth + self innerButton requestedWidth + self innerButton margin width + self padding width)
]
