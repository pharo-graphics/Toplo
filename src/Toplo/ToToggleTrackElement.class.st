Class {
	#name : #ToToggleTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'switchBar'
	],
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #sliding }
ToToggleTrackElement >> deltaToLeft [

	^ self width - self deltaToRight - self switchButton width - self padding left - self padding right - self switchBar margin right
]

{ #category : #sliding }
ToToggleTrackElement >> deltaToRight [

	^ self width - self switchButton position x - self switchButton width - self padding right - self padding left - self switchBar margin right
	

]

{ #category : #initialization }
ToToggleTrackElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	switchBar := ToToggleSwitchBarElement new.
	self addChild: switchBar.
	self fitContent.
	
]

{ #category : #sliding }
ToToggleTrackElement >> slideToLeft [

	| p |
	p := self deltaToLeft.
	self switchBar transformDo: [ :aTransform |
		aTransform translateBy: p negated @ 0 ]
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
ToToggleTrackElement >> switchBar: anElement [

	switchBar := anElement.
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOffElement [

	^ self switchBar offElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOffElement: anElement [

	self switchBar offElement: anElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOnElement [

	^ self switchBar onElement
]

{ #category : #accessing }
ToToggleTrackElement >> switchBarOnElement: anElement [

	self switchBar onElement: anElement
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
