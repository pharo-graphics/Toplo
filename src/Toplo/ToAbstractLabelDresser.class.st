Class {
	#name : #ToAbstractLabelDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #testing }
ToAbstractLabelDresser class >> isAbstract [ 

	^ self = ToAbstractLabelDresser
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> background: aBackground in: anElement [

	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> border: aBorder in: anElement [

	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> initialState: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self initialState: anElement
]
