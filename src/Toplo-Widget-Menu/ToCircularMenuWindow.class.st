Class {
	#name : #ToCircularMenuWindow,
	#superclass : #ToMenuWindow,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #configuration }
ToCircularMenuWindow >> applyConfiguration [

	super applyConfiguration.
	self extent: (self radius * 2) asPoint
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

{ #category : #accessing }
ToCircularMenuWindow >> radius [

	^ self menuItem radius
]
