Class {
	#name : #ToTooltipWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #initialization }
ToTooltipWindow >> initialize [

	super initialize.
	self fitContent.
	self addEventHandler: ToTooltipWindowEventHandler new
]

{ #category : #skin }
ToTooltipWindow >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'padding-content-H')
			 vertical: (self valueOfTokenNamed: #'padding-content-V')).
	(self valueOfTokenNamed: #'animation-window-opening') value: self.
	self effect: (self valueOfTokenNamed: #'effect-window')
]
