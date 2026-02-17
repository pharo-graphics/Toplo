Class {
	#name : #ToCircularMenuWindow,
	#superclass : #ToMenuWindow,
	#traits : 'TToAnnulusCircularLayoutUser',
	#classTraits : 'TToAnnulusCircularLayoutUser classTrait',
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #configuration }
ToCircularMenuWindow >> applyConfiguration [

	super applyConfiguration.
	self extent: (self layoutRadius * 2) asPoint
]

{ #category : #'t - relayoutable window element - accessing' }
ToCircularMenuWindow >> correctedPositionAccordingToAnchorRoot [

	" no correction for circular window "
	^ self measuredPosition
]

{ #category : #skin }
ToCircularMenuWindow >> newRawSkin [ 

	^ ToCircularMenuWindowSkin new
]
