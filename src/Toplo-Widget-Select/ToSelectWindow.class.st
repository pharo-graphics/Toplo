Class {
	#name : #ToSelectWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #skin }
ToSelectWindow >> installRawStyle [

	super installRawStyle.
	"self padding: (BlInsets
			 horizontal: (self tokenValueNamed: #'padding-content-H')
			 vertical: (self tokenValueNamed: #'padding-content-V'))."
	(self tokenValueNamed: #'animation-window-opening') value: self.
	self border: BlBorder empty.
	self effect: (self tokenValueNamed: #'effect-window')
]
