Class {
	#name : #ToSelectWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #skin }
ToSelectWindow >> installRawStyle [

	super installRawStyle.
	(self valueOfTokenNamed: #'animation-window-opening') value: self.
	self border: BlBorder empty.
	self effect: (self valueOfTokenNamed: #'effect-window')
]
