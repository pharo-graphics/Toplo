Class {
	#name : 'ToTooltipWindow',
	#superclass : 'ToAnchoredWindow',
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 'accessing' }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : 'initialization' }
ToTooltipWindow >> initialize [

	super initialize.
	self fitContent.
	self addEventHandler: ToTooltipWindowEventHandler new
]

{ #category : 'skin' }
ToTooltipWindow >> installRawStyle [

	super installRawStyle.
	self opacity: 0.
	self background: (self tokenValueNamed: #'color-bg-tooltip').
	(self tokenValueNamed: #'animation-window-tooltip-opening') value: self.
	self effect: (self tokenValueNamed: #'effect-window-tooltip').
	self padding: (BlInsets
			 horizontal: (self tokenValueNamed: #'padding-content-H')
			 vertical: (self tokenValueNamed: #'padding-content-V'))
]
