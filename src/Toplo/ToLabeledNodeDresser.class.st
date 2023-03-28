Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToNodeDresser,
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	anElement whenLabelChangedDo: [ :curr :prev | self installNewLabel: curr previous: prev in: anElement]
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installNewLabel: curr previous: prev in: anElement [

	prev ifNotNil: [ prev undress ].
	curr addDresser: (ToLabelInNodeDresser new node: anElement; yourself)
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement label ifNotNil: [:l | l undress]
]
