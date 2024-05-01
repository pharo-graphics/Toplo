Class {
	#name : #ToSelectListWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #skin }
ToSelectListWindow >> installRawStyle [

	super installRawStyle.
	(self valueOfTokenNamed: #'animation-window-opening') value: self.
	self border: BlBorder empty.
	self effect: (self valueOfTokenNamed: #'effect-window')
]
