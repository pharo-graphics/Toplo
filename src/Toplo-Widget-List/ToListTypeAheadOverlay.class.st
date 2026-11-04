"
I display the current type-ahead pattern in a small badge at the bottom-right corner of a list element.
"
Class {
	#name : #ToListTypeAheadOverlay,
	#superclass : #ToOverlayElement,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-List-TypeAhead'
}

{ #category : #initialization }
ToListTypeAheadOverlay >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self elevation: (BlRelativeElevation elevation: 100).
	label := ToLabel new.
	label constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignBottom ].
	label margin: (BlInsets all: 4).
	self addChild: label
]

{ #category : #accessing }
ToListTypeAheadOverlay >> label [

	^ label
]

{ #category : #initialization }
ToListTypeAheadOverlay >> newRawSkin [

	^ ToListTypeAheadOverlaySkin new
]

{ #category : #accessing }
ToListTypeAheadOverlay >> pattern: aString [

	label text: aString
]
