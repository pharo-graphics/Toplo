Class {
	#name : #ToCircularMenuWindow,
	#superclass : #ToMenuWindow,
	#traits : 'TToAnnulusCircularLayoutUser',
	#classTraits : 'TToAnnulusCircularLayoutUser classTrait',
	#category : #'Toplo-Widget-Circular'
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

{ #category : #testing }
ToCircularMenuWindow >> isOutsideEvent: anEvent [

	^ self manager anchorElement itemList isOutsideEvent: anEvent
]

{ #category : #skin }
ToCircularMenuWindow >> newRawSkin [ 

	^ ToCircularMenuWindowSkin new
]

{ #category : #'t - annulus sector layout user' }
ToCircularMenuWindow >> stateHolder [ 

	^ self itemList
]
